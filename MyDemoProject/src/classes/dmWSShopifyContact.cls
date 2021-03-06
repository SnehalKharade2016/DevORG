@RestResource(urlMapping='/shopify/admin/*')
global without sharing class dmWSShopifyContact {

    @HttpPost
    global static void createContact() {

        Map<String,String> resp = new Map<String,String>();
        RestRequest request = RestContext.request;
        system.debug('RestContext.request----------'+request);
        String action = RestContext.request.params.get('action');

    
        String hmacSignature = RestContext.request.headers.get('X-Shopify-Hmac-Sha256');
        System.debug(hmacSignature);

        Blob blobSignature = Crypto.generateMac('hmacSHA256', Blob.valueOf(RestContext.request.requestBody.toString()), Blob.valueOf('e8a73f95b87f91d8272125dbe40f0c6c'));
        //TODO - factor out the shared secret into a custom setting or something..

         System.debug(RestContext.request.requestBody.toString());

        /*if(hmacSignature !=  EncodingUtil.base64Encode(blobSignature)) {
            resp.put('status','ERROR');
            RestContext.response.addHeader('Content-Type', 'application/json');
            RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(resp));
            return;
        }*/
        
        system.debug('RestContext.request.requestBody.toString()-----------'+RestContext.request.requestBody.toString());

        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());

        String email = String.valueOf(m.get('email'));
        
        if(email != null) {
             
            Contact c = null; 

            
            List<Contact> contacts = [select Id from Contact where Email =: email limit 1];
            if(contacts != null && contacts.size() > 0) c = contacts[0];
            else {
                if(action == 'create') {
                    c = new Contact();
                }
            }
       
            if(c != null) {
                c.Email = String.valueOf(m.get('email'));
                c.FirstName = String.valueOf(m.get('first_name'));
                c.LastName = String.valueOf(m.get('last_name')); 
                c.Total_Shopify_Spent__c = Decimal.valueOf(String.valueOf(m.get('total_spent'))) ;
                upsert c;
            }
        }
          	                       
        
        resp.put('status','OK');
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
        RestContext.response.responseBody = Blob.valueOf(JSON.serialize(resp));
    }
}