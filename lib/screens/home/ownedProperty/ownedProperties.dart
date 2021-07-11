import 'package:MyProperty/screens/home/ownedProperty/propertyPreviewEdit.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:MyProperty/viewModels/ownedPropertyViewModel.dart';
import 'package:MyProperty/utils/pagesRefresher.dart';
import 'package:flutter/material.dart';

class OwnedPropertiesPage extends StatefulWidget {
	final GlobalKey scaffoldKey;
	final PagesRefresher pagesRefresher;
	OwnedPropertiesPage(this.scaffoldKey, this.pagesRefresher);
	@override
	_OwnedPropertiesPageState createState() => _OwnedPropertiesPageState();
}

class _OwnedPropertiesPageState extends State<OwnedPropertiesPage> {
	final OwnedPropertyViewModel _viewModel = OwnedPropertyViewModel();

	void refresh() {
		setState((){});
	}
	@override
	void initState() {
		widget.pagesRefresher.ownedPropertiesPageRefresh = refresh;
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		return Container(
			child: FutureBuilder(
				future: _viewModel.getOwnedProperties(),
				builder: (context, snapshot) {
					if (snapshot.connectionState == ConnectionState.done) { 
							return ListView.separated(
								padding: EdgeInsets.only(top: 0),
								separatorBuilder: (context, index) => Divider(color: Colors.black54),
								itemBuilder: (_, index) =>
								PropertyPreviewEdit(snapshot.data[index],
										widget.scaffoldKey, widget.pagesRefresher),
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
