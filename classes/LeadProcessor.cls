global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(' SELECT ID FROM LEAD ');
	}

   	global void execute(Database.BatchableContext BC, List<Lead> scope) {

   		List<Lead> leadsToUpdate = new List<Lead>();

   		for( Lead lead : scope ) {
			Lead updateLead = new Lead();
			updateLead.id = lead.id;
			updateLead.LeadSource = 'Dreamforce';
			leadsToUpdate.add( updateLead );
   		}

   		update leadsToUpdate;
	
	}
	
	global void finish(Database.BatchableContext BC) {}
	
}