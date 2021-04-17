import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/services/database.dart';
import 'package:MyProperty/services/databaseStorage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PropertyViewModel {
	final DatabaseService _database = DatabaseService();
	final DatabaseStorageService _storage = DatabaseStorageService();
	Future updateProperty(Property property) async {
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