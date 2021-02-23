import 'package:flutter/cupertino.dart';

enum Gender {
	male,
	female,
	other
}

enum LoginStatus {
	online,
	offline
}
class User {
	final String uid;
	final Gender gender;
	Image profilePicture;
	String name;
	String password;
	String email;
	String address;
	LoginStatus loginStatus;

	User(String name, this.uid, String password, String email, this.gender, String address) {
		this.name = name;
		this.password = password;
		this.email = email;
		this.address = address;
	}
}