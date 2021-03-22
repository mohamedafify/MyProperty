import 'package:MyProperty/utils/constant.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
	@override
	_ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
	@override
	Widget build(BuildContext context) {
		return Container(
			color: Constant.backgroundColor,
			child: Scaffold(
				appBar: AppBar(
					title: Text("Profile"),
				),
			),
		);
	}
}
