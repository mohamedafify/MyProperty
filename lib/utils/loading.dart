import 'package:MyProperty/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
	final Color color;
	Loading(this.color);
	@override
	Widget build(BuildContext context) {
		return Container(
			color: Colors.blue,
			child: Column(
				children:<Widget> [
					SizedBox(
						height: 30,
					),
					Text(
						"My Property",
						style: TextStyle(
							fontSize: 50,
							color: Constant.buttonTextColor,
							decoration: TextDecoration.none,
							fontWeight: FontWeight.normal,
							fontFamily: Constant.font
						),
					),
					Flexible(
						child: FractionallySizedBox(
							heightFactor: 0.8,
						),
					),
					Center(
						child: SpinKitRing(
							color: Colors.black,
							size: 50.0,
						),
					)
				]
			)
		);
	}
}