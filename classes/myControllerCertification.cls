public with sharing class myControllerCertification {

	private final Account account;

	public myControllerCertification(ApexPages.StandardController StandardController) {
		account = (Account) StandardController.getRecord();
	}

	public myControllerCertification(SObject obj) {
		account = (Account) obj;
	}
}