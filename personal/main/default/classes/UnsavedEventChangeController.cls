public class UnsavedEventChangeController {
    
    @AuraEnabled
    public static void publishPlatformEvent(){
        Browser_Close_Event__e  browserEvent = new Browser_Close_Event__e();
        browserEvent.BrowserClosed__c = true;
        EventBus.publish(browserEvent);
    }

}