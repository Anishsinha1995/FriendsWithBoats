public class ContactSearch {
    
    public static List<Contact> searchForContacts (String name, String mailing) {
        List<Contact> contactList = [SELECT name, ID from Contact where name =: name
                                    OR MailingPostalCode =: mailing];
        
        return contactList;
        
    }

}