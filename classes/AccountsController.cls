public class AccountsController {

  @AuraEnabled
  public static List<Account> getAccounts() {
  	return [
  			SELECT 
  				 	Id, 
  				 	Name, 
  				 	Industry, 
  				 	Type, 
  				 	NumberOfEmployees, 
  				 	TickerSymbol, 
  				 	Phone
    		FROM 
    			    Account
    	    ORDER BY 
    	    		CreatedDate ASC];
  }

}