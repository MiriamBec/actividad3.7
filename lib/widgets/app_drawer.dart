import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            Navigator.pushNamed(context, '/admin');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Cerrar sesión'),
          onTap: () async {
            Navigator.of(context).pop(); // 1) Cierra el Drawer
            Navigator.of(context).popUntil((route) => route.isFirst);

            await FirebaseAuth.instance.signOut(); // 2) Desconecta de Firebase
          },
        ),
      ],
    ),
  );
}
