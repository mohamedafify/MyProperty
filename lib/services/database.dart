import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:MyProperty/utils/comparisonType.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
	final String uid = AuthService().currentUser.uid;
	final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
	final CollectionReference propertyCollection = FirebaseFirestore.instance.collection("properties");

	Future<MyUser> get currentUser async {
		return await getUserByID(uid);
	}
	Future updateUserData(MyUser user) async {
		return await userCollection.doc(user.uid).set({
			"uid":user.uid,
			"name":user.name,
			"email":user.email,
			"number": user.number,
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
			user.number = snap.get("number");
			user.favouritePropertiesUIDs = snap.get("favouritePropertiesUIDs");
			user.ownedPropertiesUIDs = snap.get("ownedPropertiesUIDs");
			return user;
		} else {
			return null;
		}
	}
	Future<QuerySnapshot> getAllProperties() async {
		return await propertyCollection.get();
	}
	Future<QuerySnapshot> getAllPropertiesByField(String name, String value, ComparisonType comparisonType) async {
		if (comparisonType == ComparisonType.EqualTo) {
			return await propertyCollection.where(name, isEqualTo: value).get();
		} else if (comparisonType == ComparisonType.Contains) {
			return await propertyCollection.where(name, arrayContains: value).get();
		} else {
			return null;
		}
	}
	Future<QuerySnapshot> filterSingleFieldPropertiesBy(Map<String, dynamic> filters) {
		Query query = propertyCollection;
		filters.forEach((key, value) { 
			if (value != "All") {
				query = query.where(key, isEqualTo: value);
			}
		});
		return query.get();
	}
	Future updatePropertyData(Property property) async {
		return await propertyCollection.doc(property.uid).set({
			"ownerUID": property.ownerUID,
			"uid": property.uid,
			"propertyType": property.propertyType,
			"adType": property.adType,
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
			"hasInsurance": property.hasInsurance,
			"imagesRefs": property.imagesRefs,
			"imagesURLs": property.imagesURLs,
			"favouritedByUsersUIDs": property.favouritedByUsersUIDs,
			"houseID": property.location.houseID,
			"country": property.location.country,
			"locality": property.location.locality,
			"street": property.location.street,
			"latlong": property.location.latlong,
			"city": property.location.city,
		}).then((value) => "success" , onError: (value) => null);
	}
	Future<Property> getPropertyByID(String uid) async {
		DocumentSnapshot snap = await propertyCollection.doc(uid).get();
		Property property = Property.fromDocumentSnapshot(snap);
		return property;
	}
	Future<void> deletePropertyByID(String uid) async {
		await propertyCollection.doc(uid).delete();
	}
}
