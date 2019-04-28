public class ContactAndLeadSearch
{public static list<list<SObject>> searchContactsAndLeads(String s)
{
list<list<Sobject>> test=[find :s in all fields returning contact(lastname),lead(lastname)];
return test;
}

}