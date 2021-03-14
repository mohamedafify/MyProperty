import 'package:flutter/material.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:MyProperty/models/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
//TODO design the home page
//TODO make differences according to guest or not
class _HomeState extends State<Home> {

	final AuthService _auth = AuthService();

	@override
	Widget build(BuildContext context) {
	final user = Provider.of<MyUser>(context);

		return Scaffold(
			appBar: AppBar(
				title: Text("Home"),
				actions: [
					TextButton.icon(
						icon: Icon(
							Icons.person,
							color: Constant.backgroundColor,
						),
						label: Text(
							"Sign Out",
							style: TextStyle(
								color: Constant.buttonTextColor
							),
						),
						onPressed: () async {
							await _auth.signOut();
						},
					)
				],
			),
		);
  }
}