@isTest
private class ParkLocatorTest {
    
    @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String country = 'India';
        String[] result = ParkLocator.country(country);
        // Verify that a fake result is returned
        System.assertEquals(result.size() > 0, true);
        System.assertEquals('India', result[0]); 
    }
}