({
    loadFieldTypePicklist : function(component, event, helper){
        var stringList = ['Auto Number','Formula','Roll-Up Summary','Lookup Relationship','External Lookup Relationship','Checkbox','Currency','Date','Date/Time','Email','Geolocation','Number','Percent','Phone','Picklist','Picklist (Multi-Select)','Text','Text Area','Text Area (Long)','Text Area (Rich)','Time'];
        var optionObjectList = [];
        for(var i = 0; i< stringList.length;i++){
            var optionObject = {'label': stringList[i],
                                'value': stringList[i]
                               };
            optionObjectList.push(optionObject);
        }
        component.set("v.FieldType",optionObjectList);       
    },
    
    refreshfieldAttributes : function(component,event,helper){
        component.set("v.showTextRelated",false);
    },
    
    createField : function(component, event, helper){
        var SelectedItem = component.get("v.SelectedItem");
        switch(SelectedItem){
            case 'Custom Field' :
                var selectedSObject = component.get("v.SelectedObject");
                var selectedFieldType = component.get("v.SelectedField");
                switch(selectedFieldType){
                    case 'Text':
                    case 'Text Area':
                    case 'Text Area (Long)':
                    case 'Text Area (Rich)':
                        var textLabel = component.find("TextLabel").get("v.value");
                        var required = component.find("Required").get("v.value");
                        if(required == ""){
                            required = false;
                        }
                        var maxLength = String(component.find("maxLength").get("v.value"));
                        var textObject = {'label' : textLabel, 'required': required, 'maxLength': maxLength };
                        var action = component.get("c.createFields");
                        return helper.callApexController(component,"createFields",{"FieldAttributeObject":JSON.stringify(textObject),
                                                                                   "Fieldtype":selectedFieldType,
                                                                                   "selectedObject":selectedSObject}, false)
                        .then($A.getCallback(function(response){
                            if(response.status && JSON.parse(response.data)){
                                helper.showToast(component, event, helper);
                            } else{
                                throw this.getErrorResponse(component, "BAD REQUEST");
                            }
                            
                        })).catch(function(response){
                            helper.showErrorToast(component, event, helper);
                            
                        });
                        break; 
                        
                    case 'Number':
                        var fieldLabel = component.find("NumberLabel").get("v.value");
                        var required = component.find("RequiredNumber").get("v.value");
                        if(required == ""){
                            required = false;
                        }
                        var precision = component.find("leftDecimal").get("v.value");
                        var scale = component.find("rightDecimal").get("v.value");
                        var numberObject = {'label':fieldLabel, 'precision':precision,'scale':scale,'required':required };
                        return helper.callApexController(component,"createFields",{"FieldAttributeObject": JSON.stringify(numberObject),
                                                                                   "Fieldtype":selectedFieldType,
                                                                                   "selectedObject": selectedSObject}, false)
                        .then($A.getCallback(function(response){
                            if(response.status && JSON.parse(response.data)){
                                helper.showToast(component, event, helper);
                            } else{
                                throw this.getErrorResponse(component, "BAD REQUEST");
                            }
                            
                        })).catch(function(response){
                            helper.showErrorToast(component, event, helper);
                            
                        });
                        break;
                    case 'Lookup Relationship':
                        var referenceObject = component.get("v.SelectedReferenceObject");
                        var fieldLabel = component.find("lookUpLabel").get("v.value");
                        var childLabel = component.find("ChildLabel").get("v.value");
                        var required = component.find("RequiredLookUp").get("v.value");
                        if(required == ""){
                            required = false;
                            var lookUpObj = {'label':fieldLabel, 'childLabel': childLabel, 'required':required, 'refObject':referenceObject};
                            return helper.callApexController(component,"createFields",{"FieldAttributeObject":JSON.stringify(lookUpObj),
                                                                                       "Fieldtype":selectedFieldType,
                                                                                       "selectedObject": selectedSObject}, false)
                            .then($A.getCallback(function(response){
                                if(response.status && JSON.parse(response.data)){
                                    helper.showToast(component, event, helper);
                                } else{
                                    throw this.getErrorResponse(component, "BAD REQUEST");
                                }
                                
                            })).catch(function(response){
                                helper.showErrorToast(component, event, helper);
                                
                            });
                            break;
                        }
                        
                    default: 
                        helper.showInfoToast(component,event,helper);
                        
                }
                break;
            case 'Apex Class':
                var className = component.find("ApexClassName").get("v.value");
                var classBody = component.find("ApexClassBody").get("v.value");
                var apexClassObject = {'className':className,'classBody':classBody};
                return helper.callApexController(component,"createItem",{"selectedItem": SelectedItem,"selectedItemAttributes":JSON.stringify(apexClassObject)},false)
                .then($A.getCallback(function(response){
                    if(response.status && JSON.parse(response.data)){
                        helper.showToast(component, event, helper);
                    } else{
                        throw this.getErrorResponse(component, "BAD REQUEST");
                    }
                    
                })).catch(function(response){
                    helper.showErrorToast(component, event, helper);
                    
                });
                break;
            default: 
                helper.showInfoToast(component,event,helper);
        }
        
    },
    callApexController: function (component, method, params, isBackground) {
        var action = component.get('c.' + method);
        if (params) {
            action.setParams(params);
        }
        // Batching of Actions
        // Multiple queued foreground actions are batched in a single request (XHR) to minimize network traffic.
        // The batching of actions is also known as boxcar’ing, similar to a train that couples boxcars together.
        // Foreground actions are the default. An action can be marked as a background action i.e by setting the isBackground flag to true
        if (isBackground != undefined && isBackground != null && isBackground != '' && isBackground) {
            action.setBackground(isBackground);
        }
        return new Promise($A.getCallback(function (resolve, reject) {
            action.setCallback(this, function (response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var retVal = response.getReturnValue();
                    
                    if (retVal.status) {
                        resolve(retVal);
                    } else {
                        reject(retVal);
                    }
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) { // To show other type of exceptions
                            reject("Error message: " + errors[0].message);
                        }
                        if (errors[0] && errors[0].pageErrors) { // To show DML exceptions
                            reject("Error message: " + errors[0].pageErrors[0].message);
                        }
                    } else {
                        reject("Unknown error");
                    }
                }
            });
            $A.enqueueAction(action);
        }));
    },
    
    showToast: function(component, event, helper){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The field is created!!"
        });
        toastEvent.fire();
        
    },
    getErrorResponse: function (component, errorMessageString) {
        var errorObject = {
            status: false,
            errormessage: errorMessageString,
            data: undefined
        }
        return errorObject;
    },
    showErrorToast : function(component, event, helper){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            type:'error',
            title : 'ERROR',
            message : 'Bad Request'
        });
        toastEvent.fire();
    },
    showInfoToast : function(component, event, helper){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            type:'info',
            title:'In Development',
            message: 'This functionality is still under development.'
        });
        toastEvent.fire();
    }
    
    
})