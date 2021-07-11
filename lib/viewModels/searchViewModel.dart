import 'package:MyProperty/utils/search/searchCategories.dart';
import 'package:MyProperty/utils/stringHelp.dart';

class SearchViewModel {
	SearchCategories searchCategories;
	SearchViewModel(SearchCategories searchCaterories) {
		this.searchCategories = searchCaterories;
	}

	void applyFilters() {
		searchCategories.filterValues["adType"] =
				StringHelp.singleFieldFilterPickerToString(searchCategories.adTypes);
	}
}
