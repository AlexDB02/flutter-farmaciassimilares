import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ex_2p/screens/clientes_screen.dart';
import 'package:flutter_ex_2p/screens/empleados_secreen.dart';
import 'package:flutter_ex_2p/screens/insumos_screen.dart';
import 'package:flutter_ex_2p/screens/login_screen.dart';
import 'package:flutter_ex_2p/screens/menu_screen.dart';
import 'package:flutter_ex_2p/screens/proveedores_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto Mike BB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
