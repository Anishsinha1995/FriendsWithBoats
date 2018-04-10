@isTest
public class TestVerifyDate {

    @isTest static void testCheckDateLastDay() {
        Date date1 = Date.newInstance(2017, 02, 12);
        Date date2 = Date.newInstance(2017, 02, 11);
        // Test to check if return last day of month
        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
        Date lastDay = Date.newInstance(date1.year(), date1.month(), totalDays);
        System.AssertEquals(VerifyDate.CheckDates(date1, date2), lastDay);
    }
    
    @isTest static void testCheckIfReturnDate2() {
        Date date1 = Date.newInstance(2017, 02, 11);
        Date date2 = Date.newInstance(2017, 03, 11);
        // Test to check if returns date 2
        System.AssertEquals(VerifyDate.CheckDates(date1, date2), date2);
    }
    
}