class SearchViewModel {
	Map<String, String> defaultFilterValues = Map<String, String>();

	SearchViewModel() {
		defaultFilterValues = {
			"adType" : "All",
			"propertyType" : "All",
			"size" : "All",
			"finishingDegree" : "All",
			// "startPrice" : "0",
			// "endPrice" : "1000000000",
			"buildingAge" : "All",
			"bedroom" : "All",
			"bathroom" : "All",
			"livingroom" : "All",
			"kitchen" : "All",
			"balacone" : "All",
			"reception" : "All",
			"installments" : "All",
			"negotiatable" : "All",
			"city" : "All",
		};
	}
}