import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataEntryPage extends StatefulWidget {
  @override
  _DataEntryPageState createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Entry'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle data submission here
                _submitData(nameController.text, addressController.text);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitData(String name, String address) async {
    String apiUrl = 'http://192.168.29.5:3001/api/insertCustomer';
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String, dynamic> data = {
      'name': name,
      'address': address,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Successful POST request
        // You can handle the response here, e.g., show a success message to the user.
        print("Data submitted successfully!");
      } else {
        // Error in the POST request
        // You can handle the error here, e.g., show an error message to the user.
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      // Exception during the POST request
      // You can handle the exception here, e.g., show an error message to the user.
      print("Exception: $e");
    }
  }
}
