import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/model.dart';

class ShoppingService {
  static const String apiUrl = 'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline';

  static Future<List<Shopping>> fetchProjects() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((project) => Shopping.fromJson(project)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
