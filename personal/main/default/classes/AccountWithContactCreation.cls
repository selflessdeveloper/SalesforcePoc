@istest
public class AccountWithContactCreation {
    public static List<Account> AccWithContacts(Integer NumberOfAccs, Integer ContactsPerAccs)
    {
        List<Account>  accList = new List<Account> ();
        for(integer i=0 ; i< NumberOfAccs ;i ++ )
        {
            Account ac = new Account(Name='testAcc'+i);
            accList.add(ac);
        }
        insert accList;
        List<Contact> conList = new List<Contact>();
        for(integer j=0; j < NumberOfAccs; j++)
        {
            Account acc = accList[j];
            for(integer k=0;k<ContactsPerAccs;k++)
            {
                Contact ct = new Contact(lastName='Manju'+k,AccountId=acc.Id );
                conList.add(ct);
            }
        }
        insert conList;
        return accList;
    }

}