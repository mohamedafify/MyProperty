import 'package:MyProperty/utils/constant.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Container(
			padding: EdgeInsets.only(left: 10),
			alignment: Alignment.center,
			color: Constant.backgroundColor,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: [
					Center(
						child: Text(
							"Please connect to the internet",
							style: TextStyle(
								fontSize: 30,
								color: Constant.buttonTextColor,
								decoration: TextDecoration.none,
								fontWeight: FontWeight.normal,
								fontFamily: Constant.font
							),
						),
					)
				]
			)
		);
	}
}