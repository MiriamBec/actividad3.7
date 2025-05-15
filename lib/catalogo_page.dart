import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/app_drawer.dart';

class CatalogoPage extends StatelessWidget {
  const CatalogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Películas')),
      drawer: buildAppDrawer(context),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('peliculas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar películas'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final peliculas = snapshot.data!.docs;
          if (peliculas.isEmpty) {
            return const Center(child: Text('No hay películas aún.'));
          }

          return ListView.builder(
            itemCount: peliculas.length,
            itemBuilder: (context, index) {
              final data = peliculas[index];
              final title = data['title'] ?? 'Sin título';
              final imageUrl = data['imageUrl'] ?? '';

              return ListTile(
                leading:
                    imageUrl.isNotEmpty
                        ? Image.network(imageUrl, width: 60, fit: BoxFit.cover)
                        : const Icon(Icons.movie),
                title: Text(title),
                onTap: () {
                  Navigator.pushNamed(context, '/descripcion', arguments: data);
                },
              );
            },
          );
        },
      ),
    );
  }
}
