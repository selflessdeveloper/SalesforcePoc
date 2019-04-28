global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx){
        List<Lead> leadList = [SELECT id,LeadSource FROM lead where LeadSource = '' or LeadSource = null];
        List<Lead>updatedLeadList = new List<Lead>();
        for(Lead ld : leadList ){
            ld.LeadSource = 'Dreamforce';
            updatedLeadList.add(ld);
        }
        update updatedLeadList;
    }

}