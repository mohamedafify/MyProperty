import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/screens/home/newProperty/catergories/apartment.dart';
import 'package:MyProperty/screens/home/newProperty/catergories/villa.dart';
import 'package:MyProperty/screens/home/newProperty/ad%20type/buy.dart';
import 'package:MyProperty/screens/home/newProperty/ad%20type/rent.dart';
import 'package:MyProperty/utils/boolean.dart';
import 'package:MyProperty/utils/integer.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:MyProperty/viewModels/propertyViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class NewPropertyPage extends StatefulWidget {
	final Integer homePageIndex;
	final Boolean isLoading;
	final GlobalKey scaffoldKey;
	final Function(Function fn) notifyParent;
	NewPropertyPage(this.homePageIndex, this.notifyParent, this.isLoading, this.scaffoldKey);
	@override
	_NewPropertyPageState createState() => _NewPropertyPageState();
}

class _NewPropertyPageState extends State<NewPropertyPage> {
	final PropertyViewModel propertyViewModel = PropertyViewModel();
	final _formKey = GlobalKey<FormState>();
	final Property _property = Property();
	final List<Widget> propertyTypesPages = [Container()];
	final MultiImagePicker picker = MultiImagePicker();
	List<Asset> _images = <Asset>[];
	int _index = 0;

