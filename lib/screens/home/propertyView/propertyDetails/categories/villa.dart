import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:flutter/material.dart';

class VillaAdditionalInfo extends StatelessWidget {
	final Property _property;
	final double fontSize;
	VillaAdditionalInfo(this._property, this.fontSize);
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// swimming pool
					FittedBox(
						child: Row(
							children: [
								Text(
									"Swimming pool: ",
									style: TextStyle(
										fontSize: fontSize,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									(_property.swimmingPool ? "Yes" : "No") ?? "none",
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
					),
					// number of floors
					FittedBox(
						child: Row(
							children: [
								Text(
									"Number of floors: ",
									style: TextStyle(
										fontSize: fontSize,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
									),
								),
								Text(
									_property.numberOfFloors.toString() ?? "none",
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
					),
				]
			),
		);
	}
}
