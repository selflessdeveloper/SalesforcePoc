@isTest
private class AccountManagerTest { 
    @isTest static void testAccountManager() {
        Id recordId = createTestRecord();

        Contact Cont1 = new Contact();
        Cont1.LastName = 'ABC';
        Cont1.AccountId = recordId ;
        insert Cont1;

        Contact Cont2 = new Contact();
        Cont2.LastName = 'XYZ';
        Cont2.AccountId = recordId ;
        insert Cont2 ;

        RestRequest request = new RestRequest();
        request.requestUri =
            'https://{baseurl}/services/apexrest/Accounts/'+recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
       Account lst = AccountManager.getAccount();
       /* Tried to return Contact List but failed Trailhead Verification
       List<Contact> lst = new List<Contact>();
       lst = AccountManager.getAccount();
       */
    }

    static Id createTestRecord() {
        Account accTest = new Account(Name='Test Record');
        insert accTest ;
        return accTest.Id;
    }          

}