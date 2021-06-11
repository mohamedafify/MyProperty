import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/screens/home/ownedProperty/propertyDetailsEdit.dart';
import 'package:MyProperty/utils/screen.dart';
import 'package:MyProperty/utils/show_dialog.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:MyProperty/viewModels/ownedPropertyViewModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PropertyPreviewEdit extends StatefulWidget {
	final Property _property;
	final GlobalKey scaffoldKey;
	final Function refresh;
	PropertyPreviewEdit(this._property, this.scaffoldKey, this.refresh);
	@override
	_PropertyPreviewEditState createState() => _PropertyPreviewEditState();
}

class _PropertyPreviewEditState extends State<PropertyPreviewEdit> {
	final OwnedPropertyViewModel _viewModel = OwnedPropertyViewModel();
	@override
	Widget build(BuildContext context) {
		final Screen _screen = Screen(context);
		final double fontSize = 20;
		return SizedBox(
			width: _screen.width,
			height: (_screen.height / 6),
			child: GestureDetector(
				child: Row(
					mainAxisAlignment: MainAxisAlignment.center,
					children:<Widget> [
						// image
						Container(
							padding: EdgeInsets.all(10),
							width: _screen.width * (2/3) - 80,
							child: Stack(
								children:<Widget> [
									Image(
										width: _screen.width * (2/3) - 80,
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
								],
							),
						),
						// info
						SizedBox(
							width: _screen.width * (1/3) - _screen.width * (1/15),
							child: Container(
								padding: EdgeInsets.only(right: 10),
								child: FittedBox(
									child: Column(
										mainAxisAlignment: MainAxisAlignment.start,
										crossAxisAlignment: CrossAxisAlignment.start,
										children:<Widget> [
											Text(
												widget._property.propertyType,
												maxLines: 1,
												style: TextStyle(
													fontSize: fontSize,
												),
											),
											SizedBox(height: 5),
											Text(
												widget._property.adType,
												maxLines: 1,
												style: TextStyle(
													fontSize: fontSize,
												),
											),
											SizedBox(height: 5),
											Text(
												widget._property.price.toString(),
												maxLines: 1,
												style: TextStyle(
													fontSize: fontSize,
												),
											),
											SizedBox(height: 5),
											Text(
												StringHelp.dateToString(widget._property.postDate),
												maxLines: 1,
												style: TextStyle(
													fontSize: fontSize,
												),
											),
										],
									)
								)
							)
						),
						FittedBox(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.start,
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									// edit
									TextButton(
										child: Row(
											children: [
												Icon(Icons.edit, color: Colors.black),
												SizedBox(width: 5),
												Text(
													"Edit",
													style: TextStyle(
														color: Colors.black,
														fontWeight: FontWeight.normal,
														fontSize: fontSize,
													),
												),
											],
										),
										onPressed: () {
											Navigator.push(
												context,
												MaterialPageRoute(builder: (context) => PropertyDetailsEdit(widget._property, widget.scaffoldKey, widget.refresh))
											);
										},
									),
									// delete
									TextButton(
										child: Row(
											children: [
												Icon(Icons.delete, color: Colors.black),
												SizedBox(width: 5),
												Text(
													"Delete",
													style: TextStyle(
														color: Colors.black,
														fontWeight: FontWeight.normal,
														fontSize: fontSize,
													),
												),
											],
										),
										onPressed: () async {
												bool confirmed = await ShowDialog().askForConfirmation(context, "Are you sure you want to delete ?");
												if (confirmed) {
													await _viewModel.deleteProperty(widget._property.uid, widget._property.imagesRefs, widget._property.favouritedByUsersUIDs);
													widget.refresh();
												}
										},
									),
									TextButton(
										child: Row(
											children: [
												Icon(FontAwesomeIcons.houseUser, color: Colors.black),
												SizedBox(width: 5),
												Text(
													widget._property.adType == "Rent" ? "Rented" : "Sold",
													style: TextStyle(
														color: Colors.black,
														fontWeight: FontWeight.normal,
														fontSize: 20,
													),
												),
											],
										),
										onPressed: () {

										},
									),
									// sold
								],
							),
						),
					],
				),
			),
		);
	}
}