import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_property/models/user.dart';

class AuthService {
	final FirebaseAuth _auth = FirebaseAuth.instance;

	// change firebase user to MyUser
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
		   User user = credintials.user;
		   return user;
		} catch (e) {
			print(e.toString());
			return null;
		}
	}

	// register with email and password
	Future registerWithEmailandPassword({String email, String password}) async {
		try {
			UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			User user = credential.user;
			return user;
		} catch (e) {
			print(e.toString());
			return null;
		}
	}

	// Sign out
	Future signOut() async {
		try {
			print("Signed Out Successfully");
			return await _auth.signOut();
		} catch (e) {
			print(e.toString());
			return null;
		}
	}
	//TODO register with Gmail

}