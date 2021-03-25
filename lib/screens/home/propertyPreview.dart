import 'package:flutter/material.dart';

class PropertyPreview extends StatefulWidget {
	@override
	_PropertyPreviewState createState() => _PropertyPreviewState();
}

class _PropertyPreviewState extends State<PropertyPreview> {
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Row(
				children:<Widget> [
					Image(
						width: 200,
						height: 200,
						image: NetworkImage("https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png"),
						fit: BoxFit.fill,
						frameBuilder: (context, child, frame, wasSync) {
							return Padding(
								padding: EdgeInsets.all(10),
								child: child,
							);
						},
					),
					Column(
						children:<Widget> [
							Text(
								"owner",
								style: TextStyle(
									fontSize: 25,
								),
							),
							Text(
								"type",
								style: TextStyle(
									fontSize: 25,
								),
							),
							SizedBox(height: 10),
							Text(
								"size",
								style: TextStyle(
									fontSize: 25,
								),
							),
							SizedBox(height: 10),
							Text(
								"date",
								style: TextStyle(
									fontSize: 25,
								),
							),
							SizedBox(height: 10),
							Text(
								"price",
								style: TextStyle(
									fontSize: 25,
								),
							),
						],
					)
				],
			)
		);
	}
}