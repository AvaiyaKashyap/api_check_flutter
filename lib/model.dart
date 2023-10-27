// model.dart

class Person {
  final int id;
  final String name;
  final String address;

  Person({required this.id, required this.name, required this.address});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      name: json['name'],
      address: json['address'],
    );
  }
}