public class CaseHistoryTracking {
    @future 
    public static void updateCaseFields(String OldObj, String newObj,datetime changeTime,Set<String> TrackdFields ) {     
    	List<Case> OldCases = (List<Case>) JSON.deserialize(OldObj, List<Case>.class);
        List<Case> NewCases =  (List<Case>)JSON.deserialize(newObj, List<case>.class);
        integer i=0;
        List<Case_History__c> CaseHistory= new List<Case_History__c>();
        for(i=0; i<OldCases.size() && i<NewCases.size();i++) {
        	for(String str: TrackdFields) { 
                if(NewCases[i].get(str)!= OldCases[i].get(str)){
            	Case_History__c CaseHist = new Case_History__c();
                CaseHist.New_Value__c = (String)NewCases[i].get(str);
                CaseHist.Old_Value__c =(String)OldCases[i].get(str);
                CaseHist.Tracked_Field__c=str;
                CaseHist.Created_Date__c= changeTime;
                CaseHist.Case__c = OldCases[i].Id;
                CaseHistory.add(CaseHist);
                }
             }
        }
        insert CaseHistory;
        System.debug('Jarvis'+ ' '+CaseHistory);
     }
 }