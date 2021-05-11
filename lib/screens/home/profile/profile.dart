import 'package:MyProperty/services/auth.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
	@override
	_ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
	final AuthService _auth = AuthService();
	@override
	Widget build(BuildContext context) {
		return Container(
			color: Constant.backgroundColor,
			child: Scaffold(
				appBar: AppBar(
				),
				body: TextButton(
					child: Text(
						"Sign Out",
						style: TextStyle(
							fontSize: 20
						),
					),
					onPressed: () async {
						await _auth.signOut();
						Navigator.pop(context);
					},
				),
			),
		);
	}
}
