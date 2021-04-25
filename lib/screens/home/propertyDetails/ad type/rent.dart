import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/material.dart';

class RentAdditionalInfo extends StatelessWidget {
	final Property _property;
	RentAdditionalInfo(this._property);
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// rentable At
					FittedBox(
						child: Row(
							children: [
								Text(
									"Rentable at: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									StringHelp.dateToString(_property.rentableAt) ?? "none",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.normal,
										fontFamily: Constant.font
									),
								),
							],
						),
					),
					// max rent
					FittedBox(
						child: Row(
							children: [
								Text(
									"Max rent: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									_property.maxRent.toString() ?? "none",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.normal,
										fontFamily: Constant.font
									),
								),
							],
						),
					),
					// Rented
					FittedBox(
						child: Row(
							children: [
								Text(
									"Rented: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.rented ? "Yes" : "No") ?? "none",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.normal,
										fontFamily: Constant.font
									),
								),
							],
						),
					),
					// pet friendly
					FittedBox(
						child: Row(
							children: [
								Text(
									"Pet friendly: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.petFriendly ? "Yes" : "No") ?? "none",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.normal,
										fontFamily: Constant.font
									),
								),
							],
						),
					),
					// modifiable
					FittedBox(
						child: Row(
							children: [
								Text(
									"Modifiable: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.modifiable ? "Yes" : "No") ?? "none",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.normal,
										fontFamily: Constant.font
									),
								),
							],
						),
					),
					// rented before
					FittedBox(
						child: Row(
							children: [
								Text(
									"Rented before: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.rentedBefore ? "Yes" : "No") ?? "none",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.normal,
										fontFamily: Constant.font
									),
								),
							],
						),
					),
					// insurance
					FittedBox(
						child: Row(
							children: [
								Text(
									"Insurance: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									_property.insurance.toString() ?? "none",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.normal,
										fontFamily: Constant.font
									),
								),
							],
						),
					),
				]
			),
		);
	}
}