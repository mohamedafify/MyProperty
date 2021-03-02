import 'package:flutter/material.dart';
import 'package:my_property/screens/utils/constant.dart';
import 'package:my_property/services/auth.dart';
import 'package:my_property/utils/show_dialog.dart';

class SignIn extends StatefulWidget {
	@override
	_SignInState createState() => _SignInState();
}
//TODO design the signup page
class _SignInState extends State<SignIn> {
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
				"SignIn to MyProperty",
				style: TextStyle(
					color: Constant.buttonTextColor
				)
			),
		),
		body: Center(
		  child: Container(
		  	padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
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
									"Sign In",
									style: TextStyle(
										color: Constant.buttonTextColor
										),
								),
		  						onPressed: () async {
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
		  						},
							),
		  				],
		  			)
		  	  ),
		  	),
		) 
			// ),
		);
	}
}