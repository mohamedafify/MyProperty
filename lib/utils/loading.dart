import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
	final Color color;
	Loading(this.color);
	@override
	Widget build(BuildContext context) {
		return Container(
			color: color,
			child: Center(
				child: SpinKitRing(
					color: Colors.black,
					size: 50.0,
				),
			)
		);
	}
}