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
		// decoration: BoxDecoration(backgroundBlendMode: ),
		padding: EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 20.0),
		child: Column(
			children:<Widget> [
				FlatButton(
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
				  	heightFactor: 0.7,
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
				FlatButton(
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
				  	heightFactor: 0.7,
				  ),
				),
				FlatButton( 
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