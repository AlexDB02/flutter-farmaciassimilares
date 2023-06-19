import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProveedoresList extends StatefulWidget {
  const ProveedoresList({Key? key}) : super(key: key);

  @override
  _ProveedoresListState createState() => _ProveedoresListState();
}

class _ProveedoresListState extends State<ProveedoresList> {
  final CollectionReference _proveedoress =
      FirebaseFirestore.instance.collection('ProveedorList');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'crear';
    final _name = TextEditingController();
    final _email = TextEditingController();
    final _idInsumo = TextEditingController(text: 'id');
    final _phone = TextEditingController();

    if (documentSnapshot != null) {
      action = 'actualizar';
      _name.text = documentSnapshot['Nombre'];
      _email.text = documentSnapshot['Correo'];
      _idInsumo.text = documentSnapshot['idInsumo'];
      _phone.text = documentSnapshot['Telefono'];
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
                controller: _idInsumo,
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
                    labelText: 'Nombre del insumo'),
              ),
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              TextField(
                controller: _phone,
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
                    labelText: 'Teléfono'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(action == 'crear' ? 'Crear' : 'Actualizar'),
                onPressed: () async {
                  final String? nombre = _name.text;
                  final String? correo = _email.text;
                  final String? idIsumo = _idInsumo.text;
                  final String? telefono = _phone.text;

                  if (nombre != null && correo != null) {
                    if (action == 'crear') {
                      await _proveedoress.add({
                        "Nombre": nombre,
                        "Correo": correo,
                        "idInsumo": idIsumo,
                        "Telefono": telefono,
                      });
                    } else if (action == 'actualizar') {
                      await _proveedoress.doc(documentSnapshot!.id).update({
                        "Nombre": nombre,
                        "Correo": correo,
                        "idInsumo": idIsumo,
                        "Telefono": telefono,
                      });
                    }

                    _name.clear();
                    _email.clear();

                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 20, 84, 155),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //Delete
  Future<void> _deleteProduct(String projectId) async {
    await _proveedoress.doc(projectId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El proveedor se eliminó correctamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 203, 228),
      appBar: AppBar(
        title: const Text(
          "Proveedores",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 20, 84, 155),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _proveedoress.snapshots(),
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
                    subtitle: Text(documentSnapshot['Correo']),
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
