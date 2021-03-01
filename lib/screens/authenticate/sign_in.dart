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

	String _email = "";
	String _password = "";

	@override
	Widget build(BuildContext context) {
	return Scaffold(
		backgroundColor: Colors.blue[100],
		appBar: AppBar(
			backgroundColor: Colors.blue[300],
			elevation: 0.0,
			title: Text("SignIn to MyProperty"),
		),
		body: Container(
			padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
			child: Center(
			  child: Form(
			  	child: Column(
			  		children:<Widget> [
			  			SizedBox(height: 20.0),
			  			TextFormField(
			  				onChanged: (val) {
			  					setState(() => _email = val);
			  				},
			  			),
			  			SizedBox(height: 20.0),
			  			TextFormField(
			  				obscureText: true,
			  				onChanged: (val) {
			  					setState(() => _password = val);
			  				},
			  			),
			  			SizedBox(height: 20.0),
			  			RaisedButton(
			  				child: Text(
			  					"Sign In",
			  					// style: TextStyle(color: Colors.white)
			  				),
			  				onPressed: () async {
			  					dynamic user = await _auth.signInEmailandPassword(email: this._email, password: this._password);
			  					ShowDialog signInDialog = ShowDialog();
			  					if (user == null) {
			  						print("Error Siging in");
			  						signInDialog.showDialogOnScreen(context, "SignIn", "SignInError");
			  					} else {
			  						print("Signed In Succesfully");
			  						signInDialog.showDialogOnScreen(context, "SignIn", "SignedInSuccessfully");
			  					}
			  				},
			  			)
			  		],
			  	)
			  ),
			) 
			// ),
		)
	);
	}
}