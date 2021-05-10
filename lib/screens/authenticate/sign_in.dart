import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/connection.dart';
import 'package:MyProperty/utils/showToast.dart';
import 'package:flutter/material.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
	@override
	_SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
	final AuthService _auth = AuthService();
	final _formKey = GlobalKey<FormState>();

	String _email = "";
	String _password = "";
	bool _obscurePassword = true;

	@override
	Widget build(BuildContext context) {
		final connection = context.watch<Connection>();
		return Scaffold(
			backgroundColor: Constant.backgroundColor,
			appBar: AppBar(
				centerTitle: true,
				leading: BackButton(
					color: Constant.buttonTextColor,
					onPressed: () => Navigator.of(context).pop(),
				),
				backgroundColor: Constant.backgroundColor,
				elevation: 0.0,
				title: Text(
					"Sign In",
					style: TextStyle(
						color: Constant.buttonTextColor
					)
				),
			),
			body: Container(
				child: SingleChildScrollView(
					padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
					child: AutofillGroup(
						child: Form(
							key: _formKey,
							child: Column(
								children:<Widget> [
									SizedBox(height: 20.0),
									// email
									TextFormField(
										validator: (val) => val.isEmpty ? "Enter valid email" : null,
										keyboardType: TextInputType.emailAddress,
										autofillHints: [AutofillHints.email],
										autovalidateMode: AutovalidateMode.onUserInteraction,
										decoration: InputDecoration(
											labelText: "Email",
											border: OutlineInputBorder(
												borderSide: BorderSide(
													color: Colors.black,
												),
											),
										),
										onChanged: (val) {
											setState(() => _email = val.trim());
										},
									),
									SizedBox(height: 20.0),
									// password
									TextFormField(
										validator: (val) => val.length < 8 ? "Enter valid password" : null,
										obscureText: _obscurePassword,
										autovalidateMode: AutovalidateMode.onUserInteraction,
										autofillHints: [AutofillHints.password],
										decoration: InputDecoration(
											labelText: "Password",
											suffixIcon: IconButton(
												icon: _obscurePassword ? FaIcon(FontAwesomeIcons.eyeSlash) : FaIcon(FontAwesomeIcons.eye),
												onPressed: () {
													setState(() {
														_obscurePassword = !_obscurePassword;
													});
												},
											),
											border: OutlineInputBorder(
												borderSide: BorderSide(
													color: Colors.black,
												),
											),
										),
										onChanged: (val) {
											setState(() => _password = val);
										},
									),
									SizedBox(height: 20.0),
									TextButton(
										style: ButtonStyle(
											backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue[400]),
											minimumSize: MaterialStateProperty.resolveWith((states) => Size(100, 40)),
											elevation: MaterialStateProperty.resolveWith((states) => 2)
										),
										child: Text(
											"Sign In",
											style: TextStyle(
												fontSize: 17,
												color: Constant.buttonTextColor
											),
										),
										onPressed: () async {
											if (_formKey.currentState.validate()) {
												await connection.checkConnection();
												if (Connection.hasInternet) {
													Navigator.push(
														context,
														MaterialPageRoute(builder: (context) => Loading(Colors.blue)),
													);
													dynamic user = await _auth.signInEmailandPassword(email: this._email, password: this._password);
													if (user is MyUser) {
														Navigator.pop(context);
													} else {
														ShowToast(context).popUp(text: user, color: Colors.red);
													}
													Navigator.pop(context);
												} else {
													connection.checkConnection();
													ShowToast(context).popUp(text:"No Internet Connection", color: Colors.red);
												}
											}
										},
									),
								],
							)
						),
					),
				),
			) 
		);
	}
}