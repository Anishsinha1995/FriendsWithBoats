public with sharing class BoatSearchResults {
    
    @AuraEnabled
    public static List<Boat__c> getBoats( String boatTypeId ) {
        if (boatTypeId == null || boatTypeId == '') {
            return [ SELECT Name, Picture__c  FROM Boat__c ];            
        }
        return [ SELECT Name, Picture__c  FROM Boat__c WHERE ID =: boatTypeId ];
    }
    
}