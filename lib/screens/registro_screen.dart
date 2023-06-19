/*import 'package:flutter/material.dart';
import 'package:flutter_ex_2p/screens/user_screen.dart';
import 'package:flutter_ex_2p/screens/product_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        title: const Text(
          "Registro",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 139, 72, 151),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background2.png'),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Usuario'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => User(
                              name: '',
                              lastName: '',
                              age: '',
                              genre: '',
                              email: '',
                              password: '',
                              id: '',
                            )),
                  );
                },
                // Cambio de color del botón
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 139, 72, 151)),
              ),
              // Transparencia del divider
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              ElevatedButton(
                child: const Text('Productos'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Product(
                          name: '',
                          description: '',
                          units: '',
                          cost: '',
                          price: '',
                          utility: '',
                          id: '')),
                  );
                },
                // Cambio de color del botón
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 139, 72, 151)),
              ),
            ],
          )),
    );
  }
}
*/