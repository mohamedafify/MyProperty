import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Rent extends StatefulWidget {
	final Property _property;
	Rent(this._property);
	@override
	_RentState createState() => _RentState();
}

class _RentState extends State<Rent> {
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// rentable at
					TextFormField(
						validator: (val) => val.isEmpty ? "please choose a date for rent" : null,
						controller: TextEditingController(
							text: StringHelp.dateToString(widget._property.rentableAt),
						),
						decoration: InputDecoration(
							border: OutlineInputBorder(
								borderSide: BorderSide(
									color: Colors.black,
								),
							),
							hintText: "choose avalible rent date",
						),
						onTap: () {
							DatePicker.showDatePicker(
								context,
								minTime: DateTime.now(),
								onConfirm: (value) {
									setState(() {
										widget._property.rentableAt = value;
									});
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
					SizedBox(height: 10),
					// max rent
					TextFormField(
						style: TextStyle(
							fontSize: 20,
						),
						keyboardType: TextInputType.number,
						validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid number" : null,
						decoration: InputDecoration(
							border: OutlineInputBorder(
								borderSide: BorderSide(
									color: Colors.black,
								),
							),
							suffixText: "Month",
							hintText: "Max rent"
						),
						onChanged: (value) {
							setState(() {
								widget._property.maxRent = int.parse(value);
							});
						},
					),
					SizedBox(height: 10),
					// pet friendly
					Row(
						children:[ 
							Text(
								"Pet friendly",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.petFriendly,
								onChanged: (value) {
									setState(() {
										widget._property.petFriendly = value;
									});
								},
							),
						]
					),
					// modifiable
					Row(
						children:[ 
							Text(
								"Modifiable",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.modifiable,
								onChanged: (value) {
									setState(() {
										widget._property.modifiable = value;
									});
								},
							),
						]
					),
					// rented before
					Row(
						children:[ 
							Text(
								"Rented before",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.rentedBefore,
								onChanged: (value) {
									setState(() {
										widget._property.rentedBefore = value;
									});
								},
							),
						]
					),
					// insurance
					Row(
						children:[ 
							Text(
								"Insurance",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.hasInsurance,
								onChanged: (value) {
									setState(() {
										widget._property.hasInsurance = value;
									});
								},
							),
						]
					),
					Builder(
						builder: (context) {
							if (widget._property.hasInsurance) {
								return Column(
									mainAxisAlignment: MainAxisAlignment.start,
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										TextFormField(
											style: TextStyle(
												fontSize: 20,
											),
											keyboardType: TextInputType.number,
											validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid number" : null,
											decoration: InputDecoration(
												border: OutlineInputBorder(
													borderSide: BorderSide(
														color: Colors.black,
													),
												),
												hintText: "Insurance"
											),
											onChanged: (value) {
												setState(() {
													widget._property.insurance = int.parse(value);
												});
											},
										),
									],
								);
							} else {
								return Container();
							}
						},
					),
				],
			),
		);
	}
}