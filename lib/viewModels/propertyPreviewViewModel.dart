import 'package:MyProperty/services/databaseStorage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PropertyPreviewViewModel {
	final DatabaseStorageService _storage = DatabaseStorageService();
	Future getImageUrl(String url) async {
		return await _storage.getImageDownloadURL(url);
	}
}