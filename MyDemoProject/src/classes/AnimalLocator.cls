public with sharing class AnimalLocator {
	
	public static String getAnimalNameById(Integer varId) {
		String strAnimalName;
		HTTP httpObj = new HTTP();
		HttpRequest reqObj = new HttpRequest();
		reqObj.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+varId);
		reqObj.setMethod('GET');
		HttpResponse resObj = httpObj.send(reqObj);
		if(resObj.getStatusCode() == 200) {
			 Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(resObj.getBody());
			 Map<String , Object> animalMap = (Map<String , Object>) resultMap.get('animal');
			 strAnimalName = String.valueOf(animalMap.get('name'));
		}
		return strAnimalName;
	}
}