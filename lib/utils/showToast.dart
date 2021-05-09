import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowToast {
	final BuildContext context;
	ShowToast(this.context);
	popUp({
		@required String text,
		Duration duration = const Duration(seconds: 3), 
		Color color = Colors.white}) {
		ScaffoldMessenger.of(context).showSnackBar(
			SnackBar(
				duration: duration,
				content: Text(
					text,
					style: TextStyle(
						color: color,
					),
				),
			)
		);
	}
}