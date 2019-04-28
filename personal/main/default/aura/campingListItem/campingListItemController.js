({
	clickCreateItem : function(component, event, helper) {
        var validList = component.find('Campinglistform').reduce(function (validSoFar , inputCmp) {
            inputCmp.showHelpMesssageIfInvalid();
            return validSoFar && inputcmp.get('v.validity').valid;
        }, true)
        
        if(validList)
        {
            var newItems = component.get('v.items');
            var newItem = JSON.parse(JSON.stringify(component.get('v.newItem')));
            newItems.push(newItem);
            component.set("v.items", newItems);
            
            
        }
	}
})