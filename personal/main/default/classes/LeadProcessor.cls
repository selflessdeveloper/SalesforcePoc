global class LeadProcessor implements Database.Batchable<sObject> {
    Global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id, LeadSource ' + 'from lead');
    }
    
    Global void execute(Database.BatchableContext bc, List<lead> LeadList)
    {  List<Lead> ldlist = new List<lead> ();
        for(Lead ld: LeadList)
        {
            ld.LeadSource='Dreamforce';
            ldlist.add(ld);
        } 
     update ldlist;
    }
    
    global void finish(Database.BatchableContext bc){
        
         AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    }

}