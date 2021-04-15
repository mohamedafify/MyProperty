import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class DatabaseStorageService {
	final Reference root = FirebaseStorage.instance.ref();

	Future<List> uploadPropertyImages(String userUID, String propertyUID, List<Asset> imagesPaths) {
		return Future.wait(imagesPaths.map((element) async {
			ByteData byteData = await element.getByteData();
			List<int> imageData = byteData.buffer.asUint8List();
			Reference imageRef = root.child(userUID).child(propertyUID).child(element.name);
			await imageRef.putData(imageData);
		}).toList());
	}

	List<String> storeRefsToProperty(String userUID, String propertyUID, List<Asset> imagesPaths) {
		List<String> imagesRefs = List.empty(growable: true);
		imagesPaths.forEach((element) {
			Reference imageRef = root.child(userUID).child(propertyUID).child(element.name);
			imagesRefs.add(imageRef.fullPath);
		});
		return imagesRefs;
	}

	Future<String> getImageDownloadURL(String url) async {
		Reference imageRef = root.child(url);
		return await imageRef.getDownloadURL();
	}
}