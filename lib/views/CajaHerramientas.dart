import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CajaHerramientas extends StatelessWidget {
  const CajaHerramientas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/tool-box.png',
                width: 400,
                height: 400,
              ),
              const SizedBox(height: 20),
              const Text('Couteau',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ));
  }
}
