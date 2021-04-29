import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/material.dart';

class RentAdditionalInfo extends StatelessWidget {
	final Property _property;
	final double fontSize;
	RentAdditionalInfo(this._property, this.fontSize);
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// rentable At
					Row(
						children: [
							Text(
								"Rentable at: ",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.bold,
									fontFamily: Constant.font
								),
							),
							Text(
								StringHelp.dateToString(_property.rentableAt) ?? "none",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.normal,
									fontFamily: Constant.font
								),
							),
						],
					),
					// max rent
					Row(
						children: [
							Text(
								"Max rent: ",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.bold,
									fontFamily: Constant.font
								),
							),
							Text(
								_property.maxRent.toString() ?? "none",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.normal,
									fontFamily: Constant.font
								),
							),
						],
					),
					// Rented
					Row(
						children: [
							Text(
								"Rented: ",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.bold,
									fontFamily: Constant.font
								),
							),
							Text(
								(_property.rented ? "Yes" : "No") ?? "none",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.normal,
									fontFamily: Constant.font
								),
							),
						],
					),
					// pet friendly
					Row(
						children: [
							Text(
								"Pet friendly: ",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.bold,
									fontFamily: Constant.font
								),
							),
							Text(
								(_property.petFriendly ? "Yes" : "No") ?? "none",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.normal,
									fontFamily: Constant.font
								),
							),
						],
					),
					// modifiable
					Row(
						children: [
							Text(
								"Modifiable: ",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.bold,
									fontFamily: Constant.font
								),
							),
							Text(
								(_property.modifiable ? "Yes" : "No") ?? "none",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.normal,
									fontFamily: Constant.font
								),
							),
						],
					),
					// rented before
					Row(
						children: [
							Text(
								"Rented before: ",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.bold,
									fontFamily: Constant.font
								),
							),
							Text(
								(_property.rentedBefore ? "Yes" : "No") ?? "none",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.normal,
									fontFamily: Constant.font
								),
							),
						],
					),
					// insurance
					Row(
						children: [
							Text(
								"Insurance: ",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.bold,
									fontFamily: Constant.font
								),
							),
							Text(
								_property.insurance.toString() ?? "none",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.normal,
									fontFamily: Constant.font
								),
							),
						],
					),
				]
			),
		);
	}
}