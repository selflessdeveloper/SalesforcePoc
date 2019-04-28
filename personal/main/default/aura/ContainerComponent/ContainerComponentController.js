({
	createComponent : function(component, event, helper) {
        $A.createComponent('c:accountClaim',{},function(embedcmp,status){
            if(component.isValid() && status === 'SUCCESS'){
                var body = component.get('v.body');
                body.push(embedcmp);
                component.set('v.body',body)
            }
            else{
                console.log("Error");
            }
        });
		
	}
})