	@override
	void initState() {
		propertyTypesPages.add(Apartment(_property));
		propertyTypesPages.add(Villa(_property));
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		return Container(
			child: Form(
				key: _formKey,
				child: SingleChildScrollView(
					padding: EdgeInsets.only(left: 20, right: 20),
					child: Column(
						children:<Widget> [
							SizedBox(height: 10),
							// images
							TextButton.icon(
								label: Text(
									"Add property images",
									style: TextStyle(
										fontSize: 20,
									),
								),
								icon: Icon(Icons.add_photo_alternate),
								onPressed: () async {
									try {
										_images = await MultiImagePicker.pickImages(
											maxImages: 10,
											enableCamera: true,
											selectedAssets: _images,
											materialOptions: MaterialOptions(
												actionBarColor: "#000000",
												actionBarTitle: "Pick property images",
												allViewTitle: "All images",
												useDetailsView: false,
												statusBarColor: "#000000",
												selectCircleStrokeColor: "#000000"
											),
										);
									} catch (e){}
								},
							),
							SizedBox(height: 10),
							// type
							TextFormField(
								validator: (val) => val.isEmpty ? "please choose a property type" : null,
								controller: TextEditingController(
									text: _property.propertyType,
								),
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Choose the property type",
								),
								onTap: () {
									showModalBottomSheet(
										context: context,
										builder: (context) {
											return Container(
												child: Center(
													child: ListView.builder(
														itemBuilder: (_, index) =>
															TextButton(
																child: Text(
																	Property.types[index],
																	style: TextStyle(
																		fontSize: 20,
																	),
																),
																onPressed: () {
																	Navigator.pop(context);
																	setState(() {
																		_property.propertyType = Property.types[index];
																		// plus 1 because first one is an emtpy container which indicates that he didn't choose a property type yet
																		_index = index + 1;
																	});
																},
															),
														itemCount: Property.types.length,
													)
												)
											);
										}
									);
								},
								enableInteractiveSelection: false,
								readOnly: true,
								textAlign: TextAlign.left,
								style: TextStyle(
									color: Colors.black,
									fontWeight: FontWeight.normal,
									fontSize: 20,
								),
							),
							SizedBox(height: 10),
							// Buy or rent buttons
							Row(
								children:[ 
									Builder(
										builder: (context) {
											if (_property.adType == "Buy") { 
												return Flexible(
													child: FractionallySizedBox(
														widthFactor: 1.0,
														child: TextButton(
															style: ButtonStyle(
																backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)
															),
															child: Text(
																"Buy",
																style: TextStyle(
																	fontSize: 20,
																	color: Colors.white
																),
															),
															onPressed: () {
																setState(() {
																	_property.adType = "Buy";
																});
															},
														)
													),
												);
											} else {
												return Flexible(
													child: FractionallySizedBox(
														widthFactor: 1.0,
														child: TextButton(
															style: ButtonStyle(
																backgroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[300])
															),
															child: Text(
																"Buy",
																style: TextStyle(
																	fontSize: 20,
																	color: Colors.blue
																),
															),
															onPressed: () {
																setState(() {
																	_property.adType = "Buy";
																});
															},
														)
													),
												);
											}
										},
									),
									Builder(
										builder: (context) {
											if (_property.adType == "Rent") { 
												return Flexible(
													child: FractionallySizedBox(
														widthFactor: 1.0,
														child: TextButton(
															style: ButtonStyle(
																backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)
															),
															child: Text(
																"Rent",
																style: TextStyle(
																	fontSize: 20,
																	color: Colors.white
																),
															),
															onPressed: () {
																setState(() {
																	_property.adType = "Rent";
																});
															},
														)
													),
												);
											} else {
												return Flexible(
													child: FractionallySizedBox(
														widthFactor: 1.0,
														child: TextButton(
															style: ButtonStyle(
																backgroundColor: MaterialStateColor.resolveWith((states) => Colors.grey[300])
															),
															child: Text(
																"Rent",
																style: TextStyle(
																	fontSize: 20,
																	color: Colors.blue
																),
															),
															onPressed: () {
																setState(() {
																	_property.adType = "Rent";
																});
															},
														)
													),
												);
											}
										},
									),
								]
							),
							SizedBox(height: 10),
							// // location
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								validator: (val) => val.isEmpty ? "pleasea enter a valid locatation" : null,
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Location"
								),
								onChanged: (value) {
									setState(() {
										_property.location = value;
									});
								},
							),
							SizedBox(height: 10),
							// // size
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid size" : null,
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Size",
									suffixText: "m²",
								),
								onChanged: (value) {
									setState(() {
										_property.size = int.parse(value);
									});
								},
							),
							SizedBox(height: 10),
							// // price
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid price" : null,
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									suffixText: "EGP",
									hintText: "Price"
								),
								onChanged: (value) {
									setState(() {
										_property.price = int.parse(value);
									});
								},
							),
							SizedBox(height: 10),
							// finishing degree
							TextFormField(
								validator: (val) => val.isEmpty ? "please choose a property finish degree" : null,
								controller: TextEditingController(
									text: _property.finish,
								),
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Choose the property finish degree",
								),
								onTap: () {
									showModalBottomSheet(
										context: context,
										builder: (context) {
											return Container(
												child: Center(
													child: ListView.builder(
														itemBuilder: (_, index) =>
															TextButton(
																child: Text(
																	Property.finishingDegree[index],
																	style: TextStyle(
																		fontSize: 20,
																	),
																),
																onPressed: () {
																	Navigator.pop(context);
																	setState(() {
																		_property.finish = Property.finishingDegree[index];
																	});
																},
															),
														itemCount: Property.finishingDegree.length,
													)
												)
											);
										}
									);
								},
								enableInteractiveSelection: false,
								readOnly: true,
								textAlign: TextAlign.left,
								style: TextStyle(
									color: Colors.black,
									fontWeight: FontWeight.normal,
									fontSize: 20,
								),
							),
							SizedBox(height: 10),
							// age
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a number" : null,
								decoration: InputDecoration(
									suffixText: "Years",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Building age"
								),
								onChanged: (value) {
									setState(() {
										_property.age = int.parse(value);
									});
								},
							),
							SizedBox(height: 10),
							// bedroom
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a number" : null,
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Bedrooms"
								),
								onChanged: (value) {
									setState(() {
										_property.bedroom = int.parse(value);
									});
								},
							),
							SizedBox(height: 10),
							// bathroom
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a number" : null,
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Bathrooms"
								),
								onChanged: (value) {
									setState(() {
										_property.bathroom = int.parse(value);
									});
								},
							),
							SizedBox(height: 10),
							// livingroom
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a number" : null,
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Livingroom"
								),
								onChanged: (value) {
									setState(() {
										_property.livingroom = int.parse(value);
									});
								},
							),
							SizedBox(height: 10),
							// kitchen
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a number" : null,
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Kitchen"
								),
								onChanged: (value) {
									setState(() {
										_property.kitchen = int.parse(value);
									});
								},
							),
							SizedBox(height: 10),
							// balacone
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a number" : null,
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Balacone"
								),
								onChanged: (value) {
									setState(() {
										_property.balacone = int.parse(value);
									});
								},
							),
							SizedBox(height: 10),
							// reception
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a number" : null,
								decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									hintText: "Reception"
								),
								onChanged: (value) {
									setState(() {
										_property.reception = int.parse(value);
									});
								},
							),
							SizedBox(height: 10),
							// property types additional forms
							propertyTypesPages[_index],
							// rent or buy additional forms
							Builder(
								builder: (context) {
									if (_property.adType == "Rent") {
										return Rent(_property);
									} else if (_property.adType == "Buy") {
										return Buy(_property);
									} else {
										return Container();
									}
								},
							),
							/* ----------------- Bottom ----------------- */
							// negotiatable
							Row(
								children:[ 
									Text(
										"Negotiatable",
										style: TextStyle(
											fontSize: 20,
										),
									),
									Switch(
										value: _property.negotiatable,
										onChanged: (value) {
											setState(() {
												_property.negotiatable = value;
											});
										},
									),
								]
							),
							SizedBox(height: 10),
							// landmarks
							SizedBox(
								height: 120,
								child: TextFormField(
									minLines: null,
									maxLines: null,
									expands: true,
									textAlignVertical: TextAlignVertical.top,
									style: TextStyle(
										fontSize: 20,
									),
									keyboardType: TextInputType.multiline,
									decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
										hintText: "Landmarks"
									),
									onChanged: (value) {
										setState(() {
											_property.landmarks = value; 
										});
									},
								),
							),
							SizedBox(height: 10),
							// flows
							SizedBox(
								height: 120,
								child: TextFormField(
									minLines: null,
									maxLines: null,
									expands: true,
									textAlignVertical: TextAlignVertical.top,
									style: TextStyle(
										fontSize: 20,
									),
									keyboardType: TextInputType.multiline,
									decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
										hintText: "Flows"
									),
									onChanged: (value) {
										setState(() {
											_property.flows = value; 
										});
									},
								),
							),
							SizedBox(height: 10),
							// additional info
							SizedBox(
								height: 120,
								child: TextFormField(
									minLines: null,
									maxLines: null,
									expands: true,
									textAlignVertical: TextAlignVertical.top,
									style: TextStyle(
										fontSize: 20,
									),
									keyboardType: TextInputType.multiline,
									decoration: InputDecoration(
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
										hintText: "Additional information"
									),
									onChanged: (value) {
										setState(() {
											_property.additionalInformation = value; 
										});
									},
								),
							),
							SizedBox(height: 10),
							// add property
							TextButton(
								child: Text(
									"Add property",
									style: TextStyle(
										fontSize: 20
									),
								),
								onPressed: () async {
									if(_images.isEmpty) {
										ScaffoldMessenger.of(widget.scaffoldKey.currentContext).showSnackBar(
											SnackBar(
												duration: Duration(seconds: 3),
												content: Text(
													"Please add images to the property",
													style: TextStyle(
														color: Colors.red,
													),
												)
											)
										);
										return;
									}
									// if (_formKey.currentState.validate()) {
										widget.notifyParent(() {
											widget.isLoading.myBool = true;
										});
										await propertyViewModel.uploadPropertyImages(_property.ownerUID, _property.uid, _images);
										_property.imagesRefs = propertyViewModel.storeRefsToProperty(_property.ownerUID, _property.uid, _images);
										_property.imagesURLs = await propertyViewModel.storeURLsToProperty(_property.imagesRefs);
										ScaffoldMessenger.of(widget.scaffoldKey.currentContext).showSnackBar(
											SnackBar(
												duration: Duration(milliseconds: 800),
												content: Text(
													"Images added")
											)
										);
										await propertyViewModel.updateProperty(_property);
										widget.notifyParent(() {
											// return to homepage
											widget.homePageIndex.myNum = 0;
											// stop loading
											widget.isLoading.myBool = false;
										});
										ScaffoldMessenger.of(widget.scaffoldKey.currentContext).showSnackBar(
											SnackBar(
												duration: Duration(milliseconds: 800),
												content: Text(
													"Property added")
											)
										);
									// }
								},
							),
						],
					)
				),
			),
		);
	}
}