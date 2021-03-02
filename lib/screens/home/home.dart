import 'package:flutter/material.dart';
import 'package:my_property/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:my_property/models/user.dart';

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
					FlatButton.icon(
						icon: Icon(Icons.person),
						label: Text("Sign Out"),
						onPressed: () async {
							await _auth.signOut();
						},
					)
				],
			),
		);
  }
}