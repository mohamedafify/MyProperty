import 'dart:convert';

import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;

class GeoLocation {
	Future getLocation(LatLng location, String lang) async {
		return await http.get(Uri.parse("https://nominatim.openstreetmap.org/reverse?lat=${location.latitude}&lon=${location.longitude}&format=geocodejson&accept-language=$lang"));
	}
}