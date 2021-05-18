import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/database.dart';

class PropertyPreviewViewModel {
	final DatabaseService _database = DatabaseService();
	MyUser currentUser;

	Future<bool> isFavourite(Property property) async {
		currentUser = await _database.currentUser;
		if (currentUser.favouritePropertiesUIDs.contains(property.uid)) {
			return true;
		} else {
			return false;
		}
	}
	Future addPropertyToFavourites(Property property) async {
		currentUser = await _database.currentUser;
		currentUser.favouritePropertiesUIDs.add(property.uid);
		return await _database.updateUserData(currentUser);
	}
	Future removePropertyToFavourites(Property property) async {
		currentUser = await _database.currentUser;
		currentUser.favouritePropertiesUIDs.remove(property.uid);
		return await _database.updateUserData(currentUser);
	}
	Future addOwnerIdToProperty(Property property) async {
		currentUser = await _database.currentUser;
		property.favouritedByUsersUIDs.add(currentUser.uid);
		await _database.updatePropertyData(property);
	}
	Future removeOwnerIdToProperty(Property property) async {
		currentUser = await _database.currentUser;
		property.favouritedByUsersUIDs.remove(currentUser.uid);
		await _database.updatePropertyData(property);
	}
}