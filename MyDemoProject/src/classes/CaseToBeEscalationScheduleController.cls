public with sharing class CaseToBeEscalationScheduleController {
    public Case caseObj {get; set;}
    public List<String> ownerId;   
    public String strMonthDay {get; set;}
    public String strSelectedFrequency {get; set;}
    public List<SelectOption> lstFrequenyOptions {get; set;}
    public List<SelectOption> selectListDayValue {get; set;}
    public List<String> lstEmailAddress ;     
    public boolean blnIsSunday {get; set;}
    public String strSunday {get; set;}
    public boolean blnIsMonday {get; set;}
    public String strMonday {get; set;}
    public boolean blnIsTuesday {get; set;}
    public String strTuesday {get; set;}
    public boolean blnIsWednesday {get; set;}
    public String strWednessday {get; set;}
    public boolean blnIsThursday {get; set;}
    public String strThursday {get; set;}
    public boolean blnIsFriday {get; set;}
    public String strFriday {get; set;}
    public boolean blnIsSaturday {get; set;}
    public String strSaturday {get; set;}
    
    public String selectedValueforMonthDay {get; set;}
    public String selectedValueForMonthWeek {get; set;}
    public String strMonthWeek {get; set;}
    public List<selectOption> lstMonthWeek {get; set;}
    public List<selectOption>  lstMonthDays {get; set;} 
    public String strSelectedMonthlyOnday {get; set;}    
    
    public String strPrefStartTime {get; set;}
    public List<SelectOption> lstPrefStartTime {get; set;}
    public List<SelectOption> selectedOptions {get; set;}
    public String strDayValue {get; set;}
    public String strEmailTo {get; set;}       
    public String selectedFrequencyValue  { get {return selectedFrequencyValue;} 
                                            set {selectedFrequencyValue=value;} 
                                          }
    public boolean isDisabledMonthDay {get; set;}
    public boolean isDisabledWeekDay {get; set;} 
    public boolean isActive{get;set;}    
    public boolean isSchedulerBlock{get;set;}
    public String CRON_EXP;
    public String jobId;         
    public List<String> projIds;
    public String errorMsg;//public error msg to check error against report scheduling
    private String selectedDateRange;  
    List<String> selectedOwners; 
    public String strSelectedOwnerValue;            
    public CaseToBeEscalationScheduleController () {
        
        caseObj = new Case();              
        projIds = new List<String>();
        selectedOwners = new List<String>();
        lstPrefStartTime = new List<SelectOption> ();
        selectListDayValue = new List<SelectOption> ();
        lstMonthWeek = new List<SelectOption> ();
        selectedOptions = new List<SelectOption>();
        lstMonthDays =  new List<SelectOption>();
        selectedOptions.add(new SelectOption('Daily','Daily'));
        selectedOptions.add(new SelectOption('Weekly','Weekly'));
        selectedOptions.add(new SelectOption('Monthly','Monthly'));
        strSunday = 'Sunday' ;
        strMonday = 'Monday' ;
        strTuesday = 'Tuesday' ;
        strWednessday = 'Wednessday' ;
        strThursday = 'Thursday' ;
        strFriday = 'Friday' ;
        strSaturday = 'Saturday' ;
        isSchedulerBlock = true;
        isDisabledMonthDay = false;
        isDisabledWeekDay = true;
        
        selectedValueforMonthDay = 'MonthDayValue'; 
        selectedValueForMonthWeek = '';
        caseObj.From_Date__c = Date.today(); 
        selectedDateRange = ApexPages.currentPage().getParameters().get('dateRange');                                   
        //String pids = ApexPages.currentPage().getParameters().get('projectIds');
        String pids = 'a002800000ai49u'; 
        strSelectedOwnerValue = ApexPages.currentPage().getParameters().get('strCaseOwner');
        String ownerId = ApexPages.currentPage().getParameters().get('ownerIds');
        //if(ownerId != null && ownerId != '') {
        if(String.isNotBlank(ownerId) ) {
            selectedOwners.addAll(ownerId.split(','));
        }   
        
       // if(pids != null && pids !=''){  
        if(String.isNotBlank(pids)){      
            projIds.addAll(pids.split(','));
        }   
        selectedFrequencyValue = 'Daily';                                                 
    }   
    public void disableMonthDay() {
        if(selectedValueforMonthDay.equals('MonthDayValue')) {
            selectedValueForMonthWeek = '';
            isDisabledMonthDay = false;
            isDisabledWeekDay = true;
        }       
    }   
    public void disableWeekDay() {
        if(selectedValueForMonthWeek.equals('MonthWeekValue')) {
            selectedValueforMonthDay = '';
            isDisabledWeekDay = false;
            isDisabledMonthDay = true;
        }       
    }   
    public void setComponentValues() {
        //lstPrefStartTime.add(new selectOption('None','-None-'));
        lstPrefStartTime.add(new selectOption('0','12:00 AM'));
        lstPrefStartTime.add(new selectOption('1','1:00 AM'));
        lstPrefStartTime.add(new selectOption('2','2:00 AM'));
        lstPrefStartTime.add(new selectOption('3','3:00 AM'));
        lstPrefStartTime.add(new selectOption('4','4:00 AM'));
        lstPrefStartTime.add(new selectOption('5','5:00 AM'));
        lstPrefStartTime.add(new selectOption('6','6:00 AM'));
        lstPrefStartTime.add(new selectOption('7','7:00 AM'));
        lstPrefStartTime.add(new selectOption('8','8:00 AM'));
        lstPrefStartTime.add(new selectOption('9','9:00 AM'));
        lstPrefStartTime.add(new selectOption('10','10:00 AM'));
        lstPrefStartTime.add(new selectOption('11','11:00 AM'));
        lstPrefStartTime.add(new selectOption('12','12:00 PM'));
        lstPrefStartTime.add(new selectOption('13','1:00 PM'));
        lstPrefStartTime.add(new selectOption('14','2:00 PM'));
        lstPrefStartTime.add(new selectOption('15','3:00 PM'));
        lstPrefStartTime.add(new selectOption('16','4:00 PM'));
        lstPrefStartTime.add(new selectOption('17','5:00 PM'));
        lstPrefStartTime.add(new selectOption('18','6:00 PM'));
        lstPrefStartTime.add(new selectOption('19','7:00 PM'));
        lstPrefStartTime.add(new selectOption('20','8:00 PM'));
        lstPrefStartTime.add(new selectOption('21','9:00 PM'));
        lstPrefStartTime.add(new selectOption('22','10:00 PM'));
        lstPrefStartTime.add(new selectOption('23','11:00 PM'));
        for(Integer i = 1; i<=31;i++) {
           selectListDayValue.add(new selectOption(String.valueOf(i),String.valueOf(i)));
        }
        selectListDayValue.add(new selectOption('32','Last'));        
        lstMonthWeek.add(new selectOption('1','Sunday'));
        lstMonthWeek.add(new selectOption('2','Monday'));
        lstMonthWeek.add(new selectOption('3','Tuesday'));
        lstMonthWeek.add(new selectOption('4','Wednessday'));
        lstMonthWeek.add(new selectOption('5','Thursday'));
        lstMonthWeek.add(new selectOption('6','Friday'));
        lstMonthWeek.add(new selectOption('7','Saturday'));
        
        lstMonthDays.add(new selectOption('1','the 1st'));
        lstMonthDays.add(new selectOption('2','the 2nd'));
        lstMonthDays.add(new selectOption('3','the 3rd'));
        lstMonthDays.add(new selectOption('4','the 4th'));
        lstMonthDays.add(new selectOption('5','the last'));     
    }   
    private String validateData(){      
        String msg = '';
        Integer status = 0; 
        
      //  if(selectedFrequencyValue == null || selectedFrequencyValue == ''){
        if(String.isBlank(selectedFrequencyValue)){
            msg = msg + 'Frequency,';           
        }
        if(caseObj.From_Date__c == null ){
            msg = msg + ' From Date,';
        }
        if(caseObj.To_Date__c == null){
            msg = msg + ' End Date,'; 
        }
       // if(strEmailTo == null || strEmailTo == ''){
        if(String.isBlank(strEmailTo)){
            msg = msg + ' Email ';
        }
       // if(msg != ''){
        if(String.isNotBlank(msg)){
            msg = msg.subString(0,msg.length()-1);
            msg = msg + ' can\'t be blank.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,msg));                           
        }
        else if(strEmailTo.contains(';')||strEmailTo.contains(',')){            
            msg = 'Press \'Enter\' to Specify next Email Id';               
        }
        else if(caseObj.From_Date__c < Date.Today() || caseObj.To_Date__c < Date.Today()){
            msg = 'Start Date and End Date can\'t be less than Today';                       
        }
        return msg;      
    }
    public void scheduleReport() {              
        String JOB_Name;
        CRON_EXP = jobId = '';
        String checkMsg = validateData();
        
        if(checkMsg == ''){
            CRON_EXP = generateCronExpression();
            system.debug('CRON_EXP----'+CRON_EXP);
          //  if(CRON_EXP == null || CRON_EXP == '') {
            if(String.isBlank(CRON_EXP)) { 
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.severity.ERROR,errorMsg);
                ApexPages.addMessage(myMsg);
            }
            else{          
                lstEmailAddress = new List<String> (); 
                lstEmailAddress = strEmailTo.split('\n');            
                try{
                     
                     String strProjects;
                     String strOwners;
                    
                     if(!projIds[0].equalsIgnoreCase('all')) {
                        strProjects = getProjectStrings(projIds);
                     }
                     else {
                        strProjects = 'All';
                     }
                     
                     if(!strSelectedOwnerValue.equalsIgnoreCase('all')) {   
                        strOwners = '{'+getOwnerStrings(selectedOwners)+'}';
                     } 
                     else {
                        strOwners = 'All';
                     }                          
                     JOB_Name = 'Case To be Escalation Detail Report Scheduled with : <DateRange: '+selectedDateRange+' ,Projects: {'+strProjects+'} ,Case Owners: '+strOwners+'>'; 
                     //CRON_EXP = '0 0 08 * * ?';
                     //jobId = system.schedule(JOB_Name,CRON_EXP, new CaseToBeEscalatedReportScheduler(selectedOwners,selectedDateRange,lstEmailAddress,projIds));                                                      
                     if(jobId != null && jobId != ''){
                         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Report is successfully scheduled. Please go to Administration Setup -> Monitoring -> Scheduled Jobs to verify it');                
                         ApexPages.addMessage(myMsg);                        
                     }
                }
                catch(Exception e){
                     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
                     ApexPages.addMessage(myMsg);            
                }
                isSchedulerBlock = false;           
            }  
        }      
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,checkMsg));
        }
    } 
    
    public string getOwnerStrings(List<String> OwnerId) {
        String strOwner = '';
        List<User> OwnerList = [Select u.Name, u.Id From User u where u.Id IN : OwnerId];
        for(User ownrObj : OwnerList) {
            List<String> lstString = ownrObj.Name.split(' ');
            for(String str : lstString) {
                strOwner = strOwner + str.subString(0 , 1);
            }
            strOwner = strOwner + ',';
            system.debug('strPrjct-----------'+strOwner);
        }
        strOwner = strOwner.removeEnd(',');
        strOwner = strOwner.toUpperCase();
        return strOwner;
    }
    
    public string getProjectStrings(List<String> pidSet) {
        String strPrjct = '';
        List<Projects__c> listProjects = new List<Projects__c>([select Name, Id from Projects__c where Id IN : pidSet]); 
        for(Projects__c pObj : listProjects) {
            List<String> lstString = pObj.Name.split(' ');
            for(String str : lstString) {
                strPrjct = strPrjct + str.subString(0 , 1);
            }
            strPrjct = strPrjct + ',';
            system.debug('strPrjct-----------'+strPrjct);
        }
        strPrjct = strPrjct.removeEnd(',');
        strPrjct = strPrjct.toUpperCase();
        return strPrjct;
    }  
    
    private String generateCronExpression() {
        String cronString, strDayOfMonth;
        cronString = strDayOfMonth = errorMsg = '';
        Date currentDate = Date.today();
        Integer selectedStartDay = caseObj.From_Date__c.day();
        Integer selectedStartMonth = caseObj.From_Date__c.month();
        Integer selectedStartYear = caseObj.From_Date__c.year();
        Integer selectedEndDay = caseObj.To_Date__c.day();
        Integer selectedEndMonth = caseObj.To_Date__c.month();
        Integer selectedEndYear = caseObj.To_Date__c.year();
        
        String strSelectedMonth = String.valueOf(selectedStartMonth) +'-'+ String.valueOf(selectedEndMonth);
        String strSelectedDayOfMonth = String.valueOf(selectedStartDay) + '-' + String.valueOf(selectedEndDay);
        String strSelectYear = String.valueOf(selectedStartYear) + '-' + String.valueOf(selectedEndYear);
        
        
        if(selectedFrequencyValue.equalsIgnoreCase('Daily')) {
            if(caseObj.To_Date__c >= caseObj.From_Date__c && caseObj.From_Date__c >= currentDate) {
                cronString = '0' + ' ' + '0' + ' ' + strPrefStartTime + ' ';    
                cronString += String.valueOf(selectedStartDay)+'/1' + ' ' + strSelectedMonth + ' ' + '?' +' ' + strSelectYear;
                system.debug('cron string for daily report schedule------'+cronString);
                
            }
        }
        else if(selectedFrequencyValue.equalsIgnoreCase('Weekly')) {                           
                if(caseObj.To_Date__c >= caseObj.From_Date__c && caseObj.From_Date__c >= currentDate){                   
                    if(blnIsSunday && blnIsMonday && blnIsTuesday && blnIsWednesday && blnIsThursday && blnIsFriday && blnIsSaturday ){
                            
                        strDayOfMonth = '*';
                        cronString = '0' + ' ' + '0' + ' ' + strPrefStartTime + ' ';    
                        cronString += '?' + ' ' + strSelectedMonth + ' ' + strDayOfMonth + ' ' + strSelectYear;
                    }//end of if
                    else if(!blnIsSunday && !blnIsMonday && !blnIsTuesday && !blnIsWednesday && !blnIsThursday && !blnIsFriday && !blnIsSaturday ){
                         errorMsg = 'Select atleast one weekDay';
                         system.debug('errorMsg******'+errorMsg);
                    }//end of else if
                    else {      
                        if(blnIsSunday)
                            strDayOfMonth += (strDayOfMonth == '' ? '1' : ','+'1');                         
                        if(blnIsMonday)
                            strDayOfMonth += (strDayOfMonth == '' ? '2' : ','+'2'); 
                        if(blnIsTuesday)
                            strDayOfMonth += (strDayOfMonth == '' ? '3' : ','+'3');
                        if(blnIsWednesday)
                            strDayOfMonth += (strDayOfMonth == '' ? '4' : ','+'4');
                        if(blnIsThursday)
                            strDayOfMonth += (strDayOfMonth == '' ? '5' : ','+'5');   
                        if(blnIsFriday)
                            strDayOfMonth += (strDayOfMonth == '' ? '6' : ','+'6');    
                        if(blnIsSaturday)
                            strDayOfMonth += (strDayOfMonth == '' ? '7' : ','+'7');
                        
                        cronString = '0' + ' ' + '0' + ' ' + strPrefStartTime + ' ';
                        cronString += '?' + ' ' + strSelectedMonth + ' ' + strDayOfMonth + ' ' + strSelectYear ;
                        system.debug('cron string for weekly report schedule----------'+cronString);
                    }//end of else                                  
              }//end of if
         }
         /*  else if starts here... */
         else if(selectedFrequencyValue.equalsIgnoreCase('Monthly')){
            //Monthly On 1st ,2nd , 3rd,4th or last week day.
              if(caseObj.To_Date__c >= caseObj.From_Date__c && caseObj.From_Date__c >= currentDate){
                 //system.debug('-------selectedValueForMonthWeek-------'+selectedValueForMonthWeek);
                 // if((selectedValueforMonthDay == null || selectedValueforMonthDay == '') && selectedValueForMonthWeek.equalsIgnoreCase('MonthWeekValue')){       
                  if((String.isBlank(selectedValueforMonthDay)) && selectedValueForMonthWeek.equalsIgnoreCase('MonthWeekValue')){                       
                      if(strDayValue.equalsIgnoreCase('0')){
                          strDayOfMonth = strMonthDay + 'L' ; 
                          cronString = '0' + ' ' + '0' + ' ' + 'strPrefStartTime' + ' ';  
                          cronString += '?' + ' ' + strSelectedMonth + ' ' + strDayOfMonth + ' ' + strSelectYear;
                      }//end of if
                      if(strDayValue.equalsIgnoreCase('4') || 
                          strDayValue.equalsIgnoreCase('3') ||
                          strDayValue.equalsIgnoreCase('2') ||
                          strDayValue.equalsIgnoreCase('1')){ 
                
                          strDayOfMonth = strMonthWeek + '#' + strMonthDay ;
                          cronString = '0' + ' ' + '0' + ' ' + strPrefStartTime + ' ';    
                          cronString += '?' + ' ' + strSelectedMonth + ' ' + strDayOfMonth + ' ' + strSelectYear; 
                          system.debug('Generated cron String --------'+cronString);  
                      }//end of if
                  }//end of if                
                //Monthly On Selected Day.
               // else if((selectedValueForMonthWeek == null || selectedValueForMonthWeek == '') && selectedValueforMonthDay.equalsIgnoreCase('MonthDayValue')){
                 else if((String.isBlank(selectedValueForMonthWeek)) && selectedValueforMonthDay.equalsIgnoreCase('MonthDayValue')){
                    //Last day of every month.
                    if(strDayValue.equalsIgnoreCase('32')){
                        strDayOfMonth = 'L'; 
                        cronString = '0' + ' ' + '0' + ' ' + strPrefStartTime + ' ';
                        cronString += strDayOfMonth + ' ' + '*' + ' ' + '?' +  ' ' + strSelectYear;
                    }//end of if
                    else{
                        //strDayOfMonth = strSelectedMonthlyOnday + '-' +strSelectedEndDayOfMonth;
                        strDayOfMonth = strDayValue;
                        cronString = '0' + ' ' + '0' + ' ' + strPrefStartTime + ' ';
                        cronString += strDayOfMonth + ' ' + strSelectedMonth + ' ' + '?' +  ' ' + strSelectYear;
                    }
                }//end of if            
            }//end of if
        }
        /* else if ends here... */
        system.debug('strSelectedMonth---'+strSelectedMonth);
        system.debug('strSelectedDayOfMonth---'+strSelectedDayOfMonth);
        system.debug('cronString---'+cronString);
       // if(cronString == '' && errorMsg == ''){
        if(String.isBlank(cronString) && String.isBlank(errorMsg)){
            errorMsg = 'Please select the valid dates for report scheduling.';
        }
        return cronString;
    }    

}