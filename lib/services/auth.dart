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
		   return _userFromFirebaseUser(FirebaseAuth.instance.currentUser);
		} catch (e) {
			switch(e.code) {
				case "invalid-email":
					return "Email in not valid";
				break;
				case "user-disabled":
					return "this Email is banned";
				break;
				case "user-not-found":
					return "Email not found";
				break;
				case "wrong-password":
					return "Wrong password";
				break;
			}
		}
	}

	// register with email and password
	Future registerWithEmailandPassword(String email, String password, String name, String number) async {
		try {
			await _auth.createUserWithEmailAndPassword(email: email, password: password);
			MyUser myUser = _userFromFirebaseUser(FirebaseAuth.instance.currentUser);
			myUser.name = name;
			myUser.number = number;
			await DatabaseService().updateUserData(myUser);
			return myUser;
		} catch (e) {
			switch(e.code) {
				case "email-already-in-use":
					return "Email already in use";
				break;
				case "invalid-email":
					return "Email in not valid";
				break;
				case "operation-not-allowed":
					return "this Email is banned";
				break;
				case "weak-password":
					return "Password is weak";
				break;
			}
		}
	}

	// Sign out
	Future signOut() async {
		await _auth.signOut();
	}
}