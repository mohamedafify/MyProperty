import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			theme: ThemeData.dark(),
			home: Scaffold(
				appBar: AppBar(title: Text("MyProperty")),
				body: Center(
					child: Text("App loading..."),
				)
			)
		);
	}
}