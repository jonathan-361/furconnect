import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:furconnect/features/data/services/login_service.dart';
import 'package:furconnect/features/data/services/api_service.dart';
import 'package:furconnect/features/presentation/page/home_page/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginService = LoginService(ApiService());

    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                loginService.logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sesión cerrada exitosamente')),
                );
                context.go('/');
              },
            ),
          ],
        ),
        body: HomeContent());
  }
}
