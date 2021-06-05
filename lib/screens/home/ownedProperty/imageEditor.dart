import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/show_dialog.dart';
import 'package:MyProperty/viewModels/ownedPropertyViewModel.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageEditor extends StatefulWidget {
	final Property _property;
	final GlobalKey _scaffoldKey;
	List imagesToDelete;
	ImageEditor(this._property, this._scaffoldKey, this.imagesToDelete);
	@override
	_ImageEditorState createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
	final OwnedPropertyViewModel viewModel = OwnedPropertyViewModel();
	int currentIndex = 0;
	@override
	Widget build(BuildContext context) {
		return Container(
			child: ExtendedImageGesturePageView.builder(
				itemBuilder: (context, index) {
					String url = widget._property.imagesURLs[index];
					Widget image = 
					Stack(
						fit: StackFit.expand,
						alignment: Alignment.center,
						children: [
							ExtendedImage.network(
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
							),
							Positioned(
								top: 50,
								right: 30,
								width: 50,
								height: 50,
								child: MaterialButton(
									child: Icon(
										Icons.delete,
										size: 50,
										color: Colors.white,
									),
									onPressed: () async {
										bool confirmation = await ShowDialog().askForConfirmation(widget._scaffoldKey.currentContext, "Are you sure you want to delete this image?");
										if (confirmation) {
											setState(() {
												String image = viewModel.tempDeletePropertyImage(widget._property, index);
												widget.imagesToDelete.add(image);
											});
										}
									},
								),
							),
						]
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
				itemCount: widget._property.imagesURLs.length,
				onPageChanged: (index) {
					currentIndex = index;
				},
				controller: PageController(
					initialPage: currentIndex,
				),
				scrollDirection: Axis.horizontal,
			),
		);
	}
}