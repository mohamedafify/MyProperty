import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/database.dart';
import 'package:MyProperty/services/databaseStorage.dart';

class OwnedPropertyViewModel {
	DatabaseService _database = DatabaseService();
	DatabaseStorageService _storage = DatabaseStorageService();

	Future<List> getOwnedProperties() async {
		MyUser currentUser = await _database.currentUser;
		return Future.wait(currentUser.ownedPropertiesUIDs.map((element) async {
			return await _database.getPropertyByID(element);
		}).toList());
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
}