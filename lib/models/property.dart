import 'package:MyProperty/models/address.dart';
import 'package:MyProperty/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Property {
	static List<String> types = [
		"Apartment",
		"Villa",
	];
	static List<String> finishingDegree = [
		"none",
		"half",
		"full",
		"lux",
		"superLux",
		"ultraLux",
		"superDelux",
	];
	String adType;
	List<dynamic> imagesRefs;
	List<dynamic> imagesURLs;
	List<dynamic> favouritedByUsersUIDs;
	String ownerUID;
	String uid;
	String propertyType;
	Address location;
	DateTime postDate;
	int size;
	int price;
	String finish;
	String flows;
	String landmarks;
	int age;
	String additionalInformation;
	int bedroom;
	int bathroom;
	int livingroom;
	int kitchen;
	int balacone;
	int reception;
	DateTime rentableAt;
	int maxRent;
	bool hasInsurance;
	int insurance;
	int installmentPerMonth;
	int installmentPremium;
	int floorNumber;
	int numberOfFloors;
	bool elevator;
	bool security;
	bool yard;
	bool roof;
	bool garage;
	bool sold;
	bool installments;
	bool rented;
	bool petFriendly;
	bool modifiable;
	bool rentedBefore;
	bool negotiatable;
	bool swimmingPool;
	Property() {
		favouritedByUsersUIDs = List.filled(0, "", growable: true);
		postDate = DateTime.now();
		ownerUID = AuthService().currentUser.uid;
		adType = "Buy";
		negotiatable = false;
		elevator = false;
		security = false;
		sold = false;
		yard = false;
		roof = false;
		hasInsurance = false;
		garage = false;
		installments = false;
		swimmingPool = false;
		rented = false;
		petFriendly = false;
		modifiable = false;
		rentedBefore = false;
		uid = Uuid().v4();
	}
	static fromDocumentSnapshot(DocumentSnapshot snap) {
		Property property = Property();
		if (snap.exists) {
			property.ownerUID = snap.get("ownerUID");
			property.uid = snap.get("uid");
			property.propertyType = snap.get("propertyType");
			property.adType = snap.get("adType");
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
			property.maxRent = snap.get("maxRent");
			property.rented = snap.get("rented");
			property.petFriendly = snap.get("petFriendly");
			property.modifiable = snap.get("modifiable");
			property.rentedBefore = snap.get("rentedBefore");
			property.insurance = snap.get("insurance");
			property.hasInsurance = snap.get("hasInsurance");
			property.imagesRefs = snap.get("imagesRefs");
			property.imagesURLs = snap.get("imagesURLs");
			property.favouritedByUsersUIDs = snap.get("favouritedByUsersUIDs");
			if (snap.get("rentableAt") != null) {
				property.rentableAt = snap.get("rentableAt").toDate();
			}
			Address myAddress = Address();
			myAddress.city = snap.get("city");
			myAddress.houseID = snap.get("houseID");
			myAddress.country = snap.get("country");
			myAddress.latlong = snap.get("latlong");
			myAddress.locality = snap.get("locality");
			myAddress.street = snap.get("street");
			property.location = myAddress;
			return property;
		} else {
			return null;
		}
	}
}