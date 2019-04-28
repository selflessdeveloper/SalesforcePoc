trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
list<task> TskList= new list <task>();
for(opportunity opp: trigger.new)
{if(opp.StageName=='Closed Won')
{task tsk= new task();
tsk.Subject='Follow Up Test Task';
tsk.WhatId= opp.id;
TskList.add(tsk);

}
}
insert TskList;

}