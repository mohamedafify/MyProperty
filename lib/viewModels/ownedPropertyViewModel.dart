import 'dart:async';
import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/database.dart';
import 'package:MyProperty/services/databaseStorage.dart';
import 'package:MyProperty/utils/comparisonType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OwnedPropertyViewModel {
	DatabaseService _database = DatabaseService();
	DatabaseStorageService _storage = DatabaseStorageService();

	Future<List> getOwnedProperties() async {
		MyUser currentUser = await _database.currentUser;
		QuerySnapshot snapshot = await _database.getAllPropertiesByField("ownerUID", currentUser.uid, ComparisonType.EqualTo);
		List<Property> properties = List<Property>.empty(growable: true);
		Future.forEach(snapshot.docs, (propertySnapshot) async {
			Property property = Property.fromDocumentSnapshot(propertySnapshot);
			properties.add(property);
		});
		return properties;
	}

	Future deleteProperty(String propertyUID, List propertiesRefs, List favourtedByUsersUids) async {
		// remove uid of property in the user's favourites list
		favourtedByUsersUids.forEach((element) async { 
			MyUser user = await _database.getUserByID(element);
			user.favouritePropertiesUIDs.remove(propertyUID);
			await _database.updateUserData(user);
		});
		// delete images from Storage
		await _storage.deletePropertyImages(propertiesRefs);
		// delete property document from Cloud
		await _database.deletePropertyByID(propertyUID);
		// remove property id from user ownedProperties
		MyUser currentUser = await _database.currentUser;
		currentUser.ownedPropertiesUIDs.remove(propertyUID);
		await _database.updateUserData(currentUser);
	}

	String tempDeletePropertyImage(Property property, int index) {
		String ref = property.imagesRefs.elementAt(index);
		property.imagesRefs.removeAt(index);
		property.imagesURLs.removeAt(index);
		return ref;
	}

	Future permDeletePropertyImage(List refs) async {
		await _storage.deletePropertyImages(refs);
	}
}