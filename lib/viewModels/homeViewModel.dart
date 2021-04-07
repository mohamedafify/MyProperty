import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeViewModel {
	DatabaseService _database = DatabaseService();
	Future<List<Property>> getAllProperties() async {
		List<Property> properties = List.empty(growable: true);
		QuerySnapshot query = await _database.getAllProperty();
		query.docs.forEach((element) {
			properties.add(_database.propertyFromDocumentSnapshot(element));
		});
		return properties;
	}
}