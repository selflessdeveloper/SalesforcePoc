public class ContactSearch {

public static list<contact> searchForContacts(String s1, String s2){
list <Contact> conList=[select id,name from contact where lastname=:s1 and MailingPostalCode=:s2];
return conList;
}
}