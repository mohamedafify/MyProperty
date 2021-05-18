import 'package:MyProperty/models/user.dart';
import 'package:MyProperty/services/database.dart';

class FavouritePropertyViewModel {
	DatabaseService _database = DatabaseService();

	Future<List> getFavouriteProperties() async {
		MyUser currentUser = await _database.currentUser;
		return Future.wait(currentUser.favouritePropertiesUIDs.map((element) async {
			return await _database.getPropertyByID(element);
		}).toList());
	}

}