@isTest
private class AccountProcessorTest {
	
	@isTest(SeeAllData = true) 
	static void testCountContacts() {
		
		List<Account> listAccountToUpdate = [
											 SELECT
											 		Id
											 FROM
											 		Account
											 WHERE
											 		Id IN 
												 		(
												 			SELECT 
												 					AccountId
												 			FROM
												 					Contact
												 		)
											];

		List<Id> accountIds = new List<Id>();

		for ( Account acc : listAccountToUpdate ) {
			accountIds.add( acc.id );
		}

		Test.startTest();

		AccountProcessor.countContacts( accountIds );

		Test.stopTest();

	}
	
}