trigger Max_Rating on Rating__c (before update, before insert) {

for(Rating__c rat:Trigger.new)
{
if(rat.Rating__c<1 || rat.Rating__c>5){
rat.addError('The Ratings must be between 1 and 5');}
}



}