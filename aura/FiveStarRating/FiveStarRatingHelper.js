({
    afterScriptsLoaded : function(component, event, helper) {
        // for detailed information on how to get DOM https:
        // //developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/security_dom.htm
        var domEl = component.find("ratingarea").getElement(); //[get dom element of rating area]
        var currentRating = component.get("v.value"); // [get value attribute of component]
        var readOnly = component.get("v.readonly"); //[get readonly attribute of component]
        
        var maxRating = 5;
        var callback = function(rating) {
            component.set('v.value',rating);
        }
        component.ratingObj = rating(domEl,currentRating,maxRating,callback,readOnly); 
    },
    onValueChange: function(component,event,helper) {
        if (component.ratingObj) {
            var value = component.get('v.value');
            component.ratingObj.setRating(value,false);
        }
    }
})