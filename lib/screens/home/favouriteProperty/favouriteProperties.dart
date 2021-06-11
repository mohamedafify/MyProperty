import 'package:MyProperty/screens/home/propertyView/propertyPreview.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:MyProperty/viewModels/favouritePropertyViewModel.dart';
import 'package:flutter/material.dart';

class FavouritePropertiesPage extends StatefulWidget {
	final GlobalKey scaffoldKey;
	FavouritePropertiesPage(this.scaffoldKey);
	@override
	_FavouritePropertiesPageState createState() => _FavouritePropertiesPageState();
}

class _FavouritePropertiesPageState extends State<FavouritePropertiesPage> {
	void refresh(Function fn) {
		setState(fn);
	}
	@override
	Widget build(BuildContext context) {
		final _viewModel = FavouritePropertyViewModel();
		return Container(
			child: FutureBuilder(
				future: _viewModel.getFavouriteProperties(),
				builder: (context, snapshot) {
					if (snapshot.connectionState == ConnectionState.done) { 
							return ListView.separated(
								padding: EdgeInsets.only(top: 0),
								separatorBuilder: (context, index) => Divider(color: Colors.black54),
								itemBuilder: (_, index) => PropertyPreview(snapshot.data[index], widget.scaffoldKey, refresh: refresh),
								itemCount: snapshot.data.length,
							);
					} else {
						return Loading(Colors.blue);
					}
				},
			),
		
		);
	}
}