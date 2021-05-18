import 'package:MyProperty/screens/home/ownedProperty/propertyPreviewEdit.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:MyProperty/viewModels/ownedPropertyViewModel.dart';
import 'package:flutter/material.dart';

class OwnedPropertiesPage extends StatefulWidget {
	final GlobalKey scaffoldKey;
	OwnedPropertiesPage(this.scaffoldKey);
	@override
	_OwnedPropertiesPageState createState() => _OwnedPropertiesPageState();
}

class _OwnedPropertiesPageState extends State<OwnedPropertiesPage> {
	final OwnedPropertyViewModel _viewModel = OwnedPropertyViewModel();

	void refresh(Function fn) {
		setState(fn);
	}
	@override
	Widget build(BuildContext context) {
		return Container(
			child: FutureBuilder(
				future: _viewModel.getOwnedProperties(),
				builder: (context, snapshot) {
					if (snapshot.connectionState == ConnectionState.done) { 
							return ListView.separated(
								separatorBuilder: (context, index) => Divider(color: Colors.black54),
								itemBuilder: (_, index) => PropertyPreviewEdit(snapshot.data[index], widget.scaffoldKey, refresh),
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