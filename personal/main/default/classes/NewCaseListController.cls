public class NewCaseListController {
    public list<case> getNewCases()
    {
      list<case> caseList= Database.query('Select id, CaseNumber '+'from Case '+'where Status=\'New\'');
        return caseList;
    }

}