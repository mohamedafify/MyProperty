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
	List<dynamic> ownedPropertiesUIDs = List.filled(0, "", growable: true);
	List<dynamic> favouritePropertiesUIDs = List.filled(0, "", growable: true);

	MyUser(this.uid, this.email) {
		profilePictureURL = "";
		loginStatus = true;
	}
}