import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_property/models/user.dart' as my;

class AuthService {

	final FirebaseAuth _auth = FirebaseAuth.instance;

	//TODO convert firebase user to my.user

	// authentication change for user sign in/out
	Stream<User> get user {
		return _auth.authStateChanges();
		//Tuturial #7 7:10
		//TODO use .map to chagne it to my.User
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
	//TODO register with Gmail

	// Sign out
	Future<void> signOut() async {
		try {
		  await _auth.signOut();
		  print("Signed Out Successfully");
		} catch (e) {
			print(e.toString());
		}
	}

}