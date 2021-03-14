import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:MyProperty/models/user.dart';

class AuthService {
	final FirebaseAuth _auth = FirebaseAuth.instance;

	// creates MyUser from firebase User
	MyUser _userFromFirebaseUser(User user) {
		return (user != null) ? MyUser(user.displayName, user.uid, user.email) : null;
	}

	// authentication change for user sign in/out
	Stream<MyUser> get user {
		return _auth.authStateChanges()
			.map(_userFromFirebaseUser);
			// map the authentication state change to MyUser
	}

	// Sign in with email and password
	Future signInEmailandPassword({String email, String password}) async {
		try {
		   UserCredential credintials = await _auth.signInWithEmailAndPassword(email: email, password: password);
		   MyUser myUser = _userFromFirebaseUser(credintials.user);
		   developer.log("signedIn Successfully", name: "auth_signIn");
		   return myUser;
		} catch (e) {
			developer.log(e.toString(), name: "auth_signInERROR");
			return null;
		}
	}

	// register with email and password
	Future registerWithEmailandPassword(String email, String password, String firstName, String secondName) async {
		try {
			UserCredential credintials = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			credintials.user.updateProfile(displayName: firstName+" "+secondName);
			MyUser myUser = _userFromFirebaseUser(credintials.user);
			developer.log("registered Successfully", name: "auth_register");
			return myUser;
		} catch (e) {
			developer.log(e.toString(), name: "auth_registerERROR");
			return null;
		}
	}

	// Sign out
	Future signOut() async {
		try {
			developer.log("Signed Out Successfully", name: "auth_signOut");
			return await _auth.signOut();
		} catch (e) {
			developer.log(e.toString(), name: "auth_signOutERROR");
			return null;
		}
	}
	//TODO register with Gmail

}