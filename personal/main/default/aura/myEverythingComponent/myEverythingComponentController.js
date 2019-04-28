({
    /**
     * in this function we will set unsaved changes
     * as the user is changing data which should be saved
     * before page close
     * */
    handleDataChange: function(component, event, helper) {
        console.log('executed unsaved');
        //get instance of unsavedChanges component
        var unsavedData = component.find("unsavedData");
        //set unsaved changes which will notify the user about saving the record on page close
        unsavedData.setUnsavedChanges(true, { label: 'You have unsaved changes. Do you want to continue?' });
    },
    
    /**
     * This method executed from save button to save account record to server
     * */
    saveAccount: function(component, event, helper) {
        helper.saveAccount(component);
        //get instance of unsavedChanges component
        var unsavedData = component.find("unsavedData");
        //clear unsaved changes as the user has already saved the record 
        //and should not get any notification
        unsavedData.setUnsavedChanges(false);
    },
    
    /**
     * This method will be called when user click save button from dialog window
     * Save your unsaved changes here
     * */
    saveData: function(component, event, helper) {
        helper.saveAccount(component);
        //get instance of unsavedChanges component
        var unsavedData = component.find("unsavedData");
        //clear unsaved changes as the user has already saved the record 
        //and should not get any notification
        unsavedData.setUnsavedChanges(false);
    },
    
    /**
     * This method will be called when user click discard button from dialog window
     * revert your changes here or perform discard logic
     * */
    discardData: function(component, event, helper) {
        //revert all changes here
    },
    
    doInit: function(component,event,helper){
       component.set('v.nameValue','Changed');
    }
})