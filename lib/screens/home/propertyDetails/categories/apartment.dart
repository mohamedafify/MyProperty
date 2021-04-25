import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:flutter/material.dart';

class ApartmentAdditionalInfo extends StatelessWidget {
	final Property _property;
	ApartmentAdditionalInfo(this._property);
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// floor number
					FittedBox(
						child: Row(
							children: [
								Text(
									"Floor number: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									_property.floorNumber.toString() ?? "none",
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
					// elevator
					FittedBox(
						child: Row(
							children: [
								Text(
									"Elevator: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.installments ? "Yes" : "No") ?? "none",
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
					// security
					FittedBox(
						child: Row(
							children: [
								Text(
									"Security: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.security ? "Yes" : "No") ?? "none",
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
					// yard
					FittedBox(
						child: Row(
							children: [
								Text(
									"Yard: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.yard ? "Yes" : "No") ?? "none",
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
					// roof 
					FittedBox(
						child: Row(
							children: [
								Text(
									"Roof: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.roof ? "Yes" : "No") ?? "none",
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
					// garage
					FittedBox(
						child: Row(
							children: [
								Text(
									"Garage: ",
									style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.garage ? "Yes" : "No") ?? "none",
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