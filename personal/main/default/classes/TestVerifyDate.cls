@isTest
public class TestVerifyDate
{
@isTest static void checkCon1()
{
date d1= VerifyDate.CheckDates(system.today(),system.today().addDays(10));
system.assertEquals(date.newInstance(2017,12,31),d1);
}
@isTest static void checkCon2()
{
date d1= VerifyDate.CheckDates(system.today(),system.today().addDays(30));
system.assertEquals(date.newInstance(2017,12,31),d1);
}
}