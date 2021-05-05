import 'package:MyProperty/models/property.dart';
import 'package:MyProperty/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeViewModel {
	DatabaseService _database = DatabaseService();
	Future<List> getAllProperties() async {
		QuerySnapshot query = await _database.getAllProperty();
		return Future.wait(query.docs.map((element) async {
			return await _database.getPropertyByID(element.id);
		}).toList());
	}
}