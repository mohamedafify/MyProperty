import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/connection.dart';
import 'package:MyProperty/utils/showToast.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/material.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:country_code_picker/country_code_picker.dart';

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
	bool _obscurePassword = true;
	String _countryCode = "+20";

	@override
	Widget build(BuildContext context) {
		final connection = context.watch<Connection>();
		return loading ? Loading(Colors.blue) : Scaffold(
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
					"Sign Up",
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
									// first name
									TextFormField(
										validator: (val) => val.isEmpty ? "Enter valid name" : null,
										autofillHints: [AutofillHints.name],
										keyboardType: TextInputType.name,
										autovalidateMode: AutovalidateMode.onUserInteraction,
										onEditingComplete: () => TextInput.finishAutofillContext(),
										decoration: InputDecoration(
											labelText: "Name",
											border: OutlineInputBorder(
												borderSide: BorderSide(
													color: Colors.black,
												),
											),
										),
										onChanged: (val) {
											setState(() => _name = val.trim());
										},
									),
									SizedBox(height: 20.0),
									// email
									TextFormField(
										validator: (val) => val.isEmpty ? "Enter valid email" : null,
										keyboardType: TextInputType.emailAddress,
										autofillHints: [AutofillHints.email],
										onEditingComplete: () => TextInput.finishAutofillContext(),
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
											setState(() => _email = val);
										},
									),
									SizedBox(height: 20.0),
									// password
									TextFormField(
										validator: (val) => val.length < 8 ? "Enter valid password" : null,
										obscureText: _obscurePassword,
										onEditingComplete: () => TextInput.finishAutofillContext(),
										autovalidateMode: AutovalidateMode.onUserInteraction,
										autofillHints: [AutofillHints.password],
										decoration: InputDecoration(
											labelText: "Password",
											border: OutlineInputBorder(
												borderSide: BorderSide(
													color: Colors.black,
												),
											),
											suffixIcon: IconButton(
												icon: _obscurePassword ? FaIcon(FontAwesomeIcons.eyeSlash) : FaIcon(FontAwesomeIcons.eye),
												onPressed: () {
													setState(() {
														_obscurePassword = !_obscurePassword;
													});
												},
											)
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
										onEditingComplete: () => TextInput.finishAutofillContext(),
										autovalidateMode: AutovalidateMode.onUserInteraction,
										decoration: InputDecoration(
											prefixIcon: CountryCodePicker(
												flagWidth: 30,
												enabled: false,
												initialSelection: _countryCode,
											),
											labelText: "Phone number",
											border: OutlineInputBorder(
												borderSide: BorderSide(
													color: Colors.black,
												),
											),
										),
										onChanged: (val) {
											setState(() => _number = val);
										},
									),
									SizedBox(height: 20.0),
									// signup button
									TextButton(
										style: ButtonStyle(
											backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue[400]),
											minimumSize: MaterialStateProperty.resolveWith((states) => Size(100, 40)),
											elevation: MaterialStateProperty.resolveWith((states) => 2)
										),
										child: Text(
											"Sign Up",
											style: TextStyle(
												fontSize: 17,
												color: Constant.buttonTextColor
											),
										),
										onPressed: () async {
											if (_formKey.currentState.validate()) {
												await connection.checkConnection();
												if (Connection.hasInternet) {
													setState(() => loading = true);
													dynamic user = await _auth.registerWithEmailandPassword(this._email, this._password, this._name, "+2" + this._number);
													if (user is MyUser) {
														Navigator.pop(context);
													} else {
														ShowToast(context).popUp(text: user, color: Colors.red);
													}
													setState(() => loading = false);
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
			),
		);
	}
}