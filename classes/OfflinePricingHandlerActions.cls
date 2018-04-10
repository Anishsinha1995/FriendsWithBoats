/**
 * @author: Lucas Oliveira
 * @Date: 03/13/2017
 * @Description: Offline Pricing Handler with Actions from Trigger and Business Rules.
 * 
 * Class name : OfflinePricingHandlerActions
 * Version: 1.0
 * Modification Log:
 
---------------------------------------------------------------------------------------------------------------------------------
	Developer 										Date									Description
---------------------------------------------------------------------------------------------------------------------------------
   Lucas Oliveira								  03/13/2017							Original Version
  
**/

public with sharing class OfflinePricingHandlerActions {
    
    /**
    * Method Name : activeOfflinePrices
    * Description : Activate all the new records being created on Salesforce to handle the records that should be downloaded to the app.
    **/
    
    public static void activeOfflinePrices (List<Offline_Pricing__c> offlinePricingRecords) {
        
        List<Offline_Pricing__c> offRecordsToActivate = new List<Offline_Pricing__c>();
        
        for(Offline_Pricing__c offline : offlinePricingRecords) {
            Offline_Pricing__c newOff = new Offline_Pricing__c();
            newOff.id = offline.id;
            newOff.Active__c = true; /* Define active flag = true */
            offRecordsToActivate.add(newOff);
        }
        
        System.debug('OfflinePricingHandlerActions activeOfflinePrices offRecordsToActivate (Records being activated) >>>> ' + offRecordsToActivate);
        
        if(offRecordsToActivate.size() > 0) { update offRecordsToActivate; }
        
    }
    
    /**
    * Method Name : inactiveOfflinePrices
    * Description : Inactive previous offline prices if SAP is running fully data load
    **/
    public static void inactiveOfflinePrices (List<Offline_Pricing__c> offlinePricingRecords) {
        
        Set<DateTime> loadedDate = new Set<DateTime>();
        
        for(Offline_Pricing__c offline : offlinePricingRecords) {
            loadedDate.add(offline.Load_Date__c); 
        }

        /* Retrieving only offline pricing records that has different full date load date, in order to inactive them. */
        List<Offline_Pricing__c> offRecordsToInactivate = [SELECT id, Active__c FROM Offline_Pricing__c WHERE Load_Date__c !=: loadedDate];

        System.debug('OfflinePricingHandlerActions inactiveOfflinePrices offRecordsToInactivate  : ' + offRecordsToInactivate);
        System.debug('OfflinePricingHandlerActions inactiveOfflinePrices offRecordsToInactivate.size()  : ' + offRecordsToInactivate.size());
        System.debug('Test Purpose');

        for(Offline_Pricing__c offToInactive : offRecordsToInactivate) {
            offToInactive.Active__c = false; // Inactivated the old data
        }
        
        if(offRecordsToInactivate.size() > 0) { update offRecordsToInactivate; }
        
    }
    
    /**
    * Method Name : scheduleOfflinePricingDeletion
    * Description : Schedule the Batch class that will be handling the offline pricing deletion based on "Active__c" field.
    **/    
    public static void scheduleOfflinePricingDeletion() {
        
        try {
            
            System.debug('OfflinePricingHandlerActions scheduleOfflinePricingDeletion SCHEDULING DELETION. ');
            
            ID jobId = System.schedule('Schedule Offline Pricing Deletion', '0 05 22 * * ?', new ScheduleOfflinePricingDeletion());
            
            System.debug('OfflinePricingHandlerActions scheduleOfflinePricingDeletion DELETION SCHEDULED. ');
            
        } catch (Exception e) { 
            System.debug('Schedule Job already activated');
            e.getStackTraceString();
        }    
        
    }
    
    /**
    * Method Name : scheduleOfflinePricingSharing
    * Description : Schedule the Batch class that will be handling the offline pricing sharing for Sales Rep that are able to sell offline pricing products
    * based on the customer.
    **/    
    public static void scheduleOfflinePricingSharing() {
        
        try {
            
            System.debug('OfflinePricingHandlerActions scheduleOfflinePricingSharing SCHEDULING SHARING. ');
            
            ID jobId = System.schedule('Schedule Offline Pricing Sharing', '0 05 22 * * ?', new ScheduleOfflinePricingSharing());
            
            System.debug('OfflinePricingHandlerActions scheduleOfflinePricingSharing SHARING SCHEDULED. ');
            
        } catch (Exception e) { 
            System.debug('Schedule Job already activated');
            e.getStackTraceString();
        }    
        
    }

}