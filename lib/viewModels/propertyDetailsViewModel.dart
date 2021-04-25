import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/database.dart';

class PropertyDetailsViewModel {
	final DatabaseService _database = DatabaseService();

	Future<MyUser> getUserByUID(String uid) async {
		return await _database.getUserByID(uid);
	}
}