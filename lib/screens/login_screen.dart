import 'package:flutter/material.dart';
import 'package:flutter_ex_2p/screens/menu_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inicio de sesión',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 20, 84, 155),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/logon.png'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/similogo.png',
              width: 400,
            ),
            // Field para email
            Container(
                height: 70,
                width: 650,
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 20, 84, 155)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 20, 84, 155),
                              width: 2.0)),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 20, 84, 155),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 20, 84, 155))),
                      labelText: 'Correo electrónico'),
                )),
            // Field para contraseña
            Container(
                height: 70,
                width: 650,
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 20, 84, 155)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 20, 84, 155),
                              width: 2.0)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 20, 84, 155),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 20, 84, 155))),
                      labelText: 'Contraseña'),
                )),
            SizedBox(height: 16),
            FloatingActionButton.extended(
              onPressed: () async {
                try {
                  UserCredential userCredential =
                      await _auth.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ); // Autenticación exitosa, puedes realizar acciones adicionales aquí
                  if (userCredential.user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );
                  }
                } catch (e) {
                  // Mostrar ventana emergente en caso de error de autenticación
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error de autenticación'),
                        content:
                            Text('El correo o la contraseña son incorrectos.'),
                        actions: [
                          TextButton(
                            child: Text('Aceptar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  print('Error during login: $e');
                }
              },
              icon: Icon(Icons.security),
              label: Text('Entrar'),
              backgroundColor: Color.fromARGB(255, 20, 84, 155),
              foregroundColor: Colors.white,
            ),
            Divider(
              color: Colors.black.withOpacity(0),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                GoogleSignIn().signIn();
              },
              icon: Image.asset(
                'assets/logogoogle.png',
                height: 32,
                width: 32,
              ),
              label: Text('Iniciar sesión con Google'),
              backgroundColor: Color.fromARGB(255, 20, 84, 155),
              foregroundColor: Colors.white,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
