import 'package:MyProperty/models/address.dart';
import 'package:MyProperty/services/auth.dart';
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
}