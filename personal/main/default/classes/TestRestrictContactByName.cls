@isTest
private class TestRestrictContactByName {

@isTest static void check1()
{contact conValid= new contact(lastname='Downey');
insert conValid;

contact conInvalid= new contact(lastname='INVALIDNAME');
insert conInvalid;


}


}