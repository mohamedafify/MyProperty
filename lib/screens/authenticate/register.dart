import 'dart:developer' as developer;

import 'package:MyProperty/services/connection.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/material.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:MyProperty/utils/show_dialog.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
	@override
	_RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
	final AuthService _auth = AuthService();
	final _formKey = GlobalKey<FormState>();
	bool loading = false;

	String _name = "";
	String _email = "";
	String _password = "";
	String _number = "";

	@override
	Widget build(BuildContext context) {
		final connection = context.watch<Connection>();
		return loading ? Loading(Colors.blue) : Scaffold(
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
						key: _formKey,
						child: Column(
							children:<Widget> [
								SizedBox(height: 20.0),
								// first name
								TextFormField(
									validator: (val) => val.isEmpty ? "Enter valid name" : null,
									keyboardType: TextInputType.name,
									decoration: InputDecoration(
										hintText: "first name"
									),
									onChanged: (val) {
										setState(() => _name = val);
									},
								),
								SizedBox(height: 20.0),
								// email
								TextFormField(
									validator: (val) => val.isEmpty ? "Enter valid email" : null,
									keyboardType: TextInputType.emailAddress,
									decoration: InputDecoration(
										hintText: "Email"
									),
									onChanged: (val) {
										setState(() => _email = val);
									},
								),
								SizedBox(height: 20.0),
								// password
								TextFormField(
									validator: (val) => val.length < 8 ? "Enter valid password" : null,
									obscureText: true,
									decoration: InputDecoration(
									hintText: "Password"
									),
									onChanged: (val) {
										setState(() => _password = val);
									},
								),
								SizedBox(height: 20.0),
								// number
								TextFormField(
									validator: (val) => !StringHelp.isNumeric(val) ? "Enter a valid number" : null,
									keyboardType: TextInputType.phone,
									decoration: InputDecoration(
										hintText: "Phone number"
									),
									onChanged: (val) {
										setState(() => _number = val);
									},
								),
								SizedBox(height: 20.0),
								// signup button
								TextButton(
									child: Text(
										"Sign Up",
										style: TextStyle(
											color: Constant.buttonTextColor
											),
									),
									onPressed: () async {
										if (_formKey.currentState.validate()) {
											await connection.checkConnection();
											if (Connection.hasInternet) {
												setState(() => loading = true);
												dynamic user = await _auth.registerWithEmailandPassword(this._email, this._password, this._name, this._number);
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
												setState(() => loading = false);
											} else {
												connection.checkConnection();
												ScaffoldMessenger.of(context).showSnackBar(
													SnackBar(
														content: Text(
															"No Internet Connection")
													)
												);
											}
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