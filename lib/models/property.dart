import 'package:uuid/uuid.dart';

class Room {
	int length, width, height;
	Room(int length, int width, int height) {
		length = length;
		width = width;
		height = height;
	}
	int area () {
		return length * width;
	}
}

abstract class Property {
	static List<String> types = [
		"Apartment",
		"Villa",
		"BeachHouse",
		"Chalet",
		"Studio",
		"Office",
		"Warehouse",
		"Store"
	];
	List<String> photosURLs;
	String ownerUID;
	String uid;
	String type;
	String location;
	DateTime postDate = DateTime.now();
	bool negotiatable = false;
	int size;
	int price;
	int floor;
	PropertyDescription description;

	Property() {
		this.uid = Uuid().v1();
	}
}

class RentProperty extends Property {
	DateTime rentableAt;
	int maxRent;
	bool rented;
	bool petFriendly;
	bool modifiable;
	bool rentedBefore;
	int insurance;
}

class BuyProperty extends Property{
	bool sold;
	bool installments;
	int installmentPerMonth;
	int installmentPremium;
}

class PropertyDescription {
	String flows;
	List<String> landmarks;
	DateTime buildDate;
	bool security;
	LayoutDetails details;
	String extraDetails;
}

class LayoutDetails {
	List<Room> bedroom;
	List<Room> swimmingPool;
	List<Room> bathroom;
	List<Room> livingroom;
	List<Room> kitchen;
	List<Room> balacone;
	List<Room> yard;
	List<Room> roof;
	List<Room> reception;
	bool garage;
}