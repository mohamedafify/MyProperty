import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:MyProperty/utils/constant.dart';

class Loading extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Container(
			color: Constant.backgroundColor,
			child: Center(
				child: SpinKitRing(
					color: Colors.blueGrey,
					size: 50.0,
				),
			)
		);
	}
}