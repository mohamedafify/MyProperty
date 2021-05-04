import 'package:MyProperty/models/property.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:map/map.dart';
import 'package:latlng/latlng.dart';

class LocationPicker extends StatefulWidget {
	final Property property;
	LocationPicker(this.property);
	@override
	_LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
	final MapController mapController = MapController(location: LatLng(0, 0));
	Offset _dragStart;
	double _scaleStart = 1.0;

	void _gotoDefault() {
		mapController.center = LatLng(0, 0);
	}
	void _onDoubleTap() {
		mapController.zoom += 0.5;
	}
	void _onScaleStart(ScaleStartDetails details) {
		_dragStart = details.focalPoint;
		_scaleStart = 1.0;
	}
	void _onScaleUpdate(ScaleUpdateDetails details) {
		final scaleDiff = details.scale - _scaleStart;
		_scaleStart = details.scale;

		if (scaleDiff > 0) {
			mapController.zoom += 0.02;
		} else if (scaleDiff < 0) {
			mapController.zoom -= 0.02;
		} else {
			final now = details.focalPoint;
			final diff = now - _dragStart;
			_dragStart = now;
			mapController.drag(diff.dx, diff.dy);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Container(
			child: GestureDetector(
				onDoubleTap: _onDoubleTap,
				onScaleStart: _onScaleStart,
				onScaleUpdate: _onScaleUpdate,
				onScaleEnd: (details) {
					print("Location: ${mapController.center.latitude}, ${mapController.center.longitude}");
				},
				child: Stack(
					children:<Widget> [
						Map(
							controller: mapController,
							builder: (context, x, y, z) {
								final url = "https://www.google.com/maps/d/edit?mid=1WQa6LtpVTHhe66pS8mxeYu9oIkA-qm20&ll=$x.$y&z=$z";
								// final url = "https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i443148310!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e1!5m4!1e4!8m2!1e0!1e1!6m7!1e12!2i2!26m1!4b1!39b1!44e1!50e0!23i4111425!23i1358757!23i1358902";
								return CachedNetworkImage(
									imageUrl: url,
									fit: BoxFit.cover,
								);
							},

						),
						// Center(
						// 	child: Icon(Icons.close, color: Colors.red),
						// )
					],
				),
			),

		);
	}
}