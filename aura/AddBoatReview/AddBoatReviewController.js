({
    /*
     * https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/data_service_create_record.htm
     */
    onSave : function(component, event, helper) {
        // Sets the ID
        component.set("v.boatReview.Boat__c", component.get("v.boat.Id"));
        
        component.find("service").saveRecord(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                
                // Success! Prepare a toast UI message
                // TODO : Check if show toast is available, otherwise use an javascript alert
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Review added",
                    "message": "The new review was added."
                });
                
                // Update the UI: close panel, show toast, refresh page (i didnt do exactly what the solution suggested)
                // TODO: instead of using the below function, call the onInit on the helper
                $A.get("e.force:closeQuickAction").fire();
                resultsToast.fire();
                
                // Getting the event
                var reviewAdded = component.getEvent("boatreviewadded");
                
                // Fire the event so the detail component can hear it
                reviewAdded.fire();
                
            } else if (saveResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                console.log('Problem saving contact, error: ' +
                            JSON.stringify(saveResult.error));
            } else {
                console.log('Unknown problem, state: ' + saveResult.state +
                            ', error: ' + JSON.stringify(saveResult.error));
            }
        });
    },
    
    onRecordUpdated : function(component, event, helper) {
        // Record update! Prepare a toast UI message
        /*var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Your Review was successfully added",
            "message": "Feel free to submit new reviews."
        });
        
        // Update the UI: close panel, show toast, refresh review page
        $A.get("e.force:closeQuickAction").fire();
        resultsToast.fire();*/
    },
    
    doInit : function(component, event, helper) {
        helper.onInit(component, event, helper);
    }
})