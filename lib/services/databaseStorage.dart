import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class DatabaseStorageService {
	final Reference root = FirebaseStorage.instance.ref();

	Future storePropertyImageToUser(String userUID, String propertyUID, List<Asset> imagesPaths) async {
		imagesPaths.forEach((element) async { 
			ByteData byteData = await element.getByteData();
			List<int> imageData = byteData.buffer.asUint8List();
			Reference imagesRef = root.child(userUID).child(propertyUID).child(element.name);
			imagesRef.putData(imageData);
		});
	}
}