enum sort { MostRecent, HighToLow, LowToHigh }

class SearchCategories {
	Map<String, dynamic> filterValues = Map<String, dynamic>();
	Map<String, bool> adTypes = {
		"All" : true,
		"Rent" : false,
		"Buy" : false,

	};
	Map<String, bool> propertyType = {
		"All" : true,
		"Apartment" : false,
		"Villa" : false,
	};
	Map<String, bool> finishingDegree = {
		"All" : true,
		"None" : false,
		"Half" : false,
		"Full" : false,
		"Lux" : false,
		"SuperLux" : false,
		"UltraLux" : false,
		"SuperDelux" : false,
	};
	SearchCategories() {
		filterValues = {
// 			 single field search
			"adType" : "All",
// 			"negotiatable" : "All",
// 			"city" : "All",

// 			 multi-field search
	//		"propertyType" : null,
	//		"finishingDegree" : null,
	//		"installments" : null,

			// range search
	//		"price" : null,
	//		"buildingAge" : null,
	//		"size" : null,
	//		"bedroom" : null,
	//		"bathroom" : null,
	//		"livingroom" : null,
	//		"kitchen" : null,
	//		"balacone" : null,
	//		"reception" : null,
		};
	}
}

