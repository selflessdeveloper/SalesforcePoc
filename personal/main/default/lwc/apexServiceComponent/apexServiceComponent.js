import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ['Contact.Name', 'Contact.Title', 'Contact.LastName', 'Contact.Phone'];
export default class ApexServiceComponent extends LightningElement {


     @api
     recordId;

     @wire(getRecord,{recordId:'$recordId',fields: FIELDS})
     contact;

     get name(){
         return this.contact.data.fields.Name.value;
     }

     get title(){
         return this.contact.data.fields.Title.value;
     }

     get lastName(){
         return this.contact.data.fields.LastName.value;
     }

     get phone(){
         return this.contact.data.fields.Phone.value;
     }

}