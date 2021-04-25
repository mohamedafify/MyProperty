import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/screens/home/propertyDetails/imagesViewer.dart';
import 'package:MyProperty/utils/constant.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:MyProperty/viewModels/propertyDetailsViewModel.dart';
import 'package:flutter/material.dart';

class PropertyDetails extends StatefulWidget {
	final Property _property;
	PropertyDetails(this._property);
	@override
	_PropertyDetailsState createState() => _PropertyDetailsState();
}
class _PropertyDetailsState extends State<PropertyDetails> {
	final PropertyDetailsViewModel _viewModel = PropertyDetailsViewModel();
	@override
	Widget build(BuildContext context) {
		return Container(
			padding: EdgeInsets.fromLTRB(10, 40, 10, 10),
			color: Colors.white,
			child: SingleChildScrollView(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					crossAxisAlignment: CrossAxisAlignment.start,
					children:<Widget> [
						/* ------------------ Default ------------------- */
						// images
						Center(
							child: FittedBox(
								child: TextButton(
									child: Text(
										"Show Images",
										style: TextStyle(
										fontSize: 30,
										color: Constant.buttonTextColor,
										decoration: TextDecoration.none,
										fontWeight: FontWeight.bold,
										fontFamily: Constant.font
										),
									),
									onPressed: () {
										//TODO show images
									},
								),
							),
						),
						// adType
						FittedBox(
							child: Row(
								children:<Widget> [
									Text(
										"AdType: ",
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.adType,
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.propertyType,
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
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
														fontSize: 30,
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
						FittedBox(
							child: Row(
								children: [
									Text(
										"Location: ",
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.location,
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.size.toString(),
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
									Text(
										" m²",
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.price.toString(),
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
									Text(
										" EGP",
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.finish,
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.age.toString(),
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.bedroom.toString(),
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.bathroom.toString(),
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.livingroom.toString(),
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.kitchen.toString(),
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.balacone.toString(),
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.reception.toString(),
										style: TextStyle(
											fontSize: 30,
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

						/* ------------------ Bottom -------------------- */
						// post date
						FittedBox(
							child: Row(
								children: [
									Text(
										"Post Date: ",
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										StringHelp.dateToString(widget._property.postDate),
										style: TextStyle(
											fontSize: 30,
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
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.negotiatable ? "Yes" : "No",
										style: TextStyle(
											fontSize: 30,
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
						FittedBox(
							child: Row(
								children: [
									Text(
										"Flows: ",
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.flows ?? "none",
										style: TextStyle(
											fontSize: 30,
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
						FittedBox(
							child: Row(
								children: [
									Text(
										"LandMarks: ",
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.landmarks ?? "none",
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						// additional info
						FittedBox(
							child: Row(
								children: [
									Text(
										"Additional Information: ",
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.bold,
											fontFamily: Constant.font
										),
									),
									Text(
										widget._property.additionalInformation ?? "none",
										style: TextStyle(
											fontSize: 30,
											color: Constant.buttonTextColor,
											decoration: TextDecoration.none,
											fontWeight: FontWeight.normal,
											fontFamily: Constant.font
										),
									),
								],
							),
						),
						/* ------------------ Bottom -------------------- */
					],
				),
			),
		);
	}
}