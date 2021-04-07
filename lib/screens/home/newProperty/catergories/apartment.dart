import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/material.dart';

class Apartment extends StatefulWidget {
	final Property _property;
	Apartment(this._property);
	@override
	_ApartmentState createState() => _ApartmentState();
}

class _ApartmentState extends State<Apartment> {
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// floor number
					TextFormField(
						style: TextStyle(
							fontSize: 20,
						),
						keyboardType: TextInputType.number,
						validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid floor number" : null,
						decoration: InputDecoration(
							border: OutlineInputBorder(
								borderSide: BorderSide(
									color: Colors.black,
								),
							),
							hintText: "floor Number"
						),
						onChanged: (value) {
							setState(() {
								widget._property.floorNumber = int.parse(value);
							});
						},
					),
					// elevator
					Row(
						children:[ 
							Text(
								"Elevator",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.elevator,
								onChanged: (value) {
									setState(() {
										widget._property.elevator = value;
									});
								},
							),
						]
					),
					// security
					Row(
						children:[ 
							Text(
								"Security",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.security,
								onChanged: (value) {
									setState(() {
										widget._property.security = value;
									});
								},
							),
						]
					),
					// yard
					Row(
						children:[ 
							Text(
								"Yard",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.yard,
								onChanged: (value) {
									setState(() {
										widget._property.yard = value;
									});
								},
							),
						]
					),
					// roof
					Row(
						children:[ 
							Text(
								"Roof",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.roof,
								onChanged: (value) {
									setState(() {
										widget._property.roof = value;
									});
								},
							),
						]
					),
					// garage
					Row(
						children:[ 
							Text(
								"Garage",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.garage,
								onChanged: (value) {
									setState(() {
										widget._property.garage = value;
									});
								},
							),
						]
					),
				],
			),
		);
	}
}