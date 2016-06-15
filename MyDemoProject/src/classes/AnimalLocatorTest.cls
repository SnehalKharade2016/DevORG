@isTest
private class AnimalLocatorTest {

    @isTest
    static void AnimalLocator() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
	    // This causes a fake response to be sent
	    // from the class that implements HttpCalloutMock. 
	    String strAnimalName = AnimalLocator.getAnimalNameById(2);
	    system.assertEquals(strAnimalName, 'bear', 'Illegel id specified!');
    }
}