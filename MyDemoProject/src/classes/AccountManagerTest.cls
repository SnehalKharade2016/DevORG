@isTest
private class AccountManagerTest {

    @isTest 
    static void testGetAccountById() {
        Account recordObj = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://na1.salesforce.com/services/apexrest/Account/'+recordObj.Id+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account accObj = AccountManager.getAccount();
        // Verify results
        System.assert(accObj != null);
        System.assertEquals(1, accObj.contacts.size());
    }
    
    static Account createTestRecord() {
    	Account accObj = new Account(Name = 'TestAccount');
    	insert accObj;
    	Contact conObj = new Contact(LastName = 'TestContact' , AccountId = accObj.Id);
    	insert conObj;
    	return accObj;
    }
}