/**
 * @author: Lucas Oliveira
 * @Date: 03/14/2017
 * @Description: Delete offline Prices where active__c field equals false. 
 * 
 * Class name : DeleteOfflinePricingBatch
 * Version: 1.0
 * Modification Log:
 
---------------------------------------------------------------------------------------------------------------------------------
	Developer 										Date									Description
---------------------------------------------------------------------------------------------------------------------------------
   Lucas Oliveira								  03/14/2017							Original Version
  
**/

global class DeleteOfflinePricingBatch implements Database.Batchable<SObject> {
    
    /* Selecting all data that should be deleted */
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT '
                        + 'Id, '
                        + 'Active__c '
                        + 'FROM Offline_Pricing__c '
                        + 'WHERE Active__c = false';
        
        System.debug('DeleteOfflinePricingBatch Data Selected to be Deleted >>> ' + query);
        	
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Offline_Pricing__c> lstOfflinePrices) {
        System.debug('Executing DeleteOfflinePricingBatch');
        OfflinePricingHandlerDeletion.deleteInactiveOfflinePrices(lstOfflinePrices);
    }    
    
    global void finish(Database.BatchableContext BC) {}
    
}