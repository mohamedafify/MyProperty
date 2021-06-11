class StringHelp {
	static bool isNumeric(String s) {
		if (s == null) {
			return false;
		}
		return double.parse(s, (e) => null) != null;
	}
	static String dateToString(DateTime date) {
		if (date == null)
			return "";
		else
			return date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
	}
	static String filterPickerToString(Map<String, bool> map) {
		String result = "";
		map.forEach((key, value) { 
			if (value) {
				if (result.isEmpty) {
					result = key;
				} else {
					result = result + ", " + key;
				}
			}
		});
		return result;
	}
}