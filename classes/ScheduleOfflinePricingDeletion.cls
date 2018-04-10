/**
 * @author: Lucas Oliveira
 * @Date: 03/14/2017
 * @Description: Schedulable class in order to control Offline Pricing Deletion execution.
 * 
 * Class name : ScheduleOfflinePricingDeletion
 * Version: 1.0
 * Modification Log:
 
---------------------------------------------------------------------------------------------------------------------------------
	Developer 										Date									Description
---------------------------------------------------------------------------------------------------------------------------------
   Lucas Oliveira								  03/14/2017							Original Version
  
**/

global class ScheduleOfflinePricingDeletion implements Schedulable {
    
    global void execute(SchedulableContext SC) {	
        
        System.debug('Executing ScheduleOfflinePricingDeletion');
        DeleteOfflinePricingBatch batch = new DeleteOfflinePricingBatch();
        Database.executeBatch(batch);
        
    }
    
}