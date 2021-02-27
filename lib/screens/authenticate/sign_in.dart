import 'package:flutter/material.dart';
import 'package:my_property/services/auth.dart';
import 'package:my_property/utils/show_dialog.dart';

class SignIn extends StatefulWidget {
	@override
	_SignInState createState() => _SignInState();
}
//TODO design the signup page
class _SignInState extends State<SignIn> {
	final AuthService _auth = AuthService();

	@override
	Widget build(BuildContext context) {
	return Scaffold(
		backgroundColor: Colors.black12,
		appBar: AppBar(
			backgroundColor: Colors.black26,
			elevation: 0.0,
			title: Text("SignIn to My Property"),
		),
		body: Container(
			padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
			child: RaisedButton(
				padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
				child: Text("Sign in with email and password"),
				onPressed: () async{
					//TODO implement email and password widgets to get user info from
					// Testing Sign in 
				dynamic user = await _auth.signInEmailandPassword(email: "afify.afify.1999@gmail.com", password: "123qwe");                 
				ShowDialog signInDialog = ShowDialog();
				if (user == null) {
					print("Error Siging in");
					signInDialog.showDialogOnScreen(context, "SignIn", "SignInError");
				} else {
					print("Signed In Succesfully");
					signInDialog.showDialogOnScreen(context, "SignIn", "SignedInSuccessfully");
				}
				}
			),
		)
	);
	}
}