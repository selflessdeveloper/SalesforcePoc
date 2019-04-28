public class AddPrimaryContact implements Queueable {
    
    private Contact cont;
    private String state;
    Public AddPrimaryContact(Contact c , String state){
        this.cont = c;
        this.state = state;
    }
    Public void execute(QueueableContext qc){
        List<Account> accounts = [select id,BillingState from Account where BillingState = : state LIMIT 200];
        List<contact> contacts = new List<contact> ();
        for(Account acc : accounts){
            cont.accountId = acc.id;
            cont.lastName = 'Test'+acc.Id;
            contacts.add(new Contact( accountId = cont.accountId,lastName =  cont.lastName ));
        }
        insert contacts;
    }

}