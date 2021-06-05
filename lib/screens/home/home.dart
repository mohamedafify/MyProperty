import 'dart:io';

import 'package:MyProperty/screens/home/propertyView/propertyPreview.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:MyProperty/utils/show_dialog.dart';
import 'package:MyProperty/viewModels/homeViewModel.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
	final GlobalKey scaffoldKey;
	Home(this.scaffoldKey);
	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
	final HomeViewModel _homeViewModel = HomeViewModel();
	@override
	Widget build(BuildContext context) {
		return WillPopScope(
			onWillPop: () async{
				bool confirmation = await ShowDialog().askForConfirmation(context, "Are you sure you want to exit");
				if (confirmation) {
					exit(0);
				}
				return confirmation;
			},
			child: Container(
				child: FutureBuilder(
					future: _homeViewModel.getAllProperties(),
					builder: (context, snapshot) {
						if (snapshot.connectionState == ConnectionState.done) { 
								return ListView.separated(
									separatorBuilder: (context, index) => Divider(color: Colors.black54),
									itemBuilder: (_, index) => PropertyPreview(snapshot.data[index], widget.scaffoldKey),
									itemCount: snapshot.data.length,
								);
						} else {
							return Loading(Colors.blue);
						}
					},
				)
			),
		);
	}
}