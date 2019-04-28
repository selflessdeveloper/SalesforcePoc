@isTest
global class AnimalsCalloutsTest{
    
    @isTest static void testGetCallout()
    {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        HttpResponse result = AnimalsCallouts.makeGetCallout();
        System.assertNotEquals(null, result, 'The call out returned a null response');
        System.assertEquals(200, result.getStatusCode(), 'The returned status code is different');
        System.assertEquals('application/json;charset=UTF-8', result.getHeader('Content-Type'), 'The content type is different');
        Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(result.getBody());
        List<Object> animals = (List<Object>) results.get('animals');
        System.assertEquals(4,animals.size() , 'The expected response is not matching');
        
        
        
        
        
    }
    
    @isTest static void testPostCallout()
    {
        Test.setMock(HttpCallOutMock.class, new AnimalsHttpCalloutMock());
        HttpResponse response = AnimalsCallouts.makePostCallout();
        // Verify that the response received contains fake values
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue ='{"animals": ["cheethah","Tigers","Lions","Panthers"]}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, response.getStatusCode());
    }
    
}