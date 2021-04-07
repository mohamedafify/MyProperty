import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/services/database.dart';
import 'package:MyProperty/services/databaseStorage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PropertyViewModel {
	final DatabaseService _database = DatabaseService();
	final DatabaseStorageService _databaseStorage = DatabaseStorageService();
	Future updateProperty(Property property) async {
		return await _database.updatePropertyData(property);
	}
	Future addNewImage(String userUID, String propertyUID, List<Asset> filePath) async {
		await _databaseStorage.storePropertyImageToUser(userUID, propertyUID, filePath);
	}
}