trigger OrderEventTrigger on Order_Event__e (after insert) {
    list<task> taskList = new List<task>();
    for(Order_Event__e event : Trigger.New){
        if(event.Has_Shipped__c == true){
            task ts = new task(Priority = 'Medium', Subject = 'Follow up on shipped order ' +event.Order_Number__c, OwnerId = event.CreatedById);
            taskList.add(ts);
        }
        insert taskList;

}
}