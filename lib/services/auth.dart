import 'dart:developer' as developer;

import 'package:MyProperty/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:MyProperty/models/user.dart';

class AuthService {
	final FirebaseAuth _auth = FirebaseAuth.instance;

	// creates MyUser from firebase User
	MyUser _userFromFirebaseUser(User user) {
		return (user != null) ? MyUser(user.uid, user.email) : null;
	}

	// authentication change for user sign in/out
	Stream<MyUser> get user {
		return _auth.authStateChanges()
			.map(_userFromFirebaseUser);
			// map the authentication state change to MyUser
	}

	MyUser get currentUser {
		return _userFromFirebaseUser(FirebaseAuth.instance.currentUser);
	}

	// Sign in with email and password
	Future signInEmailandPassword({String email, String password}) async {
		try {
		   await _auth.signInWithEmailAndPassword(email: email, password: password);
		   developer.log("signedIn Successfully", name: "auth_signIn");
		   return _userFromFirebaseUser(FirebaseAuth.instance.currentUser);
		} catch (e) {
			developer.log(e.toString(), name: "auth_signInERROR");
			return null;
		}
	}

	// register with email and password
	Future registerWithEmailandPassword(String email, String password, String name) async {
		try {
			await _auth.createUserWithEmailAndPassword(email: email, password: password);
			developer.log("registered Successfully", name: "auth_register");
			MyUser myUser = _userFromFirebaseUser(FirebaseAuth.instance.currentUser);
			myUser.name = name;
			await DatabaseService().updateUserData(myUser);
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
}