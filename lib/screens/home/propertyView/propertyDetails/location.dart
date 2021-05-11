import 'package:MyProperty/models/property.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';

class LocationShower extends StatefulWidget {
	final Property property;
	LocationShower(this.property);
	@override
	_LocationShowerState createState() => _LocationShowerState();
}

class _LocationShowerState extends State<LocationShower> {
	LatLng center;
	@override
	void initState() {
		GeoPoint point = widget.property.location.latlong; 
		center = LatLng(point.latitude, point.longitude);
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(),
			body: FlutterMap(
				options: MapOptions(
					interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
					minZoom: 10.0,
					maxZoom: 18.4,
					zoom: 18.4,
					center: center,
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
							point: center,
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
		);
	}
}
