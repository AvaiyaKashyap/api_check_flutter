// main.dart
import 'package:flutter/material.dart';
import 'model.dart';
import 'api_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Person List'),
        ),
        body: FutureBuilder<List<Person>>(
          future: ApiHelper.fetchDataFromAPI('http://192.168.29.5:3000/api/fetchTable'), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              final persons = snapshot.data;
              return PersonList(persons: persons!);
            }
          },
        ),
      ),
    );
  }
}

class PersonList extends StatelessWidget {
  final List<Person> persons;

  PersonList({required this.persons});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: persons.length,
      itemBuilder: (context, index) {
        return CardView(person: persons[index]);
      },
    );
  }
}

class CardView extends StatelessWidget {
  final Person person;

  CardView({required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${person.name}"),
            Text("Address: ${person.address}"),
          ],
        ),
      ),
    );
  }
}
