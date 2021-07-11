import 'package:MyProperty/screens/home/propertyView/propertyPreview.dart';
import 'package:MyProperty/utils/pagesRefresher.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:MyProperty/utils/search/searchCategories.dart';
import 'package:MyProperty/viewModels/homeViewModel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
	final GlobalKey scaffoldKey;
	final SearchCategories searchCategories;
	final PagesRefresher pagesRefresher;
	Home(this.scaffoldKey, this.searchCategories, this.pagesRefresher);
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	void refresh() {
		setState((){});
	}
	HomeViewModel _homeViewModel;
	@override
	void initState() {
		_homeViewModel = HomeViewModel(widget.searchCategories);
		widget.pagesRefresher.homePageRefresh = refresh;
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		return Container(
			child: FutureBuilder(
				future: _homeViewModel.filterProperties(),
				builder: (context, snapshot) {
					if (snapshot.connectionState == ConnectionState.done) { 
						return ListView.separated(
							padding: EdgeInsets.only(top: 0),
							separatorBuilder: (context, index) => Divider(color: Colors.black54),
							itemBuilder: (_, index) =>
							PropertyPreview(snapshot.data[index],
									widget.scaffoldKey),
							itemCount: snapshot.data.length,
						);
					} else {
						return Loading(Colors.blue);
					}
				},
			)
		);
	}
}
