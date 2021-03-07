import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:my_property/screens/utils/constant.dart';
import 'package:my_property/services/auth.dart';
import 'package:my_property/utils/show_dialog.dart';

class Register extends StatefulWidget {
	@override
  	_RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
	final AuthService _auth = AuthService();

	String _email = "";
	String _password = "";

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Constant.backgroundColor,
			appBar: AppBar(
				leading: BackButton(
					color: Constant.buttonTextColor,
					onPressed: () => Navigator.of(context).pop(),
				),
				backgroundColor: Constant.backgroundColor,
				elevation: 0.0,
				title: Text(
					"SignUp to MyProperty",
					style: TextStyle(
						color: Constant.buttonTextColor
					)
				),
			),
			body: Center(
			child: Container(
				padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
					child: Form(
						child: Column(
							children:<Widget> [
								SizedBox(height: 20.0),
								TextFormField(
									keyboardType: TextInputType.emailAddress,
									decoration: InputDecoration(
										hintText: "Email"
									),
									onChanged: (val) {
										_email = val;
										// setState(() => _email = val);
									},
								),
								SizedBox(height: 20.0),
								TextFormField(
									obscureText: true,
									decoration: InputDecoration(
									hintText: "Password"
									),
									onChanged: (val) {
										_password = val;
										// setState(() => _password = val);
									},
								),
								SizedBox(height: 20.0),
								TextButton(
									child: Text(
										"Sign Up",
										style: TextStyle(
											color: Constant.buttonTextColor
											),
									),
									onPressed: () async {
										dynamic user = await _auth.registerWithEmailandPassword(email: this._email, password: this._password);
										ShowDialog signUpDialog = ShowDialog();
										// pop the signIn widget from authentication push
										if (user == null) {
											print("Error Siging Up");
											developer.log("user is null", name: "register_signUpButtonERROR");
											signUpDialog.showDialogOnScreen(context, "user is null", "register_signUpButtonERROR");
										} else {
											Navigator.pop(context);

											developer.log("registered Successfully", name: "register_signUpButton");
											signUpDialog.showDialogOnScreen(context, "registered Successfully", "register_signUpButton");
										}
									},
								),
							],
						)
					),
				),
			) 
		);
	}
}