({
	handleOnSuccess : function(component, event, helper) {
        component.find("notificationsLibrary").showToast({
            'title':'Success',
            'variant':'success',
            'message':'Your claim submitted successfully'

        });
        
    
        $A.get("e.force:closeQuickAction").fire();
}

})