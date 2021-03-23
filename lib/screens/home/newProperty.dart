import 'package:MyProperty/screens/home/buyProperty.dart';
import 'package:MyProperty/screens/home/rentProperty.dart';
import 'package:flutter/material.dart';

class NewPropertyPage extends StatefulWidget {
	@override
	_NewPropertyPageState createState() => _NewPropertyPageState();
}

class _NewPropertyPageState extends State<NewPropertyPage> {
	@override
	Widget build(BuildContext context) {
		return DefaultTabController(
			length: 2,
			child: Scaffold(
				appBar: AppBar(
					title: Text("add New Property"),
					bottom: TabBar(
						tabs: [
							Tab(text: "Buy"),
							Tab(text: "Rent")
						],
					),
				),
				body: TabBarView(
					children: [
						BuyPropertyPage(),
						RentPropertyPage(),
					]
				),
			),
		);
	}
}