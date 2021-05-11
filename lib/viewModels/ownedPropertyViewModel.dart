import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/database.dart';

class OwnedPropertyViewModel {
	DatabaseService _database = DatabaseService();

	Future<List> getOwnedProperties() async {
		MyUser currentUser = await _database.currentUser;
		return Future.wait(currentUser.ownedPropertiesUIDs.map((element) async {
			return await _database.getPropertyByID(element);
		}).toList());
	}
}