public class ParkLocator {
	public static String[] country(String strCity) {
        ParkService.ParksImplPort objByCountry = new ParkService.ParksImplPort();
        return objByCountry.byCountry(strCity);
    }
}