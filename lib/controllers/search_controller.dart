import 'dart:convert';

import 'package:rivus_user/models/environment.dart';
import 'package:rivus_user/models/items.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/suppliers.dart';

class ItemSearchController extends GetxController {
  final _searchQuery = 'initial value'.obs;

  String get searchQuery => _searchQuery.value;

  set setSearchQuery(String newValue) {
    _searchQuery.value = newValue;
  }

  RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set setLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  List<Item>? itemsResults; // List to store item results
  List<Suppliers>? suppliersResults; // List to store supplier results

  void searchItems(String key) async {
    setLoading = true;
    var url = Uri.parse('${Environment.appBaseUrl}/api/items/search/$key');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        setLoading = false;
        // Parse the results for items and suppliers separately
        var data = jsonDecode(response.body);
        itemsResults = itemFromJson(jsonEncode(data['items']));
        suppliersResults = suppliersFromJson(jsonEncode(data['suppliers']));
        update();

        return;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setLoading = false;
      rethrow;
    } finally {
      setLoading = false;
    }
  }
}
