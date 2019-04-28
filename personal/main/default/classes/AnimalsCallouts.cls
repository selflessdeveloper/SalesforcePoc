public class AnimalsCallouts {
    public static HttpResponse makeGetCallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            Map<string, Object> result = (Map<String,Object>)Json.deserializeUntyped(response.getBody());
            system.debug(result);
            list<Object> animals =(list <Object>) result.get('animals');
            for(Object animal : animals)
            {
                system.debug(animal);
            }
        }
        return response;
    }
    
    public static HttpResponse makePostCallout(){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('POST');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() != 201)
        {
            System.debug('Error occurred ' + response.getStatus());
        }
        else
        {
            system.debug(response.getBody());
            
        }
        return response;
    }
    
}