Public class StringArrayTest
{
public static list<String> generateStringArray(integer n)
{list<String> strList= new list<String>();
for(integer i=0;i<n;i++)
{String s= 'Test '+i;
strList.add(s);
}
return strList;
}
}