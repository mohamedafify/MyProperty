import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:flutter/material.dart';

class PropertyPreview extends StatefulWidget {
	final Property _property;
	PropertyPreview(this._property);
	@override
	_PropertyPreviewState createState() => _PropertyPreviewState();
}

class _PropertyPreviewState extends State<PropertyPreview> {
	@override
	Widget build(BuildContext context) {
		return SizedBox(
			width: 100,
			height: 200,
			child: FittedBox(
				child: Row(
					children:<Widget> [
						Image(
							width: 100,
							height: 80,
							image: NetworkImage("https://miro.medium.com/max/3182/1*ZdpBdyvqfb6qM1InKR2sQQ.png"),
							fit: BoxFit.fill,
							frameBuilder: (context, child, frame, wasSync) {
								return Padding(
									padding: EdgeInsets.all(10),
									child: child,
								);
							},
							loadingBuilder: (context, child, _) {
								return Center(child: child);
							},
						),
						Container(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.start,
								crossAxisAlignment: CrossAxisAlignment.start,
								children:<Widget> [
									Text(
										widget._property.adType,
										style: TextStyle(
											fontSize: 10,
										),
									),
									SizedBox(height: 10),
									Text(
										widget._property.size.toString(),
										style: TextStyle(
											fontSize: 10,
										),
									),
									SizedBox(height: 10),
									Text(
										StringHelp.dateToString(widget._property.postDate),
										style: TextStyle(
											fontSize: 10,
										),
									),
									SizedBox(height: 10),
									Text(
										widget._property.price.toString(),
										style: TextStyle(
											fontSize: 10,
										),
									),
								],
							)
						)
					],
				)
			),
		);
	}
}