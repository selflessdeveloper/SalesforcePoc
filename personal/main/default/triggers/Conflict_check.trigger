trigger Conflict_check on Court_Booking__c (before insert) {
   list<Court_Booking__c> currentBookingList = Trigger.new;
       for(Court_Booking__c a: currentBookingList ) {
           String starttime   = a.Start_Time__c.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'.000+0000\'');
           String endtime  = a.end_Time__c.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'.000+0000\'');
           String dynaQuery = 'select contact__c from Court_Booking__c  where Branch__c =  ';
           dynaQuery +='\'' + a.Branch__c  +'\'' + 'AND ( ' + '  Start_Time__c <=  '  +  starttime   +' AND '  ;
           dynaQuery += '  End_Time__c >=  ' + endtime   + ' ) and ';
            
            string whereclause = '(';
            for(String s:a.Courts__c.split(';')){
                whereclause += '(Courts__c includes ' +  '(\''+s + '\') )' +  ' or ';
            }
            whereClause += ')';
        
            whereclause = whereclause.trim().replace('or )',')').trim();
            dynaQuery  += whereClause;
           system.debug(dynaQuery);
            List<Court_Booking__c> BookedCourtsList  = Database.query(dynaQuery);
            system.debug(dynaQuery);
            system.debug(BookedCourtsList);
             if(BookedCourtsList .size() >0)
                 a.addError('Kindly select a different time, as the preferred court(s) are booked for this time');  
       }
     
}