import 'package:flutter/material.dart';
import 'package:flutter_ex_2p/screens/clientes_screen.dart';
import 'package:flutter_ex_2p/screens/empleados_secreen.dart';
import 'package:flutter_ex_2p/screens/insumos_screen.dart';
import 'package:flutter_ex_2p/screens/proveedores_screen.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 189, 203, 228),
        appBar: AppBar(
          title: const Text(
            "Menú principal",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 20, 84, 155),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logon.png'), fit: BoxFit.cover)),
          child: Center(
            child: GridView.count(
              crossAxisCount: 2, // Número de columnas en la cuadrícula
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
                  child: ElevatedButton(
                    child: Image.asset(
                      'assets/insumos.png',
                      width: 130,
                    ),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InsumosList()),
                      );
                    },
                    // Cambio de color del botón
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 20, 84, 155)),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
                  child: ElevatedButton(
                    child: Image.asset(
                      'assets/empleados.png',
                      width: 130,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmpleadosList()),
                      );
                    },
                    // Cambio de color del botón
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 20, 84, 155)),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
                  child: ElevatedButton(
                    child: Image.asset(
                      'assets/proveedores.png',
                      width: 130,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProveedoresList()),
                      );
                    },
                    // Cambio de color del botón
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 20, 84, 155)),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 40),
                  child: ElevatedButton(
                    child: Image.asset(
                      'assets/clientes.png',
                      width: 130,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ClientesList()),
                      );
                    },
                    // Cambio de color del botón
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 20, 84, 155)),
                  ),
                ),
              ],
            ),
            /*child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Insumos'),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InsumosList()),
                  );
                },

                // Cambio de color del botón
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 20, 84, 155)),
              ),
              // Transparencia del divider
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              ElevatedButton(
                child: const Text('Empleados'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmpleadosList()),
                  );
                },
                // Cambio de color del botón
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 20, 84, 155)),
              ),
              // Transparencia del divider
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              ElevatedButton(
                child: const Text('Proveedores'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProveedoresList()),
                  );
                },
                // Cambio de color del botón
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 20, 84, 155)),
              ),

              Divider(
                color: Colors.black.withOpacity(0),
              ),
              ElevatedButton(
                child: const Text('Clientes'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientesList()),
                  );
                },
                // Cambio de color del botón
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 20, 84, 155)),
              ),
            ],
          )*/
          ),
        ));
  }
}
