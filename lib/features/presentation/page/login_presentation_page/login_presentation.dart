import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:furconnect/features/presentation/widget/button_login.dart';

class LoginPresentation extends StatelessWidget {
  const LoginPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_login_copy.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 170),
              Image.asset(
                'assets/images/logo_furconnect.png',
                width: 270,
                height: 270,
              ),
              Spacer(),
              RoundedButton(
                text: 'Iniciar sesión',
                onPressed: () {
                  GoRouter.of(context).go('/login');
                },
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
