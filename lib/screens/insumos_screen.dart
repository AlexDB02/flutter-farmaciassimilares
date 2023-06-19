import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InsumosList extends StatefulWidget {
  const InsumosList({Key? key}) : super(key: key);

  @override
  _InsumosListState createState() => _InsumosListState();
}

class _InsumosListState extends State<InsumosList> {
  final CollectionReference _insumoss =
      FirebaseFirestore.instance.collection('InsumosList');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'crear';
    final _name = TextEditingController();
    final _category = TextEditingController();
    final _quantity = TextEditingController();
    final _price = TextEditingController();

    if (documentSnapshot != null) {
      action = 'actualizar';
      _name.text = documentSnapshot['Nombre'];
      _category.text = documentSnapshot['Categoria'];
      _quantity.text = documentSnapshot['Cantidad'].toString();
      _price.text = documentSnapshot['Precio'].toString();
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
                controller: _category,
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
                    labelText: 'Categoría'),
              ),
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              TextField(
                controller: _quantity,
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
                    labelText: 'Cantidad'),
              ),
              Divider(
                color: Colors.black.withOpacity(0),
              ),
              TextField(
                controller: _price,
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
                    labelText: 'Precio'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text(action == 'crear' ? 'Crear' : 'Actualizar'),
                onPressed: () async {
                  final String? nombre = _name.text;
                  final String? category = _category.text;
                  final int? quantity = int.tryParse(_quantity.text);
                  final double? price = double.tryParse(_price.text);

                  if (nombre != null && category != null) {
                    if (action == 'crear') {
                      await _insumoss.add({
                        "Nombre": nombre,
                        "Categoria": category,
                        "Cantidad": quantity,
                        "Precio": price,
                      });
                    } else if (action == 'actualizar') {
                      await _insumoss.doc(documentSnapshot!.id).update({
                        "Nombre": nombre,
                        "Categoria": category,
                        "Cantidad": quantity,
                        "Precio": price,
                      });
                    }

                    _name.clear();
                    _category.clear();

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
    await _insumoss.doc(projectId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El insumo se eliminó correctamente')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 203, 228),
      appBar: AppBar(
        title: const Text(
          "Insumos",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 20, 84, 155),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _insumoss.snapshots(),
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
                    subtitle: Text(documentSnapshot['Categoria']),
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
