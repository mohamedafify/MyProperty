import 'dart:async';
import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/services/database.dart';
import 'package:MyProperty/utils/search/searchCategories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeViewModel {
	SearchCategories searchCategories;
	HomeViewModel(SearchCategories searchCategories) {
		this.searchCategories = searchCategories;
	}
	final DatabaseService _database = DatabaseService();
	Future<List> getAllProperties() async {
		QuerySnapshot query = await _database.getAllProperties();
		List<Property> properties = List<Property>.empty(growable: true);
		Future.forEach(query.docs, (propertySnapshot) {
			Property property = Property.fromDocumentSnapshot(propertySnapshot);
			properties.add(property);
		});
		return properties;
	}
	Future<List> filterProperties() async {
		QuerySnapshot query = await
				_database.filterSingleFieldPropertiesBy(searchCategories.filterValues);
		List<Property> properties = List<Property>.empty(growable: true);
		Future.forEach(query.docs, (propertySnapshot) {
			Property property = Property.fromDocumentSnapshot(propertySnapshot);
			properties.add(property);
		});
		return properties;
	}
}
