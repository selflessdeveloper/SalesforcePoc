@isTest
public class LeadProcessorTest {
    @testSetup
    static void setup(){
        List<Lead> leadList = new List<lead>();
        for(integer i = 0 ; i < 200; i++){ 
            leadList.add(new Lead(status = 'Open', lastName = 'testlead' + (i+1),company = 'Test Company'));
        }
        insert  leadList;
    }
    
    static testmethod void test(){
        Test.startTest();
            LeadProcessor leadProc = new LeadProcessor();
            Id batchId = Database.executeBatch(leadProc);
        Test.stopTest();
        System.assertEquals(200, [select count() from lead where company = 'Test Company']);
    }

}