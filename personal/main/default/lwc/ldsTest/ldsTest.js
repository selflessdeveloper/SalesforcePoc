import { LightningElement, track } from 'lwc';

export default class LdsTest extends LightningElement {
    @track greeting = "Manjunatha"; 

    changeValue(event){
        this.greeting = event.greeting;
    }
}