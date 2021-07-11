import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/utils/pagesRefresher.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
	final PagesRefresher pagesRefresher;
	Settings(this.pagesRefresher);
	@override
	_SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
	void refresh() {
		setState(() {});
	}
	@override
	void initState() {
		widget.pagesRefresher.settingsPageRefresh = refresh;
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		return Container(
			color: Constant.backgroundColor,
			child: Text(""),
		);
	}
}
