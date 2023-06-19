import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmpleadosList extends StatefulWidget {
  const EmpleadosList({Key? key}) : super(key: key);

  @override
  _EmpleadosListState createState() => _EmpleadosListState();
}

class _EmpleadosListState extends State<EmpleadosList> {
  final CollectionReference _empleadoss =
      FirebaseFirestore.instance.collection('EmpleadoList');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'crear';
    final _name = TextEditingController();
    final _lastName = TextEditingController();
    final _turno = TextEditingController(text: "Matutino");
    final _email = TextEditingController();
    final _password = TextEditingController();

    if (documentSnapshot != null) {
      action = 'actualizar';
      _name.text = documentSnapshot['Nombre'];
      _lastName.text = documentSnapshot['Apellido'];
      _turno.text = documentSnapshot['Turno'];
      _email.text = documentSnapshot['Correo'];
      _password.text = documentSnapshot['Contraseña'];
    }

    await showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _name,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 20, 84, 155)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155),
                            width: 2.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155))),
                    labelText: 'Nombre'),
              ),
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              TextField(
                controller: _lastName,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 20, 84, 155)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155),
                            width: 2.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155))),
                    labelText: 'Apellido'),
              ),
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              DropdownButtonFormField<String>(
                value: _turno.text,
                onChanged: (String? newValue) {
                  setState(() {
                    _turno.text = newValue ?? '';
                  });
                },
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 20, 84, 155)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155),
                            width: 2.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155))),
                    labelText: 'Turno'),
                items: <String>[
                  'Matutino',
                  'Vespertino',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              TextField(
                controller: _email,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 20, 84, 155)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155),
                            width: 2.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155))),
                    labelText: 'Correo'),
              ),
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              TextField(
                controller: _password,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 20, 84, 155)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155),
                            width: 2.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 20, 84, 155))),
                    labelText: 'Contraseña'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(action == 'crear' ? 'Crear' : 'Actualizar'),
                onPressed: () async {
                  final String? nombre = _name.text;
                  final String? apellido = _lastName.text;
                  final String? turno = _turno.text;
                  final String? correo = _email.text;
                  final String? contrasena = _password.text;

                  if (nombre != null && apellido != null) {
                    if (action == 'crear') {
                      await _empleadoss.add({
                        "Nombre": nombre,
                        "Apellido": apellido,
                        "Turno": turno,
                        "Correo": correo,
                        "Contraseña": contrasena
                      });
                    } else if (action == 'actualizar') {
                      await _empleadoss.doc(documentSnapshot!.id).update({
                        "Nombre": nombre,
                        "Apellido": apellido,
                        "Turno": turno,
                        "Correo": correo,
                        "Contraseña": contrasena
                      });
                    }

                    _name.clear();
                    _lastName.clear();

                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 20, 84, 155),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //Delete
  Future<void> _deleteProduct(String projectId) async {
    await _empleadoss.doc(projectId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El empleado se eliminó correctamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 203, 228),
      appBar: AppBar(
        title: const Text(
          "Empleados",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 20, 84, 155),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _empleadoss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['Nombre']),
                    subtitle: Text(documentSnapshot['Turno']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 20, 84, 155),
      ),
    );
  }
}
