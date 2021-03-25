import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

	final String uid = AuthService().currentUser.uid;
	final AuthService _auth = AuthService();
	final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
	final CollectionReference buyPropertyCollection = FirebaseFirestore.instance.collection("buyProperties");
	final CollectionReference rentPropertyCollection = FirebaseFirestore.instance.collection("rentProperties");

	Future<void> updateUserData(MyUser user) async {
		await userCollection.doc(uid).set({
			"uid":user.uid,
			"name":user.name,
			"email":user.email,
			"profilePictureURL":user.profilePictureURL,
			"loginStatus":user.loginStatus,
			"ownedPropertiesUIDs":user.ownedPropertiesUIDs,
			"favouritePropertiesUIDs":user.favouritePropertiesUIDs,
		});
	}

	Future<void> updateBuyPropertyData(Property property) async {
		// await addPropertyToCurrentUser(property);
		await buyPropertyCollection.doc(property.uid).set({
			"ownerID": property.ownerID,
			"type": property.type,
			"location": property.location,
			"postDate": property.postDate,
			"negotiatable": property.negotiatable,
			"size": property.size,
			"price": property.price,
		});
	}

	// Future<void> addPropertyToCurrentUser(Property property) async {
	// 	if (!user.ownedPropertiesUIDs.contains(property.uid)) {
	// 		MyUser user = await getUserByID(uid);
	// 		user.ownedPropertiesUIDs.add(property.uid);
	// 		await updateUserData(user);
	// 	}
	// }

	// Future<Property> getBuyPropertyByID(String uid) async {
	// 	Property property = BuyProperty();
	// 	DocumentSnapshot snap = await buyPropertyCollection.doc(uid).get();
	// 	if (snap.exists) {
	// 		property.ownerID = snap.get("ownerID");
	// 		property.ownerID = snap.get("ownerID");
	// 		property.ownerID = snap.get("ownerID");
	// 		property.ownerID = snap.get("ownerID");
	// 		property.ownerID = snap.get("ownerID");
	// 		property.ownerID = snap.get("ownerID");
	// 		property.ownerID = snap.get("ownerID");
	// 		property.ownerID = snap.get("ownerID");
	// 	}
	// }

	Future<MyUser> getUserByID(String uid) async {
		MyUser user = _auth.currentUser;
		DocumentSnapshot snap = await userCollection.doc(uid).get();
		if (snap.exists) {
			user.name = snap.get("name");
			user.favouritePropertiesUIDs = snap.get("favouritePropertiesUIDs");
			user.loginStatus = snap.get("loginStatus");
			user.ownedPropertiesUIDs = snap.get("ownedPropertiesUIDs");
			user.profilePictureURL = snap.get("profilePictureURL");
			return user;
		} else {
			return null;
		}
	}

}