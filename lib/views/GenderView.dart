import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderView extends StatefulWidget {
  @override
  _GenderizeScreenState createState() => _GenderizeScreenState();
}

class _GenderizeScreenState extends State<GenderView> {
  TextEditingController _nameController = TextEditingController();
  String _genderImage = 'assets/gender.png';
  String _gender = '';
  bool _isLoading = false;
  Color color = Colors.black;

  Future<void> fetchGender(String name) async {
    if (_nameController.text != null && _nameController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      final response =
          await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _gender = data['gender'];
          _genderImage =
              _gender == 'male' ? 'assets/male.png' : 'assets/woman.png';
          color = _gender == 'male' ? Colors.blue : Colors.pink;
          _isLoading = false;
        });
      } else {
        setState(() {
          _gender = 'Error';
          _isLoading = false;
        });
      }
    } else {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              _genderImage,
            ),
            const SizedBox(height: 20),
            Container(
                width: 350,
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: _nameController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      labelText: 'Ingrese su nombre',
                      hintText: 'Ingrese su nombre',
                      border: OutlineInputBorder(),
                      fillColor: Colors.red),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchGender(_nameController.text);
              },
              child: const Text(
                'Obtener género',
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(_gender.isEmpty ? '' : _gender,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
