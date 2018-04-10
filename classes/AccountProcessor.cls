public with sharing class AccountProcessor {
	
	@future
	public static void countContacts( List<Id> accountIds ) {

		List<Contact> contactList = [
									  SELECT
									  		 Id,
									  		 AccountId
									  FROM
									  		Contact
									  WHERE
									  		AccountId =: accountIds
									 ];

		Map<String, List<Contact>> mapAccountIdWithContact = new Map<String, List<Contact>>();

		for( Contact contact : contactList ) {

			if ( mapAccountIdWithContact.containsKey( contact.AccountId ) ) {

				mapAccountIdWithContact.get( contact.AccountId ).add( contact );

			} else {

				List<Contact> tempList = new List<Contact>();
				tempList.add( contact );
				mapAccountIdWithContact.put( contact.AccountId, tempList ); 

			}

		}

		List<Account> listAccountToUpdate = new List<Account>();

		for( String key : mapAccountIdWithContact.keySet() ) {

			Account accountToUpdate = new Account();
			accountToUpdate.id = key;
			Integer i = 0;

			if( mapAccountIdWithContact.containsKey( key ) ) {

				for( Contact contact : mapAccountIdWithContact.get( key ) ) {


					accountToUpdate.Number_of_Contacts__c = i ++;

				}

			}

			listAccountToUpdate.add( accountToUpdate );

		}

		if ( listAccountToUpdate.size() > 0) update listAccountToUpdate;

	}
}