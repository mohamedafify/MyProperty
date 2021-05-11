import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/screens/home/propertyView/propertyDetails/propertyDetails.dart';
import 'package:MyProperty/utils/screen.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:MyProperty/viewModels/propertyPreviewViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PropertyPreview extends StatefulWidget {
	final Property _property;
	final GlobalKey scaffoldKey;
	PropertyPreview(this._property, this.scaffoldKey);
	@override
	_PropertyPreviewState createState() => _PropertyPreviewState();
}

class _PropertyPreviewState extends State<PropertyPreview> {
	final PropertyPreviewViewModel _viewModel = PropertyPreviewViewModel();
	@override
	Widget build(BuildContext context) {
		final Screen _screen = Screen(context);
		final double fontSize = 12;
		return SizedBox(
			width: _screen.width,
			height: _screen.height / 6,
			child: GestureDetector(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children:<Widget> [
						// image and icon
						Container(
							padding: EdgeInsets.all(10),
							width: _screen.width * (2/3),
							child: Stack(
								children:<Widget> [
									Image(
										width: _screen.width * (2/3),
										filterQuality: FilterQuality.none,
										image: CachedNetworkImageProvider(widget._property.imagesURLs[0]),
										fit: BoxFit.contain,
										frameBuilder: (context, child, frame, wasSync) {
											return Center(child: child);
										},
										loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
											if (loadingProgress == null)
												return child;
											else
												return Center(child: CircularProgressIndicator());
										},
										errorBuilder: (context, object, stackTrace) {
											return Center(child: Text("No Internet"));
										},
									),
									FutureBuilder(
										initialData: false,
										future: _viewModel.isFavourite(widget._property),
										builder: (context, snapshot) {
											if (snapshot.connectionState == ConnectionState.done) {
												return IconButton(
													icon: snapshot.data ? Icon(Icons.star) : Icon(Icons.star_outline),
													onPressed: () async {
														if (snapshot.data) {
															await _viewModel.removePropertyToFavourites(widget._property).then((value) {
																setState((){});
															});
														} else {
															await _viewModel.addPropertyToFavourites(widget._property).then((value) {
																setState((){});
															});
														}
													},
												);
											} else {
												return snapshot.data ? Padding(
													padding: const EdgeInsets.all(12.0),
													child: Icon(Icons.star),
												) : Padding(
													padding: const EdgeInsets.all(12.0),
													child: Icon(Icons.star_outline),
												);
											}
										}
									),
								],
							),
						),
						// info
						SizedBox(
							width: _screen.width * (1/3),
							child: Container(
								padding: EdgeInsets.only(right: 10),
								child: FittedBox(
									child: Column(
										mainAxisAlignment: MainAxisAlignment.start,
										crossAxisAlignment: CrossAxisAlignment.start,
										children:<Widget> [
											Text(
												widget._property.propertyType,
												style: TextStyle(
													fontSize: fontSize,
												),
											),
											SizedBox(height: 5),
											Text(
												widget._property.adType,
												style: TextStyle(
													fontSize: fontSize,
												),
											),
											SizedBox(height: 5),
											Text(
												widget._property.price.toString(),
												style: TextStyle(
													fontSize: fontSize,
												),
											),
											SizedBox(height: 5),
											Text(
												StringHelp.dateToString(widget._property.postDate),
												style: TextStyle(
													fontSize: fontSize,
												),
											),
										],
									)
								)
							)
						),
					],
				),
				onTap: () {
					Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => PropertyDetails(widget._property, widget.scaffoldKey)),
					);
				},
			),
		);
	}
}