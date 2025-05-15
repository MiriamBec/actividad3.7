import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/app_drawer.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloCtrl = TextEditingController();
  final _anioCtrl = TextEditingController();
  final _directorCtrl = TextEditingController();
  final _generoCtrl = TextEditingController();
  final _sinopsisCtrl = TextEditingController();
  final _imagenCtrl = TextEditingController();

  void _agregarPelicula() async {
    if (!_formKey.currentState!.validate()) return;
    await FirebaseFirestore.instance.collection('peliculas').add({
      'title': _tituloCtrl.text.trim(),
      'year': _anioCtrl.text.trim(),
      'director': _directorCtrl.text.trim(),
      'genre': _generoCtrl.text.trim(),
      'synopsis': _sinopsisCtrl.text.trim(),
      'imageUrl': _imagenCtrl.text.trim(),
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Película agregada')));
    _formKey.currentState!.reset();
  }

  void _eliminarPelicula(String docId) async {
    await FirebaseFirestore.instance
        .collection('peliculas')
        .doc(docId)
        .delete();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Película eliminada')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Administración')),
      drawer: buildAppDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Formulario para agregar
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _tituloCtrl,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _anioCtrl,
                    decoration: const InputDecoration(labelText: 'Año'),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _directorCtrl,
                    decoration: const InputDecoration(labelText: 'Director'),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _generoCtrl,
                    decoration: const InputDecoration(labelText: 'Género'),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _sinopsisCtrl,
                    decoration: const InputDecoration(labelText: 'Sinopsis'),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                  TextFormField(
                    controller: _imagenCtrl,
                    decoration: const InputDecoration(
                      labelText: 'URL de imagen',
                    ),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _agregarPelicula,
                    child: const Text('Agregar película'),
                  ),
                  const Divider(height: 32),
                ],
              ),
            ),

            // Lista de películas para eliminar
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance
                        .collection('peliculas')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return const Text('Error al cargar');
                  if (!snapshot.hasData)
                    return const CircularProgressIndicator();
                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty)
                    return const Text('No hay películas en catálogo');

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, i) {
                      final doc = docs[i];
                      return ListTile(
                        title: Text(doc['title']),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _eliminarPelicula(doc.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
