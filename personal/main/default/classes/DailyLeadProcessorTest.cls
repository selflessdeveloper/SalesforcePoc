@isTest
public class DailyLeadProcessorTest {
     @testSetup
    public static void setup(){
        List<Lead> leadList = new list<Lead>();
        for(integer i = 0;i<200;i++){
            leadList.add(new Lead(company = 'Test Company Inc',status='Open', lastName = 'Test'+i));
            
        }
        insert leadList;
        
    }
    static testmethod void testSchedualable()
    {
       Test.startTest();
        DailyLeadProcessor dlp = new DailyLeadProcessor();
        String CRON_EXP = '0 0 0 15 3 ? 2022';
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,dlp);
        Test.stopTest();
         List<Lead> leadList = [SELECT id,LeadSource from Lead where LeadSource = 'Dreamforce' LIMIT 200];
        System.assertEquals(200,leadList.size());
    }
}