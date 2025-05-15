import 'package:flutter/material.dart';

Widget buildAppDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.deepPurple),
          child: Text(
            'Menú',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.movie),
          title: const Text('Catálogo de Películas'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/catalogo');
          },
        ),
        ListTile(
          leading: const Icon(Icons.admin_panel_settings),
          title: const Text('Administración'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/admin');
          },
        ),
      ],
    ),
  );
}
