// api_helper.dart
import 'dart:convert';
import 'model.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<List<Person>> fetchDataFromAPI(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
            print(data);
      return data.map((item) => Person.fromJson(item)).toList();

    } else {
      throw Exception('Failed to load data from the API');
    }
  }

       static Future<http.Response> deleteAlbum(int id) async {
       final http.Response response = await http.delete(        
       Uri.parse
     ('http://192.168.29.5:3002/api/deleteCustomer/$id'),
        headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
         },
       );
       return response;
      }
}
