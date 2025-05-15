import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DescripcionPage extends StatelessWidget {
  const DescripcionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Recoge el DocumentSnapshot que pasaste en el catálogo:
    final pelicula =
        ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;

    // Accede a cada campo:
    final title = pelicula['title'] ?? '—';
    final year = pelicula['year'] ?? '—';
    final director = pelicula['director'] ?? '—';
    final genre = pelicula['genre'] ?? '—';
    final synopsis = pelicula['synopsis'] ?? '—';
    final imageUrl = pelicula['imageUrl'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // El botón atrás viene automáticamente en AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // imageUrl principal
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),

            // Detalles
            Text('Año: $year', style: const TextStyle(fontSize: 16)),
            Text('Director: $director', style: const TextStyle(fontSize: 16)),
            Text('Género: $genre', style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 16),
            const Text(
              'Sinopsis:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(synopsis, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 32),
            // Botón extra para volver
            Center(
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al Catálogo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
