/**
 * @author: Lucas Oliveira
 * @Date: 03/13/2017
 * @Description: Trigger Utils Class in order to control when trigger should be enabled or not.
 * 
 * Helper Class name : TriggerHelper
 * Version: 1.0
 * Modification Log:
 
---------------------------------------------------------------------------------------------------------------------------------
	Developer 										Date									Description
---------------------------------------------------------------------------------------------------------------------------------
   Lucas Oliveira								  03/13/2017							Original Version
  
**/
public with sharing class TriggerHelper {
    
    private static Boolean triggerEnabled = true;
    
    public static void enableTrigger() {
        triggerEnabled = true;
    }
    public static void disableTrigger() {
        triggerEnabled = false;
    }
    public static Boolean isTriggerEnabled() {
        return triggerEnabled;
    }
    
    /************INSERT SOBJECT************/
    public static void insertObject(SObject obj) {
        Database.insert(obj);
    } 
    
    public static void insertObjectTriggerDisabled(SObject obj) {
        TriggerHelper.DisableTrigger();
        Database.insert(obj);
        TriggerHelper.EnableTrigger();        
    }
    
    public static void insertObjectList(List<SObject> obj) { 
        Database.insert(obj,false);
    }
    
    public static void insertObjectListTriggerDisabled(List<SObject> obj) {
        TriggerHelper.DisableTrigger();
        Database.insert(obj);
        TriggerHelper.EnableTrigger();        
    }
    
    /************UPDATE SOBJECT************/
    public static void updateObject(SObject obj) {
        Database.update(obj);
    }
    
    public static void updateObjectTriggerDisabled(SObject obj) {
        TriggerHelper.DisableTrigger();
        Database.update(obj);
        TriggerHelper.EnableTrigger();
    }
    
    public static void updateObjectList(List<SObject> obj) {
        Database.update(obj,false);
    }
    
    public static void updateObjectListTriggerDisabled(List<SObject> obj) {
        TriggerHelper.DisableTrigger();
        Database.update(obj,false);
        TriggerHelper.EnableTrigger();
    }
    
    /************DELETE SOBJECT************/
    public static void deleteObject(SObject obj) {
        Database.delete(obj);
    }
    
    public static void deleteObjectTriggerDisabled(SObject obj) {
        TriggerHelper.DisableTrigger();
        Database.delete(obj);
        TriggerHelper.EnableTrigger();
    }
    
    public static void deleteObjectList(List<SObject> obj) {
        Database.delete(obj,false);
    }
    
    public static void deleteObjectListTriggerDisabled(List<SObject> obj) {
        TriggerHelper.DisableTrigger();
        Database.delete(obj);
        TriggerHelper.EnableTrigger();
    }
    
}