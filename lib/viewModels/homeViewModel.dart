import 'dart:async';
import 'package:MyProperty/models/address.dart';
import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeViewModel {
	DatabaseService _database = DatabaseService();
	Future<List> getAllProperties() async {
		QuerySnapshot query = await _database.getAllProperty();
		List<Property> properties = List<Property>.empty(growable: true);
		Completer<List<Property>> propertiesCompleter = Completer<List<Property>>();
		Future.forEach(query.docs, (propertySnapshot) async {
			Property property = Property.fromDocumentSnapshot(propertySnapshot);
			var locationCollectionRef = await _database.propertyCollection.doc(propertySnapshot.id).collection("location").doc("1").get();
			property.location = Address.fromJson(locationCollectionRef.data());
			properties.add(property);
		}).then((value) => propertiesCompleter.complete(properties));
		return propertiesCompleter.future;
	}
}