import { LightningElement, api, wire } from 'lwc';
import getFieldSet from '@salesforce/apex/ApexServiceComponent.getFieldSet';

export default class RecordViewComponent extends LightningElement {
    
    @api
    configSetting;//Design attribute, populated in app builder

    @api
    objectApiName; // Set automatically when component is inserted in record page
    
    @api
    recordId;//set automatically when component is inserted in record page
    
    @wire(getFieldSet, { configSettingName: '$configSetting', objectApiName:'$objectApiName'}) fieldSetNames;
}