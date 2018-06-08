({
    onFullDetails : function(component, event, helper) {
        // got this on :
        //  https://salesforce.stackexchange.com/questions/117590/lightning-component-add-an-event-redirecting-to-a-record
        
        // navigating to record detail
        var boat = component.get("v.boat");
        var navEvent = $A.get("e.force:navigateToSObject");
        navEvent.setParams({
            recordId: boat.Id,
            slideDevName: "detail"
        });
        navEvent.fire(); 
    },
    
    doInit : function(component, event, helper) {
        // Disabling the button if navigateToSObject is not available
        // todo: this is not working
        // component.set("v.isEventAvailable", $A.get("e.force:navigateToSObject"));       	
    }
})