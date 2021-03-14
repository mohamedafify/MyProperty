import 'package:flutter/material.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:MyProperty/utils/show_dialog.dart';
import 'package:MyProperty/utils/loading.dart';

class SignIn extends StatefulWidget {
	@override
	_SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
	final AuthService _auth = AuthService();
	final _formKey = GlobalKey<FormState>();
	bool loading = false;

	String _email = "";
	String _password = "";

	@override
	Widget build(BuildContext context) {
		return loading ? Loading() : Scaffold(
			backgroundColor: Constant.backgroundColor,
			appBar: AppBar(
				leading: BackButton(
					color: Constant.buttonTextColor,
					onPressed: () => Navigator.of(context).pop(),
				),
				backgroundColor: Constant.backgroundColor,
				elevation: 0.0,
				title: Text(
					"SignIn to MyProperty",
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
								// email
								TextFormField(
									// TODO make an email validator
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
									// TODO make a password validator
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
								TextButton(
									child: Text(
										"Sign In",
										style: TextStyle(
											color: Constant.buttonTextColor
											),
									),
									onPressed: () async {
										if (_formKey.currentState.validate()) {
											setState(() => loading = true);
											dynamic user = await _auth.signInEmailandPassword(email: this._email, password: this._password);
											ShowDialog signInDialog = ShowDialog();
											// pop the signIn widget from authentication push
											if (user == null) {
												print("Error Siging in");
												signInDialog.showDialogOnScreen(context, "SignIn", "SignInError");
											} else {
												print("Signed In Succesfully");
												Navigator.pop(context);
												signInDialog.showDialogOnScreen(context, "SignIn", "SignedInSuccessfully");
											}
											setState(() => loading = false);
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