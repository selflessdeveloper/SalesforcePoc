trigger Case_History_Tracking on Case (after update) {
        Set<String> TFSet = new Set<String>();
        for(Tracked_fields__mdt Tfmd: [select Field_Name__c from Tracked_fields__mdt]) {
            TFSet.add(Tfmd.Field_Name__c);
        }
       
                   String oldObjects = JSON.serialize(Trigger.old);
                   String newObjects = JSON.serialize(Trigger.new);
                   CaseHistoryTracking.updateCaseFields(oldObjects,newObjects,System.now(),TFSet);
                   
                
        }