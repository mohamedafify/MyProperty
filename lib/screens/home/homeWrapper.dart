import 'package:MyProperty/screens/home/favouriteProperties.dart';
import 'package:MyProperty/screens/home/ownedProperties.dart';
import 'package:MyProperty/screens/home/search.dart';
import 'package:MyProperty/utils/boolean.dart';
import 'package:MyProperty/utils/integer.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:MyProperty/screens/home/home.dart';
import 'package:MyProperty/screens/home/newProperty/newProperty.dart';
import 'package:MyProperty/screens/home/profile.dart';
import 'package:MyProperty/screens/home/settings.dart';

class HomeWrapper extends StatefulWidget {
	@override
	_HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
	refresh(Function fn) {
		setState(fn);
	}
	Integer index = Integer(0);
	final List<Widget> navigationPages = List.empty(growable: true);
	final List<String> navigationPagesNames = ["Home", "Owned Properties", "Add new property", "Settings", "Favourite properties"];
	final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
	Boolean isLoading = Boolean(false);
	bool firstBuild = true;
	@override
	void initState() {
		navigationPages.add(Home());
		navigationPages.add(OwnedPropertiesPage());
		navigationPages.add(NewPropertyPage(index, refresh, isLoading));
		navigationPages.add(Settings());
		navigationPages.add(FavouritePropertiesPage());
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			key: _scaffoldKey,
			appBar: AppBar(
				title: Text(navigationPagesNames[index.myNum]),
				actions: [
					TextButton.icon(
						icon: Icon(
							Icons.search,
							color: Colors.black,
						),
						label: Container(),
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => SearchPage()),
							);
						},
					),
					TextButton.icon(
						icon: Icon(
							Icons.face,
							color: Colors.black,
						),
						label: Container(),
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => Profile())
							);
						},
					),
				],
			),
			bottomNavigationBar: BottomNavigationBar(
				currentIndex: index.myNum,
				iconSize: 35.0,
				selectedFontSize: 17,
				unselectedFontSize: 17,
				type: BottomNavigationBarType.fixed,
				items: [
					BottomNavigationBarItem(
						icon: Icon(Icons.home),
						label: "Home"
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.business_sharp),
						label: "Owned"
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.add_business),
						label: "Add"
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.settings),
						label: "Settings"
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.star),
						label: "Favourites"
					),
				],
				onTap: (value) {
					setState(() {
						index.myNum = value;
					});
				},
			),
			body: Builder( 
				builder: (context) {
					if (isLoading.myBool) {
						return Loading(Colors.blue);
					} else {
						return navigationPages[index.myNum];
					}
				},
			),
		);
	}
}