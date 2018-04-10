/**
 * @author: Lucas Oliveira
 * @Date: 03/14/2017
 * @Description: Share offline Prices where active__c field equals true. 
 * 
 * Class name : ShareOfflinePricingBatch
 * Version: 1.0
 * Modification Log:
 
---------------------------------------------------------------------------------------------------------------------------------
	Developer 										Date									Description
---------------------------------------------------------------------------------------------------------------------------------
   Lucas Oliveira								  03/14/2017							Original Version
  
**/

global class ShareOfflinePricingBatch implements Database.Batchable<SObject> {

    /* Selecting all data that should be shared */
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT '
                            +'Id, Ship_State_From__c, Ship_State_To__c, SAP_Channel_Code__c,'
                            +'Active__c '
                            +'FROM Offline_Pricing__c '
                            +'WHERE Active__c = true';
        
        System.debug('ShareOfflinePricingBatch Data Selected to be Shared >>> ' + query);
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Offline_Pricing__c> offlinePricesList) {
        System.debug('Executing ShareOfflinePricingBatch');
        OfflinePricingHandlerSharing.insertOfflinePricingShare(offlinePricesList);
    }       
    
    global void finish(Database.BatchableContext BC) {}
    
}