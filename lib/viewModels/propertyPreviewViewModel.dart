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
		MyUser user = currentUser;
		user.favouritePropertiesUIDs.add(property.uid);
		return await _database.updateUserData(user);
	}
	Future removePropertyToFavourites(Property property) async {
		currentUser = await _database.currentUser;
		MyUser user = currentUser;
		user.favouritePropertiesUIDs.remove(property.uid);
		return await _database.updateUserData(user);
	}
}