import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:flutter/material.dart';

class BuyAdditionalInfo extends StatelessWidget {
	final Property _property;
	final double fontSize;
	BuyAdditionalInfo(this._property, this.fontSize);
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					// installments
					Row(
						children: [
							Text(
								"Installments: ",
								style: TextStyle(
									fontSize: fontSize,
									color: Constant.buttonTextColor,
									decoration: TextDecoration.none,
									fontWeight: FontWeight.bold,
									fontFamily: Constant.font
								),
							),
							Text(
								_property.installments ? "Yes" : "No",
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
					_property.installments ?
					Column(
						children:<Widget> [
							Row(
								children: [
									Text(
										"Installemts premium: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										_property.installmentPremium.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								]
							),
							Row(
								children: [
									Text(
										"Installemts per month: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										_property.installmentPerMonth.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								]
							),
						]
					) :
					Container(),
				]
			),
		);
	}
}