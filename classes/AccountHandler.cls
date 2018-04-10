public class AccountHandler {
    public static Account insertNewAccount (String name) {
        
        Account account = new Account(Name = name);
        
        try {
            insert account;
        } catch (DmlException e) {
            return null;
        }

        return account;
    }
}