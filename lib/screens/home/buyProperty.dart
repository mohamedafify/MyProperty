import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/show_dialog.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyPropertyPage extends StatefulWidget {
	@override
	_BuyPropertyPageState createState() => _BuyPropertyPageState();
}

class _BuyPropertyPageState extends State<BuyPropertyPage> {
	final _formKey = GlobalKey<FormState>();
	final BuyProperty property = BuyProperty();
	DateTime currentDateTime = DateTime.now();

	@override
	Widget build(BuildContext context) {
		return Container(
			child: Form(
				key: _formKey,
				child: ListView(
					padding: EdgeInsets.only(left: 20, right: 20),
					children:<Widget> [
						SizedBox(
							height: 10,
						),
						// type
						TextFormField(
							validator: (val) => val.isEmpty ? "please pick a property type" : null,
							controller: TextEditingController(
								text: property.type,
							),
							decoration: InputDecoration(
								hintText: "Choose the property type",
								focusedBorder: InputBorder.none,
								disabledBorder: InputBorder.none,
								enabledBorder: InputBorder.none,
							),
							onTap: () {
								showModalBottomSheet(
									context: context,
									builder: (context) {
										return Container(
											child: Center(
												child: ListView.builder(
													itemBuilder: (_, index) =>
														TextButton(
															child: Text(
																Property.types[index],
																style: TextStyle(
																	fontSize: 20,
																),
															),
															onPressed: () {
																Navigator.pop(context);
																setState(() {
																	property.type = Property.types[index];
																});
															},
														),
													itemCount: Property.types.length,
												)
											)
										);
									}
								);
							},
							enableInteractiveSelection: false,
							readOnly: true,
							textAlign: TextAlign.left,
							style: TextStyle(
								color: Colors.black,
								fontWeight: FontWeight.normal,
								fontSize: 20,
							),
						),
						SizedBox(
							height: 10,
						),
						// location
						TextFormField(
							style: TextStyle(
								fontSize: 20,
							),
							validator: (val) => val.isEmpty ? "pleasea enter a valid locatation" : null,
							decoration: InputDecoration(
								hintText: "Location"
							),
							onChanged: (val) {
							},
						),
						SizedBox(
							height: 10,
						),
						// size
						TextFormField(
							style: TextStyle(
								fontSize: 20,
							),
							keyboardType: TextInputType.number,
							validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid size" : null,
							decoration: InputDecoration(
								hintText: "Size in m²"
							),
							onChanged: (val) {
							},
						),
						SizedBox(
							height: 10,
						),
						// price
						TextFormField(
							style: TextStyle(
								fontSize: 20,
							),
							keyboardType: TextInputType.number,
							validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid size" : null,
							decoration: InputDecoration(
								hintText: "Price"
							),
							onChanged: (val) {
							},
						),
						SizedBox(
							height: 10,
						),
						// negotiatable
						Row(
							children:[ 
								Text(
									"Negotiatable",
									style: TextStyle(
										fontSize: 20,
									),
								),
								Switch(
									value: property.negotiatable,
									onChanged: (value) {
										setState((){
											property.negotiatable = value;
										});
									},
								),
							]
						),
						TextButton(
							child: Text(
								"Add property",
								style: TextStyle(
									fontSize: 20
								),
							),
							onPressed: () {
								if (_formKey.currentState.validate()) {
									ShowDialog().showDialogOnScreen(context, "validation testing", "sucess");
								}
							},
						),
					],
				),
			)
		);
	}
}