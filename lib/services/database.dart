import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

	final String uid;
	DatabaseService({this.uid});

	final CollectionReference propertyCollection = FirebaseFirestore.instance.collection("users");

	Future updateUserData(MyUser user) async {
		return await propertyCollection.doc(uid).set({
			"uid":user.uid,
			"name":user.name,
			"email":user.email,
			"profilePictureURL":user.profilePictureURL,
			"loginStatus":user.loginStatus,
			"ownedProperties":user.ownedProperties,
			"favouriteProperties":user.favouriteProperties,
		});
	}
}