public class ResponseWrapper{
        @AuraEnabled
        public string data;       
        @AuraEnabled
        public boolean status;  
        @AuraEnabled
        public string errorMessage;       
        public ResponseWrapper(){}      
        public ResponseWrapper(String data, Boolean status, string errorMessage){
            this.data = data;
            this.status = status;
            this.errorMessage = errorMessage;
        }
    }