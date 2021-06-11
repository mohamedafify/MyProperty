import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/screens/home/ownedProperty/imageEditor.dart';
import 'package:MyProperty/utils/boolean.dart';
import 'package:MyProperty/utils/loading.dart';
import 'package:MyProperty/utils/show_dialog.dart';
import 'package:MyProperty/viewModels/ownedPropertyViewModel.dart';
import 'package:flutter/material.dart';
import 'package:MyProperty/screens/home/newProperty/ad%20type/buy.dart';
import 'package:MyProperty/screens/home/newProperty/ad%20type/rent.dart';
import 'package:MyProperty/utils/showToast.dart';
import 'package:MyProperty/utils/stringHelp.dart';
import 'package:MyProperty/viewModels/newPropertyViewModel.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PropertyDetailsEdit extends StatefulWidget {
	final Property _property;
	final GlobalKey scaffoldKey;
	final Function refreshOwnedProperties;
	PropertyDetailsEdit(this._property, this.scaffoldKey, this.refreshOwnedProperties);
	@override
	_PropertyDetailsEditState createState() => _PropertyDetailsEditState();
}

class _PropertyDetailsEditState extends State<PropertyDetailsEdit> {
	final _formKey = GlobalKey<FormState>();
	final NewPropertyViewModel propertyViewModel = NewPropertyViewModel();
	final OwnedPropertyViewModel ownedViewModel = OwnedPropertyViewModel();
	final ScrollController scrollController = ScrollController();
	final List<Widget> propertyTypesPages = [Container()];
	final Boolean isLoading = Boolean(false);
	List imagesToDelete = List.empty(growable: true);
	List<Asset> _images = <Asset>[];
	int _index = 0;
	bool _validate() {
		bool validate = true;
		String error = "";
		if (!_formKey.currentState.validate()) {
			error = "Please fill required information";
			validate = false;
		} else if (_images.isEmpty && widget._property.imagesURLs.length < 1) { // Checks if atleast there is 1 image before updating
			error = "Please add images for the property";
			validate = false;
		}
		if (!validate) {
			ShowToast(widget.scaffoldKey.currentContext).popUp(text: error, color: Colors.red);
		}
		return validate;
	}
	@override
	Widget build(BuildContext context) {
		return WillPopScope(
			onWillPop: () async {
				// askes if wants to exit without saving if  yes it refresh the owned properites again to regain what was lost.
				bool confirmation = await ShowDialog().askForConfirmation(context, "Are you sure you want to go back all changes will not be saved?");
				if (confirmation) {
					widget.refreshOwnedProperties();
				}
				return confirmation;
			},
			child: isLoading.myBool ? Loading(Colors.blue) : Scaffold(
				appBar: AppBar(),
				body:Form(
					key: _formKey,
					child: SingleChildScrollView(
						padding: EdgeInsets.only(left: 20, right: 20),
						child: Column(
							children:<Widget> [
								SizedBox(height: 10),
								// images
								TextButton.icon(
									label: Text(
										"Remove a property image",
										style: TextStyle(
											fontSize: 20,
										),
									),
									icon: Icon(Icons.no_photography_rounded),
									onPressed: () async {
										Navigator.push(context, MaterialPageRoute(builder: (context) => ImageEditor(widget._property, widget.scaffoldKey, imagesToDelete)));
									},
								),
								SizedBox(height: 10),
								TextButton.icon(
									label: Text(
										"Add a new property image",
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
								// Buy or rent buttons
								Row(
									children:[ 
										Builder(
											builder: (context) {
												if (widget._property.adType == "Buy") { 
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
																		widget._property.adType = "Buy";
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
																		widget._property.adType = "Buy";
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
												if (widget._property.adType == "Rent") { 
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
																		widget._property.adType = "Rent";
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
																		widget._property.adType = "Rent";
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
								// price
								TextFormField(
									controller: TextEditingController(text: widget._property.price.toString()),
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
										labelText: "Price"
									),
									onChanged: (value) {
										widget._property.price = int.parse(value);
									},
								),
								SizedBox(height: 10),
								// finishing degree
								TextFormField(
									validator: (val) => val.isEmpty ? "please choose a property finish degree" : null,
									controller: TextEditingController(
										text: widget._property.finish,
									),
									decoration: InputDecoration(
										border: OutlineInputBorder(
											borderSide: BorderSide(
												color: Colors.black,
											),
										),
										labelText: "Property finish degree",
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
																			widget._property.finish = Property.finishingDegree[index];
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
									controller: TextEditingController(text: widget._property.age.toString()),
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
										labelText: "Building age"
									),
									onChanged: (value) {
										widget._property.age = int.parse(value);
									},
								),
								SizedBox(height: 10),
								// bedroom
								TextFormField(
									controller: TextEditingController(text: widget._property.bedroom.toString()),
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
										labelText: "Bedrooms"
									),
									onChanged: (value) {
										widget._property.bedroom = int.parse(value);
									},
								),
								SizedBox(height: 10),
								// bathroom
								TextFormField(
									controller: TextEditingController(text: widget._property.bathroom.toString()),
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
										labelText: "Bathrooms"
									),
									onChanged: (value) {
										widget._property.bathroom = int.parse(value);
									},
								),
								SizedBox(height: 10),
								// livingroom
								TextFormField(
									controller: TextEditingController(text: widget._property.livingroom.toString()),
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
										labelText: "Livingroom"
									),
									onChanged: (value) {
										widget._property.livingroom = int.parse(value);
									},
								),
								SizedBox(height: 10),
								// kitchen
								TextFormField(
									controller: TextEditingController(text: widget._property.kitchen.toString()),
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
										labelText: "Kitchen"
									),
									onChanged: (value) {
										widget._property.kitchen = int.parse(value);
									},
								),
								SizedBox(height: 10),
								// balacone
								TextFormField(
									controller: TextEditingController(text: widget._property.balacone.toString()),
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
										labelText: "Balacone"
									),
									onChanged: (value) {
										widget._property.balacone = int.parse(value);
									},
								),
								SizedBox(height: 10),
								// reception
								TextFormField(
									controller: TextEditingController(text: widget._property.reception.toString()),
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
										labelText: "Reception"
									),
									onChanged: (value) {
										widget._property.reception = int.parse(value);
									},
								),
								SizedBox(height: 10),
								// property types additional forms
								propertyTypesPages[_index],
								// rent or buy additional forms
								widget._property.adType == "Rent" ?
								Rent(widget._property) :
								Buy(widget._property),
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
											value: widget._property.negotiatable,
											onChanged: (value) {
												setState(() {
													widget._property.negotiatable = value;
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
										controller: TextEditingController(text: widget._property.landmarks),
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
											labelText: "Landmarks"
										),
										onChanged: (value) {
											widget._property.landmarks = value; 
										},
									),
								),
								SizedBox(height: 10),
								// flows
								SizedBox(
									height: 120,
									child: TextFormField(
										controller: TextEditingController(text: widget._property.flows),
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
											labelText: "Flows"
										),
										onChanged: (value) {
											widget._property.flows = value; 
										},
									),
								),
								SizedBox(height: 10),
								// additional info
								SizedBox(
									height: 120,
									child: TextFormField(
										controller: TextEditingController(text: widget._property.additionalInformation),
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
											labelText: "Additional information"
										),
										onChanged: (value) {
											widget._property.additionalInformation = value; 
										},
									),
								),
								SizedBox(height: 10),
								// Edit property
								TextButton(
									child: Text(
										"Change property",
										style: TextStyle(
											fontSize: 20
										),
									),
									onPressed: () async {
										setState(() {
											isLoading.myBool = true;
										});
										if (_validate()) {
											if (_images.isNotEmpty) {
												await propertyViewModel.uploadPropertyImages(widget._property.ownerUID, widget._property.uid, _images);
												widget._property.imagesRefs.addAll(propertyViewModel.storeRefsToProperty(widget._property.ownerUID, widget._property.uid, _images));
												widget._property.imagesURLs = await propertyViewModel.storeURLsToProperty(widget._property.imagesRefs);
											}
											await ownedViewModel.permDeletePropertyImage(imagesToDelete);
											await propertyViewModel.updateProperty(widget._property);
											setState(() {
												isLoading.myBool = false;
											});
											widget.refreshOwnedProperties();
											Navigator.pop(context);
											ShowToast(widget.scaffoldKey.currentContext).popUp(text: "Property updated", duration: Duration(milliseconds: 800));
										}
									},
								),
								SizedBox(height: 10),
							],
						)
					),
				),
			),
		);
	}
}