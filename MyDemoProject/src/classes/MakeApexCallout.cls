public class MakeApexCallout {

  @InvocableMethod
   public static void invokeapexcallout(list<Account> acc) {
     Futureapexcallout.apexcallout(acc[0].billingstate,acc[0].billingcity,acc[0].id);
   }
}