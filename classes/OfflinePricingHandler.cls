public with sharing class OfflinePricingHandler implements InterfaceTrigger {   
    
    private List<Offline_Pricing__c> newMap;
    private List<Offline_Pricing__c> oldMap;
    
    private static Boolean recursiveAfter = false;
    
    public OfflinePricingHandler() {
        
        this.newMap = (List<Offline_Pricing__c>) Trigger.New;
        this.oldMap = (List<Offline_Pricing__c>) Trigger.Old;
        
    }
    
    public void bulkBefore() {}
    
    public void bulkAfter() {
        
        if(trigger.isInsert) {
            if(!recursiveAfter) {               
                recursiveAfter = true;
                
                OfflinePricingHandlerActions.activeOfflinePrices(newMap); // Activate new records created on Salesforce; Active flag will handle the records downloaded in the app.
                OfflinePricingHandlerActions.inactiveOfflinePrices(newMap); // Inactive previous offline prices if SAP is running fully data load.
                OfflinePricingHandlerActions.scheduleOfflinePricingDeletion(); // Schedule the Batch class that will be handling the offline pricing deletion based on "Active__c" field.
                OfflinePricingHandlerActions.scheduleOfflinePricingSharing(); // Schedule the Batch class that will be handling the offline pricing deletion based on "Active__c" field.

            }	
        }
        
        if(trigger.isDelete) {
            if(!recursiveAfter) {
                recursiveAfter = true;
                
                OfflinePricingHandlerDeletion.deleteOfflineRecordsAndSharing(oldMap); // Delete sharing records for offline pricing.
                
            }
        }
        
    }
    
    public void beforeInsert(SObject so) {}
        
    public void beforeUpdate(SObject oldSo, SObject so) {}
        
    public void beforeDelete(SObject so) {}
        
    public void afterInsert(SObject so)  {}
        
    public void afterUpdate(SObject oldSo, SObject so) {}
        
    public void afterDelete(SObject so) {}
        
    public void andFinally() {}

}