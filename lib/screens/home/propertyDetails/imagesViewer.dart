import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ImagesViewer extends StatefulWidget {
	final List<dynamic> imagesList;
	final bool useOnTap;
	ImagesViewer(this.imagesList, this.useOnTap);
	@override
	_ImagesViewerState createState() => _ImagesViewerState();
}

class _ImagesViewerState extends State<ImagesViewer> {
	int index = 0;
	Offset startPoint;
	Offset endPoint;
	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			child: Container(
				child: Stack(
					alignment: Alignment.centerLeft,
					children: [
						Center(
							child: Image(
								image: NetworkImage(widget.imagesList[index]),
							),
						),
						TextButton(
							child: Icon(
								Icons.arrow_back_ios,
								color: Colors.black,
							),
							onPressed: () {
								if (index > 0) {
									setState(() {
										index--;
									});
								}
							},
						),
						Align(
							alignment: Alignment.centerRight,
							child: TextButton(
								child: Icon(
									Icons.arrow_forward_ios,
									color: Colors.black,
								),
								onPressed: () {
									if (index < widget.imagesList.length - 1) {
										setState(() {
											index++;
										});
									}
								},
							),
						)
					]
				),
				color: Colors.white,
			),
			onHorizontalDragStart: (drag) {
				startPoint = drag.globalPosition;
			},
			onHorizontalDragDown: (drag) {
				endPoint = drag.globalPosition;
			},
			onHorizontalDragEnd: (drag) {
					if (startPoint.dx - endPoint.dx > 0 && index > 0) {
						setState(() {
							index--;
						});
					}
					else if (startPoint.dx - endPoint.dx < 0 && index < widget.imagesList.length - 1) {
						setState(() {
							index++;
						});
					}
			},
			onTap: () {
				if (widget.useOnTap) {
					Navigator.push(context, MaterialPageRoute(builder: (context) {
						return ImagesViewer(widget.imagesList, false);
					}));
				}
			},
		);
	}
}