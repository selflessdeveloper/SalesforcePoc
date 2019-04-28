public with sharing class CampingListController {
    @AuraEnabled
    Public static list<Camping_Item__c> getItems()
    {
        return [select id, Name, quantity__c, price__c, packed__c from Camping_Item__c];
    }
    
    @AuraEnabled
    Public static Camping_Item__c saveItem(Camping_Item__c campingItem)
    {
        upsert campingItem;
        return campingItem;
    }
    
    

}