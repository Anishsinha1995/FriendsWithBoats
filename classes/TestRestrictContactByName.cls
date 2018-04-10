@isTest
public class TestRestrictContactByName {

    @isTest static void TestContactRestriction() {
        // Test data setup
        // Create an account with an invalid name and try to insert it
        Contact contact = new Contact(LastName = 'INVALIDNAME');
        
        Test.startTest();
        Database.saveResult srList = Database.insert(contact, false);
        Test.stopTest();
        
        System.assert(!srList.isSuccess());
        System.assert(srList.getErrors().size() > 0);

    }
}