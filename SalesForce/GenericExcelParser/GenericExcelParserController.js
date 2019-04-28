({
    scriptsLoaded : function(component, event, helper) {
        console.log('Scripts Loaded');

    },
    handleFilesChange : function(component, event, helper){
        var files = event.getSource().get("v.files");
        var fileName = files[0].name;
        console.log('filName ' + fileName);
        console.log('Input Files '+JSON.stringify(files));
        var reader = new FileReader();
        reader.onload = function(e) {
            var data = e.target.result;
            var workbook = XLSX.read(data, {
                type: "binary"
            });

            /* DO SOMETHING WITH workbook HERE */
            var first_sheet_name = workbook.SheetNames[1];
            /* Get worksheet */
            var worksheet = workbook.Sheets[first_sheet_name];
            var fileObject = XLSX.utils.sheet_to_json(worksheet, {
                raw: true
            });
            console.log('file Object '+ XLSX.utils.sheet_to_json(worksheet, {
                raw: true
            }));
            component.set('v.propertyNameList',Object.getOwnPropertyNames(fileObject[0]));
            console.log('Property Names ' + component.get('v.propertyNameList'));
            component.set('v.fileObject',fileObject);
            console.log('FILEOBJECT LIST ' + JSON.stringify(component.get('v.fileObject')));
            var options = [];
            var names = component.get('v.propertyNameList');
            for(var item in names){ 
                if(names[item] != '__rowNum__'){              
                var individualPropertyNameObject = {};
                individualPropertyNameObject.label = names[item];
                individualPropertyNameObject.fieldName = names[item];
                console.log('type of ' + typeof fileObject[0][names[item]] + 'for Property ' + names[item]);
                individualPropertyNameObject.type = typeof fileObject[0][names[item]] ;
                options.push(individualPropertyNameObject);
            }
        }
            component.set('v.columns',options);
            component.set('v.data',fileObject);
            if(component.get('v.columns')!=null && component.get('v.data')!=null){
                component.set('v.dataTableReady',true);
            }

        };
    
        // Tell JS To Start Reading The File.. You could delay this if desired
        reader.readAsBinaryString(files[0]);
    },
 
    showInfoSection: function(component,event,helper){
        var infoObjectArray = component.get('v.columnInformation');
        var infoObject = {"columnType":"","columnName":""}
        infoObjectArray.push(infoObject);
        component.set('v.columnInformation',infoObjectArray);
    },
    deleteRow: function(component, event, helper){
        var index = event.getSource().get('v.name');
        var infoObjectArray = component.get('v.columnInformation');
        infoObjectArray.splice(index,1);
        var nullArray = [];
        component.set('v.columnInformation',nullArray);
        component.set('v.columnInformation',infoObjectArray); 
    },
    setColumnDataType: function(component, event, helper){
        var infoObjectArray = component.get('v.columnInformation');
        var index = event.getSource().get('v.name');
        infoObjectArray[index]['columnType'] = event.getParam("value");
        component.set('v.columnInformation',infoObjectArray);
    },
    saveColumnName : function(component,event,helper){
        var index = event.getSource().get('v.name');
        var infoObjectArray = component.get('v.columnInformation');
        infoObjectArray[index]['columnName'] = event.getParam("value");
        component.set('v.columnInformation',infoObjectArray);
    },
    disableAll: function(component, event, helper){
        if(component.get('v.canUploadFile')){
            component.set('v.canUploadFile',false); 
        }
        else{
            component.set('v.canUploadFile',true); 
        }
        
    }

})