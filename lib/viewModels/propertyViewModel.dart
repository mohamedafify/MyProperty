import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/database.dart';
import 'package:MyProperty/services/databaseStorage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PropertyViewModel {
	final DatabaseService _database = DatabaseService();
	final DatabaseStorageService _storage = DatabaseStorageService();

	Future<void> addPropertyToCurrentUser(Property property) async {
		MyUser user = await _database.currentUser;
		// checks if this property is being edited or newly created
		if (!user.ownedPropertiesUIDs.contains(property.uid)) {
			user.ownedPropertiesUIDs.add(property.uid);
			await _database.updateUserData(user);
		}
	}
	Future updateProperty(Property property) async {
		await addPropertyToCurrentUser(property);
		return await _database.updatePropertyData(property);
	}
	Future uploadPropertyImages(String userUID, String propertyUID, List<Asset> filePath) async {
		return await _storage.uploadPropertyImages(userUID, propertyUID, filePath);
	}
	List storeRefsToProperty(String userUID, String propertyUID, List<Asset> imagesPaths) {
		return _storage.storeRefsToProperty(userUID, propertyUID, imagesPaths);
	}
	Future storeURLsToProperty(List<String> imagesRefs) async {
		return await _storage.storeImagesDownloadURLs(imagesRefs);
	}
}