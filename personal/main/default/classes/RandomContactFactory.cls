public class RandomContactFactory
{ public static list<contact> generateRandomContacts(Integer numOfCon, String Lastname )
{List<Contact> conList= new list<Contact>();
for(Integer i=1;i<=numOfCon;i++)
{
contact c= new contact(firstname='Test '+i, lastname= Lastname);
conList.add(c);
}
return conList;
}

}