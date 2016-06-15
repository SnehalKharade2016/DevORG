@isTest
private class ParkLocatorTest {
    @isTest 
    static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        String strCity = 'India';
        String[] strArray = new String[] {'Anamudi Shola National Park', 'Anshi National Park', 'Bandipur National Park'};
        String[] result = ParkLocator.country(strCity);
        // Verify that a fake result is returned
        System.assertEquals(strArray, result); 
    }
}