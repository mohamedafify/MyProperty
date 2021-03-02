import 'package:flutter/material.dart';
import 'package:my_property/screens/authenticate/sign_in.dart';
import 'package:my_property/screens/authenticate/register.dart';
import 'package:my_property/screens/home/home.dart';
import 'package:my_property/screens/utils/constant.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
	return Container(
		color: Constant.backgroundColor,
		padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
		child: Form(
			child: Column(
				children:<Widget> [
					FlatButton(
						child: Text("SignUp"),
						onPressed: () {
							Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => Register()),
							);
						},
					),
					FlatButton(
						child: Text("SignIn"),
						onPressed: () {
							Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => SignIn()),
							);
						},
					),
					FlatButton(
						child: Text("Guest"),
						onPressed: () {
							Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => Home()),
							);
						},
					),
				],
			),
		),
	);
  }
}