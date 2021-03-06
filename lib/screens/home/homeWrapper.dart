import 'package:MyProperty/screens/home/favouriteProperty/favouriteProperties.dart';
import 'package:MyProperty/screens/home/ownedProperty/ownedProperties.dart';
import 'package:MyProperty/screens/home/search.dart';
import 'package:MyProperty/utils/boolean.dart';
import 'package:MyProperty/utils/pagesRefresher.dart';
import 'package:MyProperty/utils/integer.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:MyProperty/utils/search/searchCategories.dart';
import 'package:flutter/material.dart';
import 'package:MyProperty/screens/home/home.dart';
import 'package:MyProperty/screens/home/newProperty/newProperty.dart';
import 'package:MyProperty/screens/home/profile/profile.dart';
import 'package:MyProperty/screens/home/settings/settings.dart';

class HomeWrapper extends StatefulWidget {
	@override
	_HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
	void refresh() {
		setState((){});
	}
	Integer index = Integer(0);
	final List<Widget> navigationPages = List.empty(growable: true);
	final List<String> navigationPagesNames = ["Home", "Owned Properties", "Add new property", "Settings", "Favourite properties"];
	final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
	final SearchCategories searchCategories = SearchCategories();
	final pagesRefresher = PagesRefresher();
	Boolean isLoading = Boolean(false);
	@override
	void initState() {
		pagesRefresher.homeWrapperRefresh = refresh;
		navigationPages.add(Home(_scaffoldKey, searchCategories,
						pagesRefresher));
		navigationPages.add(OwnedPropertiesPage(_scaffoldKey, pagesRefresher));
		navigationPages.add(NewPropertyPage(index, isLoading,
						_scaffoldKey, pagesRefresher));
		navigationPages.add(Settings(pagesRefresher));
		navigationPages.add(FavouritePropertiesPage(_scaffoldKey,
						pagesRefresher));
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			key: _scaffoldKey,
			bottomNavigationBar: BottomNavigationBar(
				currentIndex: index.myNum,
				iconSize: 30.0,
				selectedFontSize: 15,
				unselectedFontSize: 15,
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
			body: isLoading.myBool ? Loading(Colors.blue) : NestedScrollView(
				headerSliverBuilder: (context, isScrolled) {
					return <Widget> [
						SliverAppBar(
							title: Text(navigationPagesNames[index.myNum]),
							floating: true,
							forceElevated: isScrolled,
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
											MaterialPageRoute(builder:
													(context) =>
													SearchPage(searchCategories,
															pagesRefresher)),
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
						)
					];
				},
				body: navigationPages[index.myNum],
			),
		);
	}
}
