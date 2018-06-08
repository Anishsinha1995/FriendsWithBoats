({
    // challenge 3 
    doInit : function(component, event, helper) {
        helper.onSearch(component);
    },
    
    // challenge 4    
    doSearch: function(component, event, helper) {
        var params = event.getParam('arguments');
        
        if (params) {
            var boatTypeId = params.boatTypeId;
            component.set("v.boatTypeId", boatTypeId ); // setting the value from the method to the attribute on the component
            helper.onSearch(component);
            // only if synchronous, use a return statement.
            // return boatTypeId;
        }
    },
    
    onBoatSelect : function( component, event, helper ) {
        var updateSelected = event.getParam("boatId");
        
        // challenge 5, setting the value sent by the boat tile, to the parent. The parent will store the value on the
        // selected boat id attribute
        component.set("v.selectedBoatId", updateSelected.boatId);
    }
})