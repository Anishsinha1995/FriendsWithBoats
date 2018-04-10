@isTest
private class LeadProcessorTest {
	
	@testSetup
	static void setup() {
		
		List<Lead> leadsToInsert = new List<Lead>();

		for (Integer i = 0; i < 200 ; i++ ) {
			Lead newLead = new Lead();
			newLead.LastName = 'Test ' + i;
			newLead.Company = 'Company ' + i;
			leadsToInsert.add( newLead );
		}

		system.debug(leadsToInsert.size());

		insert leadsToInsert;
	}
	
	@isTest static void test_method_two() {
		
		Test.startTest();
		LeadProcessor lpc = new LeadProcessor();
		Id batchId = Database.executeBatch( lpc );
		Test.stopTest();

	}
	
}