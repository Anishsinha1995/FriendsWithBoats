/**
 * @author: Lucas Oliveira
 * @Date: 03/16/2017
 * @Description: Offline Pricing Handler for Deleting sharing settings and records
 * 
 * Class name : OfflinePricingHandlerDeletion
 * Version: 1.0
 * Modification Log:
 
---------------------------------------------------------------------------------------------------------------------------------
	Developer 										Date									Description
---------------------------------------------------------------------------------------------------------------------------------
   Lucas Oliveira								  03/16/2017							Original Version
  
**/

public with sharing class OfflinePricingHandlerDeletion {
	
    /**
    * Method Name : deleteOfflineRecordsAndSharing
    * Description : Delete sharing records for offline pricing.
    **/  
    public static void deleteOfflineRecordsAndSharing (List<Offline_Pricing__c> offlinePricingRecords) {
        
        List<Offline_Pricing__Share> lstOfflinePricingToDelete = new List<Offline_Pricing__Share>();
        
        Set<Id> setOfflineRecordsID  = new Set<Id>();
        for(Offline_Pricing__c item : offlinePricingRecords) {
            setOfflineRecordsID.add(item.id);
        }
        
        System.debug('deleteOfflineSharing oldIds : ' + setOfflineRecordsID);
        
        lstOfflinePricingToDelete = retrieveShareRecordsToDelete(setOfflineRecordsID);
        
        if(lstOfflinePricingToDelete != null && lstOfflinePricingToDelete.size() > 0 ){ Database.delete(lstOfflinePricingToDelete);}
        
    }
    
    /*
    * Method Name : deleteInactiveOfflinePrices
    * Description : Delete Inactive offline Prices.
    */
    public static void deleteInactiveOfflinePrices(List<Offline_Pricing__c> offlinePricingRecords) {

        System.debug('OfflinePricingHandlerActions deleteInactiveOfflinePrices OFFLINE PRICING LIST TO BE DELETED >>> : ' + offlinePricingRecords);
        
        OfflinePricingHandlerDeletion.deleteOfflineRecordsAndSharing(offlinePricingRecords); // Delete all sharing records
        
        if(offlinePricingRecords.size() > 0) { delete offlinePricingRecords; }

    }
    
     /**
     * Method : retrieveShareRecordsToDelete
     * @description get Offline Pricing Share
     * Param : Offline Pricing Id for old Records
     */ 
    private static List<Offline_Pricing__Share> retrieveShareRecordsToDelete(Set<Id> offlinePricing) {
        System.debug('retrieveShareRecordsToDelete offline old ID >>>>>>> ' + offlinePricing);
        List<Offline_Pricing__Share> lstOfflinePricingShare = [select Id from Offline_Pricing__Share where ParentId = :offlinePricing and RowCause = 'Manual' LIMIT 10000];
        
        System.debug('records selected offline share >>>>>>> ' + lstOfflinePricingShare);
        if (!lstOfflinePricingShare.isEmpty()) {
            return lstOfflinePricingShare;
        }
        return null;
    } 
    
}