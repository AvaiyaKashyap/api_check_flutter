// main.dart
import 'package:api_check_flutter/data_entry.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'model.dart';
import 'api_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text('Person List'),
        ),
        body: FutureBuilder<List<Person>>(
          future: ApiHelper.fetchDataFromAPI(
              'http://192.168.29.5:3000/api/fetchTable'),
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
        floatingActionButton: FloatingActionButton(
          child: Text("+"),
          onPressed: () {
            navigatorKey.currentState!.push(
              MaterialPageRoute(builder: (context) => DataEntryPage()),
            );
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
      elevation: 12,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${person.name}"),
            Text("Address: ${person.address}"),
            SizedBox(height: 3,),
            GestureDetector(
              onTap: () {
                ApiHelper.deleteAlbum(person.id);
                print("delete button tapped of: ${person.id}");
              },
              child: Container(
                height: 20,
                width: 50,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text("delete",style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
