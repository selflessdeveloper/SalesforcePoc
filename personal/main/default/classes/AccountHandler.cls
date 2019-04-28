public class AccountHandler{
public static account insertNewAccount(String s)
{Account a = new Account(name=s);
try
{insert a; 
return a;
}
catch(DMLException e)
{

return null;
}

}
}