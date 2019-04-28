trigger BrowserCloseEvent on Browser_Close_Event__e (after insert) {
Contact con = [SELECT id from Contact LIMIT 1];
delete con;

}