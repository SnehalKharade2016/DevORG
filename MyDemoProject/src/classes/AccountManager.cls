@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
	
	@HttpGet
    global static Account getAccount() {
       RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accountId = request.requestURI.subString(0 , request.requestURI.lastIndexOf('/'));
		accountId = accountId.substring( accountId.lastIndexOf('/')+1);
        Account result =  [Select a.Name, a.Id, (Select Id, Name From Contacts) From Account a where a.Id =:accountId];
        system.debug('This is for git commit------------------');
        return result;
    }  
}