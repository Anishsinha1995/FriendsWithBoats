/**
 * @author: Lucas Oliveira
 * @Date: 03/16/2017
 * @Description: Offline Pricing Handler for Sharing Business Rules
 * 
 * Class name : OfflinePricingHandlerSharing
 * Version: 1.0
 * Modification Log:
 
---------------------------------------------------------------------------------------------------------------------------------
	Developer 										Date									Description
---------------------------------------------------------------------------------------------------------------------------------
   Lucas Oliveira								  03/16/2017							   Original Version
  
**/
public with sharing class OfflinePricingHandlerSharing {
    
    public static void insertOfflinePricingShare (List<Offline_Pricing__c> lstOfflinePrices) {

        /* List to address all records and users to be shared */
        List<Offline_Pricing__Share> offlinePricingShareList = new List <Offline_Pricing__Share>();
        
        /* List to address all offline pricing records that will be iterated */
        List<Offline_Pricing__c> offlinePricingList = new List<Offline_Pricing__c>();

        Set<String> setShipStateFrom = new Set<String>();
        Set<String> setShipStateTo = new Set<String>();
        Set<String> setSapChannelCode = new Set<String>();
        
        Map<String, Set<String>> mapOfflinePricing = new Map<String, Set<String>>(); 
        
        for(Offline_Pricing__c offlinePricing : lstOfflinePrices) {
            setShipStateFrom.add(offlinePricing.Ship_State_From__c);
            setShipStateTo.add(offlinePricing.Ship_State_To__c);
            setSapChannelCode.add(offlinePricing.SAP_Channel_Code__c);

            offlinePricingList.add(offlinePricing);
            
            /* Generating the External ID based on the data that indicates how the records will be shared */
            String externalID = offlinePricing.Ship_State_From__c + offlinePricing.Ship_State_To__c + offlinePricing.SAP_Channel_Code__c;
            
            if(mapOfflinePricing.containsKey(externalID)){
                mapOfflinePricing.get(externalID).add(offlinePricing.id);
            } else {
                Set<String> setOfflineId = new Set<String>();
                setOfflineId.add(offlinePricing.Id);
                mapOfflinePricing.put(externalID, setOfflineId);
            }
        }
        
        System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare setShipStateFrom ' + setShipStateFrom);
        System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare setShipStateTo ' + setShipStateTo);
        System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare setSapChannelCode ' + setSapChannelCode);

        System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare mapOfflinePricing >>>>>>> ' + mapOfflinePricing.keySet());
        
        /* Retrieve customer information based on offline data keys : STATE ORIGIN, STATE DESTINY AND SAP CHANNEL CODE */
        List<Customer__c> customerList =  [SELECT Id, State_Origin__c, State_Destiny__c, SAP_Channel_Code__c 
                                           from Customer__c 
                                           where State_Origin__c IN: setShipStateFrom
                                           AND State_Destiny__c IN: setShipStateTo
                                           AND SAP_Channel_Code__c IN: setSapChannelCode];
        
        System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare customerList >>>>>>> ' + customerList);
        System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare customerList.size() >>>>>>> ' + customerList.size());
        
        if(!customerList.isEmpty()) {
            
            Map<String, Set<String>> mapCustomerRecords = new Map<String, Set<String>>();
            
            for(Customer__c customer : customerList) {
                String externalID = customer.State_Origin__c + customer.State_Destiny__c + customer.SAP_Channel_Code__c;
                
                if(mapCustomerRecords.containsKey(externalID)){
                    mapCustomerRecords.get(externalID).add(customer.Id);
                } else {
                    Set<String> setCustomerID = new Set<String>();
                    setCustomerID.add(customer.Id);
                    mapCustomerRecords.put(externalID, setCustomerID);
                }
            }
            
            System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare mapOfflinePricing >>>>>>> ' + mapOfflinePricing.keySet());
            
            List<String> customerIDsList = new List<String>();
            
            for(Set<String> customerIDs : mapCustomerRecords.values()){
                customerIDsList.addAll(customerIDs);
            }
            
            System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare customerIDsList >>>>>>> ' + customerIDsList);
            System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare customerIDsList.size() >>>>>>> ' + customerIDsList.size());
            
            
            List<Outlet_Team__c> outletTeamList = [Select User__c, Customer__c From Outlet_Team__c where Customer__c IN: customerIDsList];

            System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare outletTeamList >>>>>>> ' + outletTeamList);
            
            Map<String, Set<String>> mapCustomerSalesUsers = new Map<String, Set<String>>();
            for(Outlet_Team__c outletTeam : outletTeamList) {

                if(mapCustomerSalesUsers.containsKey(outletTeam.Customer__c)) {
                    mapCustomerSalesUsers.get(outletTeam.Customer__c).add(outletTeam.User__c);
                } else {
                    Set<String> setUserId = new Set<String>();
                    setUserId.add(outletTeam.User__c);
                    mapCustomerSalesUsers.put(outletTeam.Customer__c, setUserId);
                }
            } 
            
            System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare mapCustomerSalesUsers >>>>>>> ' + mapCustomerSalesUsers.keySet());
            
            for(String offlinePricingKey : mapOfflinePricing.keySet()) {	
                
                Set<String> customers = mapCustomerRecords.get(offlinePricingKey);
                Set<String> offlinePricingIDs = mapOfflinePricing.get(offlinePricingKey);
                
                System.debug('customers >>>> ' + customers);
                System.debug('offlinePricingIDs >>>> ' + offlinePricingIDs);  
                
                if (customers != null) {
                    for(String offline: offlinePricingIDs) {
                        for(String account : customers) {
                            Set<String> users = mapCustomerSalesUsers.get(account);
                            
                            System.debug('users >>>>>>> ' + users);
                            if (users != null) {
                                for(String user : users){ 
                                    Offline_Pricing__Share offlinePricingShare = populateOfflinePricingShare(user, offline);
                                    if (offlinePricingShare != null) {
                                        offlinePricingShareList.add(offlinePricingShare);
                                    }
                                }
                            }
                        }
                    }
                }
            }            
        }
        
        System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare offlinePricingShareList.size() >>>>>>> ' + offlinePricingShareList.size());
        System.debug('OfflinePricingHandlerSharing insertOfflinePricingShare offlinePricingShareList >>>>>>> ' + offlinePricingShareList);
        
        if(offlinePricingShareList.size() > 0) { insert offlinePricingShareList; }
    }
    
    /**
     * Method : populateOfflinePricingShare
     * @description populates Offline Pricing Share with records, for insert
     * Param : User Id for sharing with Sales Rep
     * Param : Offline Pricing Id for sharing record
     */ 
    private static Offline_Pricing__Share populateOfflinePricingShare(String user, Id offlinePricing) {
        System.debug('user >>>>>>> ' + user);
        System.debug('offlinePricing record being shared >>>>>>> ' + offlinePricing);
        Offline_Pricing__Share offlinePricingShare = new Offline_Pricing__Share();
        offlinePricingShare.ParentId = offlinePricing;
        offlinePricingShare.UserOrGroupId = user;
        offlinePricingShare.AccessLevel = 'Read';
        return offlinePricingShare;
    }

}