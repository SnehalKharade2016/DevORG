trigger AccountTrigger on Account (before insert) {
	AccountTriggerHandler acc = new AccountTriggerHandler();
	if(Trigger.isBefore && Trigger.isInsert) {
		AccountTriggerHandler.TestHttpCllOut();
	}
}