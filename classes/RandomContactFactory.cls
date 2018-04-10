public class RandomContactFactory {

    public static List<Contact> generateRandomContacts (Integer numberOfContacts, String contactFirstName) {
        
        List<Contact> contacts = new List<Contact>();
        
        for (Integer i = 0; i < numberOfContacts ; i++) {
            Contact c = new Contact(FirstName = contactFirstName + ' ' + i);
            contacts.add(c);
        }
        
        return contacts;
    }
}