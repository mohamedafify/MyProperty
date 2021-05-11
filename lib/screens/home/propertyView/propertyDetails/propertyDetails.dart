import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/screens/home/propertyView/propertyDetails/ad%20type/buy.dart';
import 'package:MyProperty/screens/home/propertyView/propertyDetails/ad%20type/rent.dart';
import 'package:MyProperty/screens/home/propertyView/propertyDetails/categories/apartment.dart';
import 'package:MyProperty/screens/home/propertyView/propertyDetails/categories/villa.dart';
import 'package:MyProperty/screens/home/propertyView/propertyDetails/imagesViewer.dart';
import 'package:MyProperty/screens/home/propertyView/propertyDetails/location.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/utils/screen.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:MyProperty/viewModels/propertyDetailsViewModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PropertyDetails extends StatefulWidget {
	final Property _property;
	final GlobalKey scaffoldKey;
	PropertyDetails(this._property, this.scaffoldKey);
	@override
	_PropertyDetailsState createState() => _PropertyDetailsState();
}
class _PropertyDetailsState extends State<PropertyDetails> {
	final double fontSize = 20;
	PropertyDetailsViewModel _viewModel;

	@override
	void initState() {
		_viewModel = PropertyDetailsViewModel(widget.scaffoldKey);
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		final Screen myScreen = Screen(context);
		return Container(
			padding: EdgeInsets.fromLTRB(10, 50, 10, 10),
			color: Colors.white,
			child: SingleChildScrollView(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					crossAxisAlignment: CrossAxisAlignment.start,
					children:<Widget> [
						/* ------------------ Default ------------------- */
						// images
						SizedBox(
							height: myScreen.height * (1/5),
							width: myScreen.width,
							child: ImagesViewer(widget._property.imagesURLs, true, 0),
						),
						SizedBox(height: 20),
						// adType
						FittedBox(
							child: Row(
								children:<Widget> [
									Text(
										"AdType: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.adType,
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// type
						FittedBox(
							child: Row(
								children: [
									Text(
										"Property Type: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.propertyType,
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// ownerName
						FittedBox(
							child: Row(
								children:<Widget> [
									Text(
										"Owner Name: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									FutureBuilder(
										future: _viewModel.getUserByUID(widget._property.ownerUID),
										builder: (context, snapshot) {
											if (snapshot.connectionState == ConnectionState.done) {
												return Text(
													snapshot.data.name,
													style: TextStyle(
														fontSize: fontSize,
														color: Constant.buttonTextColor,
														decoration: TextDecoration.none,
														fontWeight: FontWeight.normal,
														fontFamily: Constant.font,
													),
												);
											} else {
												return Container();
											}
										},
									),
								],
							)
						),
						// location
						Container(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.start,
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Row(
										children: [
											Text(
												"Location: ",
												style: TextStyle(
													fontSize: fontSize,
													color: Constant.buttonTextColor,
													decoration: TextDecoration.none,
													fontWeight: FontWeight.bold,
													fontFamily: Constant.font
												),
											),
											OutlinedButton(
												child: Text(
													"show location on map",
													style: TextStyle(
														fontSize: fontSize,
														fontWeight: FontWeight.normal,
														color: Colors.blue[900]
													),
												),
												style: ButtonStyle(
													backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue[100]),
													elevation: MaterialStateProperty.resolveWith((states) => 5.0),
													tapTargetSize: MaterialTapTargetSize.shrinkWrap,
												),
												onPressed: () {
													Navigator.push(
														context,
														MaterialPageRoute(builder: (context) => LocationShower(widget._property))
													);
												},
											),
										],
									),
									AutoSizeText(
										widget._property.location.toString(),
										minFontSize: fontSize,
										// widget._property.location,
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// size
						FittedBox(
							child: Row(
								children: [
									Text(
										"Size: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.size.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
									Text(
										" m²",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// price
						FittedBox(
							child: Row(
								children: [
									Text(
										"Price: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.price.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
									Text(
										" EGP",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									)
								],
							),
						),
						// finish
						FittedBox(
							child: Row(
								children: [
									Text(
										"Finish: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.finish,
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// age
						FittedBox(
							child: Row(
								children: [
									Text(
										"Property age: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.age.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// bedroom
						FittedBox(
							child: Row(
								children: [
									Text(
										"Bedrooms: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.bedroom.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// bathroom
						FittedBox(
							child: Row(
								children: [
									Text(
										"Bathrooms: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.bathroom.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// livingroom
						FittedBox(
							child: Row(
								children: [
									Text(
										"Livingrooms: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.livingroom.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// kitchen
						FittedBox(
							child: Row(
								children: [
									Text(
										"Kitchen: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.kitchen.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// balacone
						FittedBox(
							child: Row(
								children: [
									Text(
										"Balacone: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.balacone.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// reception
						FittedBox(
							child: Row(
								children: [
									Text(
										"Reception: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.reception.toString(),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						/* ------------------ Default ------------------- */

						/* ---------------- Rent or Buy ----------------- */
						widget._property.adType == "Rent" ?
						RentAdditionalInfo(widget._property, fontSize) :
						BuyAdditionalInfo(widget._property, fontSize),
						/* ---------------- Rent or Buy ----------------- */

						/* -------------- property types ---------------- */
						Builder(
							builder: (context) {
								switch (widget._property.propertyType) {
								case "Apartment":
									return ApartmentAdditionalInfo(widget._property, fontSize);
									break;
								case "Villa":
									return VillaAdditionalInfo(widget._property, fontSize);
									break;
								default:
									return Container();
								}
							},
						),
						/* -------------- property types ---------------- */

						/* ------------------ Bottom -------------------- */
						// post date
						FittedBox(
							child: Row(
								children: [
									Text(
										"Post Date: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										StringHelp.dateToString(widget._property.postDate),
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// negotiatable
						FittedBox(
							child: Row(
								children: [
									Text(
										"Negotiatable: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.negotiatable ? "Yes" : "No",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// flows
						Container(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.start,
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(
										"Flows: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									AutoSizeText(
										widget._property.flows ?? "none",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// landmarks
						Container(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.start,
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(
										"Landmarks: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									AutoSizeText(
										widget._property.landmarks ?? "none",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							)
						),
						// additional info
						Container(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.start,
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(
										"Additional Information: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									AutoSizeText(
										widget._property.additionalInformation ?? "none",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),

								],
							)
						),
						// contact info
						FittedBox(
							child: Row(
								children: [
									Text(
										"Contact: ",
										style: TextStyle(
											fontSize: fontSize,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									FutureBuilder(
										future: _viewModel.getUserByUID(widget._property.ownerUID),
										builder: (context, snapshot) {
											if (snapshot.connectionState == ConnectionState.done) {
												return TextButton(
													style: ButtonStyle(
														backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.blue[100]),
														elevation: MaterialStateProperty.resolveWith((states) => 5.0),
														tapTargetSize: MaterialTapTargetSize.shrinkWrap,
													),
													child: Row(
														children: [
															FaIcon(
																FontAwesomeIcons.whatsapp,
																color: Colors.green[600],
															),
															SizedBox(width: 10,),
															Text(snapshot.data.number.toString(),
																style: TextStyle(
																	fontSize: fontSize,
																	color: Constant.buttonTextColor,
																	decoration: TextDecoration.none,
																	fontWeight: FontWeight.normal,
																	fontFamily: Constant.font,
																),
															),
														]
													),
													onPressed: () {
														_viewModel.openWhatsappChat(context, snapshot.data.number.toString());
													},
												);
											} else {
												return Container();
											}
										},
									),
								],
							),
						),
						SizedBox(height: 10)
						/* ------------------ Bottom -------------------- */
					],
				),
			),
		);
	}
}