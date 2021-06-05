import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/material.dart';

class Buy extends StatefulWidget {
	final Property _property;
	Buy(this._property);
	@override
	_BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// installments
					Row(
						children:[ 
							Text(
								"Installments",
								style: TextStyle(
									fontSize: 20,
								),
							),
							Switch(
								value: widget._property.installments,
								onChanged: (value) {
									setState(() {
										widget._property.installments = value;
									});
								},
							),
						]
					),
					Builder(
						builder: (context) {
							if (widget._property.installments == true) {
								return Column(
									mainAxisAlignment: MainAxisAlignment.start,
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										// installemnt premium
										TextFormField(
											controller: TextEditingController(text: widget._property.installmentPremium == null ? "" : widget._property.installmentPremium.toString()),
											style: TextStyle(
												fontSize: 20,
											),
											keyboardType: TextInputType.number,
											validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid number" : null,
											decoration: InputDecoration(
												labelText: "Installment premium",
												border: OutlineInputBorder(
													borderSide: BorderSide(
														color: Colors.black,
													),
												),
											),
											onChanged: (value) {
												setState(() {
													widget._property.installmentPremium = int.parse(value);
												});
											},
										),
										SizedBox(height: 10,),
										// installment per month
										TextFormField(
											controller: TextEditingController(text: widget._property.installmentPerMonth == null ? "" : widget._property.installmentPerMonth.toString()),
											style: TextStyle(
												fontSize: 20,
											),
											keyboardType: TextInputType.number,
											validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid number" : null,
											decoration: InputDecoration(
												labelText: "Installment per month",
												border: OutlineInputBorder(
													borderSide: BorderSide(
														color: Colors.black,
													),
												),
											),
											onChanged: (value) {
												setState(() {
													widget._property.installmentPerMonth = int.parse(value);
												});
											},
										),
										SizedBox(height: 10),
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