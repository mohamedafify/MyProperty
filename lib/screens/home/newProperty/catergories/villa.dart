import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/material.dart';

class Villa extends StatefulWidget {
	final Property _property;
	Villa(this._property);
	@override
	_VillaState createState() => _VillaState();
}
class _VillaState extends State<Villa> {
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
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
							hintText: "Number of floors"
						),
						onChanged: (value) {
							setState(() {
								widget._property.floorNumber = int.parse(value);
							});
						},
					),
					SizedBox(height: 10),
					Row(
						children:[ 
							Text(
								"SwmmingPool",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.swimmingPool,
								onChanged: (value) {
									setState(() {
										widget._property.swimmingPool = value;
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