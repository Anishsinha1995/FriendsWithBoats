/**
 * @author: Lucas Oliveira
 * @Date: 03/14/2017
 * @Description: Schedulable class in order to control Offline Pricing Sharing execution.
 * 
 * Class name : ScheduleOfflinePricingSharing
 * Version: 1.0
 * Modification Log:
 
---------------------------------------------------------------------------------------------------------------------------------
	Developer 										Date									Description
---------------------------------------------------------------------------------------------------------------------------------
   Lucas Oliveira								  03/14/2017							Original Version
  
**/

global class ScheduleOfflinePricingSharing implements Schedulable {
    
    global void execute(SchedulableContext SC) {
        
        System.debug('Executing ScheduleOfflinePricingSharing');
        ShareOfflinePricingBatch batch = new ShareOfflinePricingBatch();
        Database.executeBatch(batch);
        
    }

}