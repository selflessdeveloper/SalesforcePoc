public with sharing class ApexServiceComponent {
   
   @AuraEnabled(cacheable = true)
   public static List<string> getFieldSet(String configSettingName, String objectApiName){
       ConfigurationSetting__mdt configSetting = [SELECT value__c FROM ConfigurationSetting__mdt WHERE QualifiedApiName =:configSettingName];
       SObjectType objectType = Schema.getGlobalDescribe().get(objectApiName);
       List<Schema.FieldSetMember> fields = objectType.getDescribe().fieldSets.getMap().get(configSetting.value__c).getFields();
       List<String> fieldApiNames = new List<String>();
       for(Schema.FieldSetMember field : fields){
           fieldApiNames.add(field.getFieldPath());
       }
       if(!fieldApiNames.isEmpty()){
           return fieldApiNames;
       } else {
           return null;
       }
   }
}