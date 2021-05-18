import 'dart:async';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class DatabaseStorageService {
	final Reference root = FirebaseStorage.instance.ref();

	Future<List> uploadPropertyImages(String userUID, String propertyUID, List<Asset> imagesPaths) {
		return Future.wait(imagesPaths.map((element) async {
			ByteData byteData = await element.getByteData(quality: 40);
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

	Future storeImagesDownloadURLs(List<String> imagesRefs) async {
		Reference imageRef;
		Future<List<String>> urls = Future.wait(imagesRefs.map((element) async {
			imageRef = root.child(element);
			return await imageRef.getDownloadURL();
		}));
		return urls;
	}

	Future deletePropertyImages(List propertiesRefs) async {
		propertiesRefs.forEach((element) async { 
			Reference imagesRefs = root.child(element);
			await imagesRefs.delete();
		});
	}
}