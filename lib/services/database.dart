import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

	final String uid = AuthService().currentUser.uid;
	// final AuthService _auth = AuthService();
	final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
	final CollectionReference propertyCollection = FirebaseFirestore.instance.collection("properties");

	Future updateUserData(MyUser user) async {
		return await userCollection.doc(uid).set({
			"uid":user.uid,
			"name":user.name,
			"email":user.email,
			"profilePictureURL":user.profilePictureURL,
			"ownedPropertiesUIDs":user.ownedPropertiesUIDs,
			"favouritePropertiesUIDs":user.favouritePropertiesUIDs,
		}).then((value) => "success" , onError: (value) => null);
	}

	Future<MyUser> getUserByID(String uid) async {
		MyUser user = MyUser(uid, "");
		DocumentSnapshot snap = await userCollection.doc(uid).get();
		if (snap.exists) {
			user.name = snap.get("name");
			user.email = snap.get("email");
			user.favouritePropertiesUIDs = snap.get("favouritePropertiesUIDs");
			user.ownedPropertiesUIDs = snap.get("ownedPropertiesUIDs");
			user.profilePictureURL = snap.get("profilePictureURL");
			return user;
		} else {
			return null;
		}
	}

	Future<void> addPropertyToCurrentUser(Property property) async {
		MyUser user = await getUserByID(uid);
		// checks if this property is being edited or newly created
		if (!user.ownedPropertiesUIDs.contains(property.uid)) {
			user.ownedPropertiesUIDs.add(property.uid);
			await updateUserData(user);
		}
	}

	Future<QuerySnapshot> getAllProperty() async {
		return await propertyCollection.get();
	}

	Future updatePropertyData(Property property) async {
		await addPropertyToCurrentUser(property);
		return await propertyCollection.doc(property.uid).set({
			"ownerUID": property.ownerUID,
			"type": property.propertyType,
			"location": property.location,
			"postDate": property.postDate,
			"negotiatable": property.negotiatable,
			"size": property.size,
			"price": property.price,
			"finish": property.finish,
			"flows": property.flows,
			"landmarks": property.landmarks,
			"age": property.age,
			"additionalInformation": property.additionalInformation,
			"bedroom": property.bedroom,
			"bathroom": property.bathroom,
			"livingroom": property.livingroom,
			"kitchen": property.kitchen,
			"balacone": property.balacone,
			"reception": property.reception,
			"sold": property.sold,
			"installments": property.installments,
			"installmentsPerMonth": property.installmentPerMonth,
			"installmentsPremium": property.installmentPremium,
			"floorNumber": property.floorNumber,
			"elevator": property.elevator,
			"security": property.security,
			"yard": property.yard,
			"roof": property.roof,
			"garage": property.garage,
			"numberOfFloors": property.numberOfFloors,
			"swimmingPool": property.swimmingPool,
			"rentableAt": property.rentableAt,
			"maxRent": property.maxRent,
			"rented": property.rented,
			"petFriendly": property.petFriendly,
			"modifiable": property.modifiable,
			"rentedBefore": property.rentedBefore,
			"insurance": property.insurance,
		}).then((value) => "success" , onError: (value) => null);
	}

	Property propertyFromDocumentSnapshot(DocumentSnapshot snap) {
		Property property = Property();
		if (snap.exists) {
			property.ownerUID = snap.get("ownerUID");
			property.propertyType = snap.get("type");
			property.location = snap.get("location");
			property.postDate = snap.get("postDate").toDate();
			property.negotiatable = snap.get("negotiatable");
			property.size = snap.get("size");
			property.price = snap.get("price");
			property.finish = snap.get("finish");
			property.flows = snap.get("flows");
			property.landmarks = snap.get("landmarks");
			property.age = snap.get("age");
			property.additionalInformation = snap.get("additionalInformation");
			property.bedroom = snap.get("bedroom");
			property.bathroom = snap.get("bathroom");
			property.livingroom = snap.get("livingroom");
			property.kitchen = snap.get("kitchen");
			property.balacone = snap.get("balacone");
			property.reception = snap.get("reception");
			property.sold = snap.get("sold");
			property.installments = snap.get("installments");
			property.installmentPerMonth = snap.get("installmentsPerMonth");
			property.installmentPremium = snap.get("installmentsPremium");
			property.floorNumber = snap.get("floorNumber");
			property.elevator = snap.get("elevator");
			property.security = snap.get("security");
			property.yard = snap.get("yard");
			property.roof = snap.get("roof");
			property.garage = snap.get("garage");
			property.numberOfFloors = snap.get("numberOfFloors");
			property.swimmingPool = snap.get("swimmingPool");
			// property.rentableAt = snap.get("rentableAt").toDate();
			property.maxRent = snap.get("maxRent");
			property.rented = snap.get("rented");
			property.petFriendly = snap.get("petFriendly");
			property.modifiable = snap.get("modifiable");
			property.rentedBefore = snap.get("rentedBefore");
			property.insurance = snap.get("insurance");
			return property;
		} else {
			return null;
		}
	}
	Future<Property> getPropertyByID(String uid) async {
		DocumentSnapshot snap = await propertyCollection.doc(uid).get();
		return propertyFromDocumentSnapshot(snap);
	}
}