import 'package:flutter/material.dart';
import 'package:MyProperty/screens/authenticate/sign_in.dart';
import 'package:MyProperty/screens/authenticate/register.dart';
import 'package:MyProperty/screens/home/home.dart';
import 'package:MyProperty/utils/constant.dart';

class Authenticate extends StatefulWidget {
	@override
	_AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
	@override
	Widget build(BuildContext context) {
		return Container(
			color: Constant.backgroundColor,
			padding: EdgeInsets.fromLTRB(20.0, 130.0, 20.0, 20.0),
			child: Column(
				children:<Widget> [
					TextButton(
						child: Text(
							"Create account",
							style: TextStyle(
								fontSize: 30.0,
								color: Constant.buttonTextColor,
							),
						),
						onPressed: () {
							Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => Register()),
							);
						},
					),
					Flexible(
					child: FractionallySizedBox(
						heightFactor: 1.0,
					),
					),
					Text(
						"Just want to look around",
						textAlign: TextAlign.center,
						style: TextStyle(
							fontSize: 24.0,
							fontFamily: Constant.font,
							fontWeight: FontWeight.normal,
							color: Constant.buttonTextColor,
							decoration: TextDecoration.none,
						),
					),
					TextButton(
						child: Text(
							"Join as Guest",
							style: TextStyle(
								fontSize: 30.0,
								color: Constant.buttonTextColor,
							),
						),
						onPressed: () {
							Navigator.push(
							context,
							MaterialPageRoute(builder: (context) => Home()),
							);
						},
					),
					Flexible(
						child: FractionallySizedBox(
							heightFactor: 1.0,
						),
					),
					TextButton( 
						child: Text(
							"Have an account already? SignIn",
							style: TextStyle(
								color: Constant.buttonTextColor,
							),
						),
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => SignIn()),
							);
						},
					),
				],
			),
		);
	}
}