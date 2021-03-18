import 'package:flutter/cupertino.dart';

abstract class Property {
	Image photos;
	String title;
	String location;
	DateTime postDate;
	bool negotiatable;
	int area;
	int price;
	PropertyDescription description;
}

class RentProperty extends Property{
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
	int bedroom;
	int swimmingPool;
	int bathroom;
	int livingroom;
	int kitchen;
	int balacone;
	bool garage;
	bool yard;
	bool roof;
	bool reception;
}