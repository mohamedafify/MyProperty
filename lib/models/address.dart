import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
	String houseNumber;
	String country;
	String city;
	String locality;
	String street;
	GeoPoint latlong;

	@override
	toString() {
		return "$houseNumber, $street, $locality, $city, $country";
	}

	Map<String, dynamic> toJson() => {
		"country": country,
		"city": city,
		"locality": locality,
		"street": street,
		"latlong": latlong,
		"houseNumber": houseNumber,
	};
	static Address fromJson(Map<String, dynamic> location) {
		Address address = Address();
		location.entries.forEach((element) {
			switch (element.key) {
			  case "city":
				address.city = element.value;
				break;
			  case "country":
				address.country = element.value;
				break;
			  case "houseNumber":
				address.houseNumber = element.value;
				break;
			  case "locality":
				address.locality = element.value;
				break;
			  case "street":
				address.street = element.value;
				break;
			  case "latlong":
				address.latlong = element.value;
				break;
			}
		});
		return address;
	}
	static Address fromGeocodejson(String location) {
		Address myAddress = Address();
		jsonDecode(location, reviver: (key, value) { 
			switch (key.toString()) {
			  case "country":
				myAddress.country = value.toString();
				break;
			  case "city":
				myAddress.city = value.toString();
				break;
			  case "locality":
				myAddress.locality = value.toString();
				break;
			  case "street":
				myAddress.street = value.toString();
				break;
			}
			return "";
		});
		return myAddress;
	}
}