// void main() {
//   print("Hello, Dart!");

//   final int number = 42;

//   print("The number is $number");
// }

// A simple Dart program to fetch and display package information from the Dart package repository.
// From https://docs.flutter.dev/get-started/fundamentals/dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class Package {


  // Final is like const, but for instance variables.
  Package(this.name, this.latestVersion, {this.description});
  final String name;
  final String latestVersion;
  final String? description;

  // @override mean we are writting our own version of a method that is already defined in a parent class.
  @override
  String toString() {
    return 'Package{name: $name, latestVersion: $latestVersion, description: $description}';
  }
}

// The main function is the entry point of the program.
void main() async {
  // First get the package information for the http package.
  final Uri httpPackageUrl = Uri.https('dart.dev', '/f/packages/http.json');

  // Get the respponse from the http package URL.
  final http.Response httpPackageResponse = await http.get(httpPackageUrl);

  // Check if error
  if (httpPackageResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }

  // If the response is successful, parse the JSON.
  final json = jsonDecode(httpPackageResponse.body);

  // Its liike .map on TypeScript as JSON is a Map<String, dynamic> in Dart.
  final Package package = Package(
    json['name'] as String,
    json['latestVersion'] as String,
    description: json['description'] as String,
  );

  // The output goes here
  print(package);
}