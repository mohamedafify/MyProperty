import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/utils/screen.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:MyProperty/viewModels/propertyPreviewViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PropertyPreview extends StatefulWidget {
	final Property _property;
	PropertyPreview(this._property);
	@override
	_PropertyPreviewState createState() => _PropertyPreviewState();
}

class _PropertyPreviewState extends State<PropertyPreview> {
	final PropertyPreviewViewModel _viewModel = PropertyPreviewViewModel();
	@override
	Widget build(BuildContext context) {
		final Screen _screen = Screen(context);
		return SizedBox(
			width: _screen.width,
			height: _screen.height / 5,
			child: Row(
				mainAxisAlignment: MainAxisAlignment.center,
				children:<Widget> [
					SizedBox(
						width: _screen.width * (2/3),
						// child: Image(
						// 	image: NetworkImage(widget._property.imagesRefs[0]),
						// )
						child: FutureBuilder(
							future: _viewModel.getImageUrl(widget._property.imagesRefs[0]),
							builder: (context, snap) {
								if (snap.connectionState == ConnectionState.done) {
									return Image(
										image: NetworkImage(snap.data),
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
									);
								} else {
									return FittedBox(
										child: CircularProgressIndicator(),
									);
								}
							},
						),
					),
					SizedBox(
						width: _screen.width * (1/3),
						child: Container(
							padding: EdgeInsets.only(top: 10),
							child: Column(
								mainAxisAlignment: MainAxisAlignment.start,
								crossAxisAlignment: CrossAxisAlignment.start,
								children:<Widget> [
									AutoSizeText(
										widget._property.propertyType,
										maxLines: 1,
										style: TextStyle(
											fontSize: 25,
										),
									),
									SizedBox(height: 10),
									AutoSizeText(
										widget._property.adType,
										maxLines: 1,
										style: TextStyle(
											fontSize: 25,
										),
									),
									SizedBox(height: 10),
									AutoSizeText(
										widget._property.price.toString(),
										maxLines: 1,
										style: TextStyle(
											fontSize: 25,
										),
									),
									SizedBox(height: 10),
									AutoSizeText(
										StringHelp.dateToString(widget._property.postDate),
										maxLines: 1,
										style: TextStyle(
											fontSize: 25,
										),
									),
								],
							)
						)
					),
				],
			)
		);
	}
}