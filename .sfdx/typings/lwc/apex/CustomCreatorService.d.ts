declare module "@salesforce/apex/CustomCreatorService.getAllObjects" {
  export default function getAllObjects(): Promise<any>;
}
declare module "@salesforce/apex/CustomCreatorService.createFields" {
  export default function createFields(param: {FieldAttributeObject: any, Fieldtype: any, selectedObject: any}): Promise<any>;
}
declare module "@salesforce/apex/CustomCreatorService.createItem" {
  export default function createItem(param: {selectedItem: any, selectedItemAttributes: any}): Promise<any>;
}
