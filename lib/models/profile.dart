import 'package:flutter/cupertino.dart';

enum Gender {
	male,
	female,
}

enum LoginStatus {
	online,
	offline
}

class Profile {
	Gender gender;
	Image profilePicture;
	String password;
	String email;
	String address;
	LoginStatus loginStatus;
	
}