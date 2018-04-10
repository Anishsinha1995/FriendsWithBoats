trigger OfflinePricingTrigger on Offline_Pricing__c (after insert, after update, after delete) {
    
    /* Check if the trigger is enabled before execute it. */
    if(!TriggerHelper.isTriggerEnabled()) { 
        return; 
    } 
    
    TriggerFactory.createhandler(Offline_Pricing__c.sObjectType);
}