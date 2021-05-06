import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImagesViewer extends StatefulWidget {
	final List<dynamic> imagesList;
	final int initIndex;
	final bool useOnTap;
	ImagesViewer(this.imagesList, this.useOnTap, this.initIndex);
	@override
	_ImagesViewerState createState() => _ImagesViewerState();
}

class _ImagesViewerState extends State<ImagesViewer> {
	int currentIndex;
	@override
	void initState() {
		currentIndex = widget.initIndex;
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			child: Container(
				child: ExtendedImageGesturePageView.builder(
					itemBuilder: (context, index) {
						String url = widget.imagesList[index];
						Widget image = ExtendedImage.network(
							url,
							mode: ExtendedImageMode.gesture,
							fit: BoxFit.contain,
							cache: true,
							shape: BoxShape.rectangle,
							initGestureConfigHandler: (state) {
								return GestureConfig(
									inPageView: true,
									initialScale: 1.0,
									minScale: 1.0,
									animationMinScale: 0.8,
									maxScale: 3.0,
									animationMaxScale: 3.5,
									speed: 1.0,
									inertialSpeed: 100.0,
									initialAlignment: InitialAlignment.center,
								);
							},
						);
						if (index == currentIndex) {
							return Hero(
								tag: url + index.toString(),
								child: image,
							);
						} else {
							return image;
						}
					},
					itemCount: widget.imagesList.length,
					onPageChanged: (index) {
						currentIndex = index;
					},
					controller: PageController(
						initialPage: currentIndex,
					),
					scrollDirection: Axis.horizontal,
				),
			),
			onTap: () {
				if (widget.useOnTap) {
					Navigator.push(context, MaterialPageRoute(builder: (context) {
						return ImagesViewer(widget.imagesList, false, currentIndex);
					}));
				}
			},
		);
	}
}