public class ParkLocator {
	
    public static String[] country(String country) {
        ParkService.ParksImplPort parkService = new ParkService.ParksImplPort();
        return parkService.byCountry(country);
    }
}