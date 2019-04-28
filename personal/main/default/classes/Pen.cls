public class Pen {
String penName;
    static integer penCount = 0;
    public Pen()
    { penCount++;}
    
 public   void displayPenCount()
    {
        system.debug(penCount);
    }
    public void displayName()
    {
        system.debug(penName);
    }
}