@isTest
global class AnimalsHttpCalloutMock implements HttpCalloutMock {
    Global HttpResponse respond(HttpRequest request)
    {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animals": ["cheethah","Tigers","Lions","Panthers"]}');
        response.setStatusCode(200);
        return response;
        
        
    }
}