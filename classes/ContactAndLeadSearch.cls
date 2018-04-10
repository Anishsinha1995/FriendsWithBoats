public class ContactAndLeadSearch {
    
    public static List<List<sObject>> searchContactsAndLeads(String searchCriteria){
        List<List<sObject>> searchResult  = [FIND :searchCriteria  IN ALL FIELDS
                                             RETURNING Contact(FirstName, LastName, Account.Name 
                                                               WHERE (FirstName =: searchCriteria OR LastName =: searchCriteria)), 
                                             Lead(FirstName, LastName, Company 
                                                  WHERE (FirstName =: searchCriteria OR LastName =: searchCriteria))];
        Return searchResult;
    }
}