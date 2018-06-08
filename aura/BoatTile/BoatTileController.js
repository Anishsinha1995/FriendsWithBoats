({
    onBoatClick : function(component, event, helper) {
        // challenge 4 - used to send the selected boat to the boat search result, in order to change the css
        // Getting the attribute
        var boat = component.get("v.boat");
        
        // Getting the event
        var updateEvent = component.getEvent("BoatSelect");
        
        // Setting the param on the event 
        updateEvent.setParams({ "boatId": {
            "boatId" : boat.Id
            }
        });
            
        // Fire the event so all the components can hear it
        updateEvent.fire();
        
        // challenge 5
        // Getting the event (got the A.get in google)
        var boatSelectedEvent = $A.get("e.c:BoatSelected");
        
        // Setting the param on the event (https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/js_event.htm)
        boatSelectedEvent.setParam("boat", boat);

        // https://developer.salesforce.com/blogs/developer-relations/2017/04/lightning-inter-component-communication-patterns.html
        // Fire the event so all the parent components can hear it
        boatSelectedEvent.fire();
        
        // Challenge 10 - firing the map event
        var plotMapMarker = $A.get("e.c:PlotMapMarker");
        plotMapMarker.setParams({
            "lat"   : boat.Geolocation__Latitude__s,
            "long"  : boat.Geolocation__Longitude__s,
            "label" : boat.Name,
            "SObjectId" : boat.Id});
        plotMapMarker.fire();
    }
})