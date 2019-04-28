({
	saveAccount : function(component) {
		/************************
         * I am writing dummy code to clear input boxes here,
         * but in real you need to save all unsaved changes here
         ***********************/
        component.find("name").set("v.value", "");
        component.find("phone").set("v.value", "");
	},
    handleDataChange: function(component, event, helper) {
        //get instance of unsavedChanges component
        var unsavedData = component.find("unsavedData");
        console.log('Executed unsaved');
        //set unsaved changes which will notify the user about saving the record on page close
        unsavedData.setUnsavedChanges(true, { label: 'You have unsaved changes. Do you want to continue?' });
    }
})