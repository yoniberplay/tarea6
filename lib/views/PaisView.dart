import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaisView extends StatefulWidget {
  @override
  _UniversityListScreenState createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<PaisView> {
  final TextEditingController countryController = TextEditingController();
  List<University> universities = [];

  Future<void> fetchUniversities(String country) async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final universityList =
          List<University>.from(data.map((item) => University.fromJson(item)));
      setState(() {
        universities = universityList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      width: 350,
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            labelText: 'Nombre del país en inglés',
                            hintText: 'Nombre del país en inglés',
                            border: OutlineInputBorder(),
                            fillColor: Colors.red),
                      ))),
              ElevatedButton(
                onPressed: () {
                  fetchUniversities(countryController.text);
                },
                child: const Text('Buscar Universidades'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: universities.length,
                  itemBuilder: (context, index) {
                    final university = universities[index];
                    return ListTile(
                      title: Text(university.name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dominio: ${university.webPages}',
                              style: const TextStyle(color: Colors.white)),
                          Text('Sitio web: ${university.webPages}',
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class University {
  final String name;
  final String webPages;

  University({required this.name, required this.webPages});

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? '',
      webPages: json['web_pages'] != null && json['web_pages'].isNotEmpty
          ? json['web_pages'][0]
          : '',
    );
  }
}
