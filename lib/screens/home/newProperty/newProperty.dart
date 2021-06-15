import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/screens/home/newProperty/categories/apartment.dart';
import 'package:MyProperty/screens/home/newProperty/categories/villa.dart';
import 'package:MyProperty/screens/home/newProperty/ad%20type/buy.dart';
import 'package:MyProperty/screens/home/newProperty/ad%20type/rent.dart';
import 'package:MyProperty/screens/home/newProperty/location.dart';
import 'package:MyProperty/utils/boolean.dart';
import 'package:MyProperty/utils/integer.dart';
import 'package:MyProperty/utils/showToast.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:MyProperty/viewModels/newPropertyViewModel.dart';
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
	final NewPropertyViewModel propertyViewModel = NewPropertyViewModel();
	final _formKey = GlobalKey<FormState>();
	final Property _property = Property();
	final List<Widget> propertyTypesPages = [Container()];
	final MultiImagePicker picker = MultiImagePicker();
	List<Asset> _images = <Asset>[];
	int _index = 0;

	bool _validate() {
		bool validate = true;
		String error = "";
		if (_property.location == null) {
			error = "Please add property location";
			validate = false;
		}
		else if (_images.isEmpty) {
			error = "Please add property images";
			validate = false;
		}
		else if (!_formKey.currentState.validate()) {
			error = "Please fill required information";
			validate = false;
		}
		// add validations here

		if (!validate) {
			ShowToast(widget.scaffoldKey.currentContext).popUp(text: error, color: Colors.red);
		}
		return validate;
	}

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
							// location
							TextButton.icon(
								label: Text(
									"Add property location",
									style: TextStyle(
										fontSize: 20,
									),
								),
								icon: Icon(Icons.my_location),
								onPressed: () {
									Navigator.push(
										context,
										MaterialPageRoute(builder: (context) => LocationPicker(_property, widget.scaffoldKey))
									);
								},
							),
							SizedBox(height: 10),
							// houseNumber in location
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								validator: (val) => val.isEmpty ? "Please enter a valid house id": null,
								decoration: InputDecoration(
									labelText: "House id",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
								),
								onChanged: (value) {
									_property.location.houseID = value;
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
									labelText: "Property type",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
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
							// // size
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid size" : null,
								decoration: InputDecoration(
									labelText: "Size",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									suffixText: "m²",
								),
								onChanged: (value) {
									_property.size = int.parse(value);
								},
							),
							SizedBox(height: 10),
							// price
							TextFormField(
								style: TextStyle(
									fontSize: 20,
								),
								keyboardType: TextInputType.number,
								validator: (val) => !StringHelp.isNumeric(val) ? "please enter a valid price" : null,
								decoration: InputDecoration(
									labelText: "Price",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
									suffixText: "EGP",
								),
								onChanged: (value) {
									_property.price = int.parse(value);
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
									labelText: "Property finish degree",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
								),
								enableInteractiveSelection: false,
								readOnly: true,
								textAlign: TextAlign.left,
								style: TextStyle(
									color: Colors.black,
									fontWeight: FontWeight.normal,
									fontSize: 20,
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
									labelText: "Building age",
									suffixText: "Years",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
								),
								onChanged: (value) {
									_property.age = int.parse(value);
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
									labelText: "Bedrooms",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
								),
								onChanged: (value) {
									_property.bedroom = int.parse(value);
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
									labelText: "Bathrooms",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
								),
								onChanged: (value) {
									_property.bathroom = int.parse(value);
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
									labelText: "Livingroom",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
								),
								onChanged: (value) {
									_property.livingroom = int.parse(value);
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
									labelText: "Kitchen",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
								),
								onChanged: (value) {
									_property.kitchen = int.parse(value);
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
									labelText: "Balacone",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
								),
								onChanged: (value) {
									_property.balacone = int.parse(value);
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
									labelText: "Reception",
									border: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.black,
										),
									),
								),
								onChanged: (value) {
									_property.reception = int.parse(value);
								},
							),
							SizedBox(height: 10),
							// property types additional forms
							propertyTypesPages[_index],
							// rent or buy additional forms
							_property.adType == "Rent" ?
							Rent(_property) :
							Buy(_property),
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
										labelText: "Landmarks",
										border: OutlineInputBorder(
											borderSide: BorderSide(
												color: Colors.black,
											),
										),
									),
									onChanged: (value) {
										_property.landmarks = value; 
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
										labelText: "Flows",
										border: OutlineInputBorder(
											borderSide: BorderSide(
												color: Colors.black,
											),
										),
									),
									onChanged: (value) {
										_property.flows = value; 
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
										labelText: "Additional information",
										border: OutlineInputBorder(
											borderSide: BorderSide(
												color: Colors.black,
											),
										),
									),
									onChanged: (value) {
										_property.additionalInformation = value; 
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
									if (_validate()) {
										widget.notifyParent(() {
											widget.isLoading.myBool = true;
										});
										await propertyViewModel.uploadPropertyImages(_property.ownerUID, _property.uid, _images);
										_property.imagesRefs = propertyViewModel.storeRefsToProperty(_property.ownerUID, _property.uid, _images);
										_property.imagesURLs = await propertyViewModel.storeURLsToProperty(_property.imagesRefs);
										ShowToast(widget.scaffoldKey.currentContext).popUp(text: "Images added", duration: Duration(milliseconds: 800));
										await propertyViewModel.createProperty(_property);
										widget.notifyParent(() {
											// return to homepage
											widget.homePageIndex.myNum = 0;
											// stop loading
											widget.isLoading.myBool = false;
										});
										ShowToast(widget.scaffoldKey.currentContext).popUp(text: "Property added", duration: Duration(milliseconds: 800));
									}
								},
							),
						],
					)
				),
			),
		);
	}
}