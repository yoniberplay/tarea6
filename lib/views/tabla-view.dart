import 'package:flutter/material.dart';

//YONIBER ENCARNACION tabla_view
//2021-1442

class tabla_view extends StatefulWidget {
  @override
  _tabla_view createState() => _tabla_view();
}

class _tabla_view extends State<tabla_view> {
  int numero = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Container(
              width: 350,
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    labelText: 'Ingrese un numero',
                    hintText: 'Ingrese un numero',
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  setState(() {
                    numero = int.tryParse(value) ?? 0;
                  });
                },
              )),
          SizedBox(height: 20),
          Text('Tabla de Multiplicar del $numero',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: 14,
                  itemBuilder: (context, index) {
                    int multiplicacion = numero * (index + 1);
                    return Center(
                      heightFactor: 1.3,
                      child: Text(
                        '${index + 1} X $numero = $multiplicacion',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    );
                  }))
        ],
      )),
    );
  }
}
