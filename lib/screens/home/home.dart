import 'package:MyProperty/screens/home/newProperty.dart';
import 'package:MyProperty/screens/home/sidebar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

	final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			key: _scaffoldKey,
			appBar: AppBar(
				leading: IconButton(
					icon: Icon(Icons.menu),
					onPressed: () {
						setState(() {
							_scaffoldKey.currentState.openDrawer();
						});
					},
				),
				title: Text("Home"),
			),
			drawer: SideBar(),
			floatingActionButton: FloatingActionButton(
				child: Icon(Icons.add_business),
				tooltip: "add new property",
				onPressed: () {
					Navigator.push(
						context, 
						MaterialPageRoute(
							builder: (context) => NewPropertyPage(),
						)
					);
				},
			),
			body: Container(
				child: ListView(
					children:<Widget> [
						Container(
							child: Row(
								children:<Widget> [
									TextButton(
										child: Text(""),
										onPressed: () {

										},
									)
								],
							),
						),
					],
				),
			),
		);
	}
}