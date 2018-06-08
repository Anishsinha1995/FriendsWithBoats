({
    onInit  : function(component, event, helper) {
        
        // https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/data_service_example.htm
        component.find("service").getNewRecord(
            "BoatReview__c", //objectApiName
            null, //recordTypeId
            false, //skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.newBoatReview");
                var error = component.get("v.recordError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                } else {
                    // setting the id of the boat review
                    rec.Boat__c = component.get("v.boat.Id");
                    component.set('v.boatReview', rec);
                }
            })
        );
        
    }
})