import 'package:MyProperty/models/address.dart';
import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/services/geolocation.dart';
import 'package:MyProperty/utils/showToast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LocationPicker extends StatefulWidget {
	final Property property;
	final GlobalKey scaffoldKey;
	LocationPicker(this.property, this.scaffoldKey);
	@override
	_LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
	LatLng center = LatLng(30.04, 31.24);
	MapController controller;
	LatLng pinLocation;
	double zoom;
	@override
	void initState() {
		controller = MapController();
		pinLocation = center;
		zoom = 10.0;
		super.initState();
	}

	Future<Position> _determinePosition() async {
		bool serviceEnabled;
		LocationPermission permission;

		// Test if location services are enabled.
		serviceEnabled = await Geolocator.isLocationServiceEnabled();
		if (!serviceEnabled) {
			ShowToast(widget.scaffoldKey.currentContext).popUp(text: "Please open your GPS", color: Colors.red);
		}

		permission = await Geolocator.checkPermission();
		if (permission == LocationPermission.denied) {
			permission = await Geolocator.requestPermission();
			if (permission == LocationPermission.denied) {
				ShowToast(widget.scaffoldKey.currentContext).popUp(text: "Please allow the app to use GPS", color: Colors.red);
			}
		}
		
		if (permission == LocationPermission.deniedForever) {
			ShowToast(widget.scaffoldKey.currentContext).popUp(text: "Please allow the app to use GPS", color: Colors.red);
		} 

		return await Geolocator.getCurrentPosition();
	}
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				actions: [
					IconButton(
						icon: Icon(Icons.check),
						iconSize: 30,
						color: Colors.white,
						onPressed: () async {
							Response response = await GeoLocation().getLocation(pinLocation, "en");
							Address myAddress = Address.fromGeocodejsonToAddress(response.body);
							GeoPoint firebaseLatLng = GeoPoint(pinLocation.latitude, pinLocation.longitude);
							myAddress.latlong = firebaseLatLng;
							widget.property.location = myAddress;
							Navigator.pop(context);
						},
					)
				],
			),
			body: FlutterMap(
				mapController: controller,
				options: MapOptions(
					interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
					minZoom: 10.0,
					maxZoom: 18.4,
					zoom: zoom,
					center: center,
					onTap: (location) {
						setState(() {
							pinLocation = location;
						});
					}
				),
				layers: [
					TileLayerOptions(
						urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
						subdomains: ["a", "b", "c"],
					),
					MarkerLayerOptions(
						markers: [
							Marker(
								width: 40.0,
								height: 40.0,
								point: pinLocation,
								builder: (context) => Container(
										child: Icon(
											Icons.location_on,
											color: Colors.red,
											size: 40.0,
										),
								),
							),
						]
					),
				],
			),
			floatingActionButton: FloatingActionButton(
				child: Icon(Icons.my_location),
				onPressed: () async {
					Position position = await _determinePosition();
					setState(() {
						zoom = 18.4;
						pinLocation = LatLng(position.latitude, position.longitude);
						center = LatLng(position.latitude, position.longitude);
						controller.move(center, zoom);
					});
				},
			),
		);
	}
}