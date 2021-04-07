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
	List<String> imagesUIDs;
	String ownerUID;
	String uid;
	String propertyType;
	String location;
	DateTime postDate;
	bool negotiatable;
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
	bool rented;
	bool petFriendly;
	bool modifiable;
	bool rentedBefore;
	int insurance;
	bool sold;
	bool installments;
	int installmentPerMonth;
	int installmentPremium;
	int floorNumber;
	bool elevator;
	bool security;
	bool yard;
	bool roof;
	bool garage;
	int numberOfFloors;
	bool swimmingPool;
	Property() {
		postDate = DateTime.now();
		ownerUID = AuthService().currentUser.uid;
		adType = "Buy";
		negotiatable = false;
		elevator = false;
		security = false;
		yard = false;
		roof = false;
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