global class CustomCreatorService {
    //Save the data into cache since the object list is unlikely to change within the refresh period
    @AuraEnabled(cacheable = true)
    public static ResponseWrapper getAllObjects(){ 
        List<String> sObjectNameList = new List<String>();
        List<sObjectOptionComboboxWrapper> sObjectList = new List<sObjectOptionComboboxWrapper>();       
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            String name = objTyp.getDescribe().getName();
            // Exclude all the unwanted Sobjects e.g. History, Share etc..          
            if(!name.containsignorecase('history') && !name.containsignorecase('tag')&&
               !name.containsignorecase('share') && !name.containsignorecase('feed')){      
                   sObjectNameList.add(name);                  
               }     
        }
        sObjectNameList.sort();       
        for(String name: sObjectNameList){
            sObjectOptionComboboxWrapper wrapper = new sObjectOptionComboboxWrapper(name,name);
            sObjectList.add(wrapper);           
        }
        ResponseWrapper response = new ResponseWrapper(JSON.serialize(sObjectList), true,'');        
        return response;       
    }
    @AuraEnabled
    public static ResponseWrapper createFields(String FieldAttributeObject, String Fieldtype, String selectedObject){
        String finalReqBody;
        ResponseWrapper reponseWrapped = new ResponseWrapper('',true,'');
        switch on Fieldtype{
            when 'Text' {//text field JSON metadata 
                TextFieldWrapper textWrapper = (TextFieldWrapper)JSON.deserialize(FieldAttributeObject, TextFieldWrapper.class);               
                String body = '{"Metadata":{';
                String typeF = '"type":'+'"'+Fieldtype+'"'+',';
                String label = '"label":'+'"'+textWrapper.label+'"'+',';
                String required = 'false';
                if(textWrapper.required){
                    required = 'true'; 
                }
                String requiredBody = '"required":'+required+',';
                String maxLength = '"length":'+textWrapper.maxLength+',';
                String metadataEnd = '"unique":false,"externalId":false,"trackHistory":false,"precision":null},';
                String fullName = '"FullName" :'+'"'+selectedObject+'.'+textWrapper.label.replaceAll(' ','')+'__c'+'"}';
                finalReqBody = body+typeF+label+requiredBody+maxLength+metadataEnd+fullName;
                System.debug('JSONBODY**********' +finalReqBody );
            }
            when 'Number'{//Number field JSON metadata
                String body = '{"Metadata":{';
                String typeF = '"type":'+'"'+Fieldtype+'"'+',';
                NumberFieldWrapper numberObject = (NumberFieldWrapper)JSON.deserialize(FieldAttributeObject, NumberFieldWrapper.class);
                String label = '"label":'+'"'+numberObject.label+'"'+',';
                String required = 'false';
                if(numberObject.required){
                    required = 'true'; 
                }
                String requiredBody = '"required":'+required+',';
                String precision = '"precision":' + numberObject.precision+',';
                String scale = '"scale":' + numberObject.scale+',';
                String metadataEnd = '"unique":false,"externalId":false,"trackHistory":false},';
                String fullName = '"FullName" :'+'"'+selectedObject+'.'+numberObject.label.replaceAll(' ','')+'__c'+'"}';
                finalReqBody = body+typeF+label+requiredBody+precision+scale+metadataEnd+fullName;                
            }           
            when 'Lookup Relationship'{//Look Up Json metadata
                String body = '{"Metadata":{';
                String typeF = '"type":'+'"Lookup"'+',';
                LookUpFieldWrapper lookUpObj = (LookUpFieldWrapper)JSON.deserialize(FieldAttributeObject, LookUpFieldWrapper.class);
                String label = '"label":'+'"'+lookUpObj.label+'"'+',';
                String required = 'false';
                if(lookUpObj.required){
                    required = 'true'; 
                }
                String requiredBody = '"required":'+required+',';
                String referenceTo = '"referenceTo":' + '"'+lookUpObj.refObject + '"'+',';
                String relationshipLabel = '"relationshipLabel":' + '"'+lookUpObj.childLabel + '"'+',';
                String relationshipName = '"relationshipName":' + '"'+lookUpObj.childLabel + '"'+',';
                String metadataEnd = '"unique":false,"externalId":false,"trackHistory":false},';
                String fullName = '"FullName" :'+'"'+selectedObject+'.'+lookUpObj.label.replaceAll(' ','')+'__c'+'"}';
                finalReqBody = body+typeF+label+requiredBody+referenceTo+relationshipLabel+relationshipName+metadataEnd+fullName;                
            }
        }
        System.debug(finalReqBody);
        String sObjectName = 'CustomField/';
        String method = 'POST';
        HttpResponse response = callOut(finalReqBody,sObjectName,method);
        if(response.getStatusCode() != 201){
            System.debug('Unexpected Staus Code: ' +response.getStatusCode() + ' ' + response.getStatus());
        }else{
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug('Id :' +String.valueOf(results.get('id')));
            reponseWrapped.data = JSON.serialize(results.get('id'));
        }        
        return reponseWrapped;   
    }
    
    @AuraEnabled
    public static ResponseWrapper createItem(String selectedItem, String selectedItemAttributes){
        ResponseWrapper responseWrapper = new ResponseWrapper('',true,'');
        switch on selectedItem{
            when 'Apex Class'{
                ApexClassWrapper apexClsWrpper = (ApexClassWrapper)JSON.deserialize(selectedItemAttributes, ApexClassWrapper.class);
                String body = '{ "Name" : "' +apexClsWrpper.className+'","Body": "'+apexClsWrpper.classBody+'"}';
                String sObjectName = 'ApexClass';
                String method = 'POST';
                System.debug('BODY***********'+body);
                HttpResponse response = callOut(body,sObjectName,method);
                if(response.getStatusCode() != 201){
                    System.debug('Unexpected Staus Code: ' +response.getStatusCode() + ' ' + response.getStatus());
                }else{
                    Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                    System.debug('Id :' +String.valueOf(results.get('id')));
                    responseWrapper.data = JSON.serialize(results.get('id'));
                }                       
            }           
        }
        return responseWrapper;
    }
    global static HttpResponse callOut(String body, String sObjectName, String method){
        Http http = new Http();
        HttpRequest req = new HttpRequest();  
        //make call out as a connected app
        req.setEndpoint('callout:CustomCreator/services/data/v44.0/tooling/sobjects/'+sObjectName);  
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setMethod(method);
        req.setBody(body);
        HttpResponse response = http.send(req);
        return response;               
    }    
    public class sObjectOptionComboboxWrapper {
        @AuraEnabled
        public string label;
        @AuraEnabled
        public string value;        
        public sObjectOptionComboboxWrapper(){}        
        public sObjectOptionComboboxWrapper(String label, String value){
            this.label = label;
            this.value = value;
        }
    }
    
    public class TextFieldWrapper {
        @AuraEnabled
        public string label;
        @AuraEnabled
        public boolean required;
        @AuraEnabled 
        public string maxLength;        
        public TextFieldWrapper(){}
        public TextFieldWrapper(String label, boolean required, string maxLength){
            this.label = label;
            this.required = required;
            this.maxLength = maxLength;            
        }
    }
    
    public class NumberFieldWrapper{
        @AuraEnabled
        public string label;
        @AuraEnabled
        public boolean required;
        @AuraEnabled
        public integer precision;
        @AuraEnabled
        public integer scale;
        
        public NumberFieldWrapper(){}
        public NumberFieldWrapper(String label, Integer precision, Integer scale, boolean required){
            this.label = label;
            this.precision = precision;
            this.scale = scale;
            this.required = required;
        }        
    }
    
    public class LookUpFieldWrapper{
        @AuraEnabled
        public string label;
        @AuraEnabled
        public string childLabel;
        @AuraEnabled
        public string refObject;
        @AuraEnabled
        public boolean required;
        
        public LookUpFieldWrapper(){}
        public LookUpFieldWrapper(String label, String childLabel, String refObject, boolean required){
            this.label = label;
            this.childLabel = childLabel;
            this.refObject = refObject;
            this.required = required;
        }        
    }
    
    public class ApexClassWrapper{
        @AuraEnabled
        public string className;
        @AuraEnabled
        public string classBody;
        
        public ApexClassWrapper(){}
        public ApexClassWrapper(String className, String classBody){
            this.className = className;
            this.classBody = classBody;
        }
        
    }
}