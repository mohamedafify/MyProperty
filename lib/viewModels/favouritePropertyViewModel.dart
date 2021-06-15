import 'dart:async';

import 'package:MyProperty/models/address.dart';
import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/database.dart';
import 'package:MyProperty/utils/comparisonType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritePropertyViewModel {
	DatabaseService _database = DatabaseService();

	Future<List> getFavouriteProperties() async {
		MyUser currentUser = await _database.currentUser;
		QuerySnapshot snapshot = await _database.getAllPropertiesByField("favouritedByUsersUIDs", currentUser.uid, ComparisonType.Contains);
		List<Property> properties = List<Property>.empty(growable: true);
		Future.forEach(snapshot.docs, (propertySnapshot) async {
			Property property = Property.fromDocumentSnapshot(propertySnapshot);
			properties.add(property);
		});
		return properties;
	}
}