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
}