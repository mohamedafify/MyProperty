import 'package:MyProperty/models/property.dart';

enum Gender {
	male,
	female,
}

class MyUser {
	final String uid;
	final String email;
	String name;
	String profilePictureURL;
	bool loginStatus;
	List<Property> ownedProperties;
	List<Property> favouriteProperties;

	MyUser(this.uid, this.email) {
		profilePictureURL = "";
		loginStatus = true;
	}

	void updateUser({String name}) {
		this.name = name;
	}

}