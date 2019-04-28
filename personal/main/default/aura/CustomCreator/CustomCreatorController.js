({
    doInit: function(component,event, helper){
        //loadFieldTypePicklist(component,event,helper);
        return helper.callApexController(component, "getAllObjects", {}, false).then(function(response){
            if(response.status && JSON.parse(response.data)){
                component.set("v.ObjectOptions",JSON.parse(response.data));
                helper.loadFieldTypePicklist(component,event,helper);
            }
        });      
    },
    
    handleChange : function(component, event, helper){
        var selectedItem = event.getParam("value");
        helper.refreshfieldAttributes(component,event,helper);
        component.set("v.SelectedItem",selectedItem);
        console.log(component.get("v.SelectedItem"));
        if(selectedItem == 'Custom Field'){
            component.set("v.showObjectList", true);
            component.set("v.SelectedObject","");
            component.set("v.SelectedField","");
        }
        else{
            component.set("v.showObjectList", false);
        }
        
    },
    
    handleObjectChange: function(component, event, helper){
        var selectedObject = event.getParam("value");
        component.set("v.SelectedObject",selectedObject);   
    },
    
    
    handleFieldSelect : function(component, event, helper){
        component.set("v.showTextRelated",false);
        var selectedField = event.getParam("value");
        component.set("v.SelectedField",selectedField);
        switch(selectedField){
            case 'Text':
            case 'Text Area':
            case 'Text Area (Long)':
            case 'Text Area (Rich)':
                component.set("v.showTextRelated",true);
                break;
        }
    },
    handleClick : function(component ,event, helper){
        helper.createField(component, event, helper);
    },
    handleReferenceObjectChange: function(component, event, helper){
        var selectedObject = event.getParam("value");
        component.set("v.SelectedReferenceObject",selectedObject); 
    }
    
})