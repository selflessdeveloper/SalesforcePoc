public class CaseHistoryTrack {
		List<casehistory> HistoryList = new List<casehistory>();
		List<Case_History__c> HistoryCustomList = new List<Case_History__c>();
		CaseHistoryWrapper [] caseHistorywrapperList {get;private set;}
        public Set<STring> HistoryKeySet{get;set;} 
        public Map<String,list<CaseHistoryWrapper>> HistoryMap{get;set;}
		
        Public CaseHistoryTrack() {
            HistoryKeySet = new set<String>();
            HistoryMap = new Map<String,list<CaseHistoryWrapper>>();
			for(casehistory ch : [select Field,
											NewValue,
											OldValue, 
											CreatedDate 
											from casehistory
											where caseId = : ApexPages.currentPage().getParameters().get('Id')]){
				HistoryList.add(ch);
			}
			for(Case_History__c chc : [select Created_Date__c,
												New_Value__c,
												Old_Value__c,
												Tracked_Field__c 
												from Case_History__c 
												where Case__c = :ApexPages.currentPage().getParameters().get('Id') ]) {
				HistoryCustomList.add(chc);
			}
			for(casehistory ch : HistoryList) { 
				Datetime createddate = (datetime) ch.get('CreatedDate');
				CaseHistoryWrapper chw = new CaseHistoryWrapper(ch);
				if(HistoryMap.get(createddate.format())==null) {
					List<CaseHistoryWrapper> chwl = new List<CaseHistoryWrapper>();
					chwl.add(chw);
					HistoryMap.put(createddate.format(),chwl);
				}
				else {
					List<CaseHistoryWrapper> chwl = new List <CaseHistoryWrapper>();
					chwl = HistoryMap.get(createddate.format());
					chwl.add(chw);
					HistoryMap.put(createddate.format(),chwl);
				}
			}

			for(Case_History__c chc : HistoryCustomList){
				Datetime createddate = (datetime) chc.get('Created_Date__c');
				CaseHistoryWrapper chw = new CaseHistoryWrapper(chc);
				if(HistoryMap.get(createddate.format())==null){
					List<CaseHistoryWrapper> chwl = new List<CaseHistoryWrapper>();
					chwl.add(chw);
					HistoryMap.put(createddate.format(),chwl);
				}
				else{
					List<CaseHistoryWrapper> chwl = new List <CaseHistoryWrapper>();
					chwl = HistoryMap.get(createddate.format());
					chwl.add(chw);
					HistoryMap.put(createddate.format(),chwl);
				}
			}

			HistoryKeySet = HistoryMap.keySet();

		}
		
		public class CaseHistoryWrapper {
			public String NewValue {set; get;}
			public String OldValue {set;get;}
			public String Field{set;get;}
			public CaseHistoryWrapper(casehistory ch){
				NewValue =(String) ch.get('NewValue');
				OldValue = (String) ch.get('OldValue');
				Field = (String) ch.get('Field');                
			}
			public CaseHistoryWrapper (Case_History__c chc){
				NewValue = (String) chc.get('New_Value__c');
				OldValue = (String) chc.get('Old_Value__c');
				Field  = (String) chc.get('Tracked_Field__c');
			}

		}
	}