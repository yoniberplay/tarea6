import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EdadView extends StatefulWidget {
  @override
  _GenderizeScreenState createState() => _GenderizeScreenState();
}

class _GenderizeScreenState extends State<EdadView> {
  TextEditingController _nameController = TextEditingController();
  String _ageImage = 'assets/persona.png';
  String msj = '';
  int edad = 0;
  bool _isLoading = false;
  Color color = Colors.black;

  Future<void> fetchGender(String name) async {
    if (_nameController.text != null && _nameController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      final response =
          await http.get(Uri.parse('https://api.agify.io/?name=$name'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['age'] != null) {
          edad = data['age'];
          if (edad <= 18) {
            _ageImage = 'assets/joven.png';
            msj = 'Joven';
          } else if (edad > 18 && edad < 50) {
            _ageImage = 'assets/adult.png';
            msj = 'Adulto';
          } else {
            _ageImage = 'assets/mayor.png';
            msj = 'Anciano';
          }
        } else {
          edad = 0;
        }
        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
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
              _ageImage,
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
                'Obtener edad',
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(edad != 0 ? (edad.toString() + '\n$msj') : '',
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
