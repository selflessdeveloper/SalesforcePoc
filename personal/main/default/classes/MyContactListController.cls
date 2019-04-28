public class MyContactListController {
    @AuraEnabled
    public static list<contact> getContacts(Id recordId){
           return [Select Id, FirstName, LastName, Email, Phone From Contact Where AccountId = :recordId];

    }

}