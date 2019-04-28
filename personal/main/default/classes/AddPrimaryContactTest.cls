@isTest
public class AddPrimaryContactTest {
    @testSetup
    static void setup(){
        List<Account> accList = new List<Account>();
        for( integer i = 0 ; i < 50; i++){
            accList.add(new Account(name='Test'+(i+1),BillingState = 'CA'));
        }
        for(integer i = 0; i < 50 ; i++){
             accList.add(new Account(name='Test'+(i+1),BillingState = 'NY'));
        }
        insert accList;
    }
    
    static testmethod void testQueueable(){
        Contact con = new Contact(lastName = 'test');
        String state = 'CA';
        AddPrimaryContact  apc = new AddPrimaryContact(con, state);
        Test.startTest();
        System.enqueueJob(apc);
        Test.stopTest();
        System.assertEquals(50, [Select count() from Account where BillingState = 'CA']);
    }

}