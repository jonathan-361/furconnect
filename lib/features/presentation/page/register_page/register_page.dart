import 'package:flutter/material.dart';
import 'package:furconnect/features/data/services/register_service.dart';
import 'package:furconnect/features/data/services/api_service.dart';
import 'package:furconnect/features/presentation/page/login_presentation_page/login_presentation.dart';
import 'package:go_router/go_router.dart';

class RegistrationFormScreen extends StatefulWidget {
  @override
  _RegistrationFormScreenState createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  String? _passwordError;
  String? _emailError;

  final RegisterService _registerService = RegisterService(ApiService());

  // Validador para la contraseña
  String? _passwordValidator(String? value) {
    final password = value ?? '';
    if (password.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    if (RegExp(r'^\d+$').hasMatch(password)) {
      return 'La contraseña no puede ser solo números';
    }
    if (RegExp(r'(012|123|234|345|456|567|678|789)').hasMatch(password)) {
      return 'La contraseña no puede contener números consecutivos';
    }
    if (!RegExp(r'[a-zA-Z]').hasMatch(password)) {
      return 'La contraseña debe contener al menos una letra';
    }
    return null;
  }

  // Validador para el email
  String? _emailValidator(String? value) {
    final email = value ?? '';
    if (email.isEmpty) {
      return 'Por favor ingresa tu correo electrónico';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Por favor ingresa un email válido';
    }
    return null;
  }

  // Función para manejar el registro
  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await _registerService.registerUser(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _phoneController.text,
        _cityController.text,
        _stateController.text,
        _countryController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('¡Cuenta creada correctamente!')),
        );
        // Redirigir a la pantalla de inicio de sesión
        context.go('/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear la cuenta')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Campo Nombre
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu nombre';
                    }
                    return null;
                  },
                ),
                // Campo Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      _emailError = _emailValidator(value);
                    });
                  },
                ),
                // Error de email
                if (_emailError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _emailError!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                // Campo Contraseña
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _passwordError = _passwordValidator(value);
                    });
                  },
                ),
                // Error de contraseña
                if (_passwordError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _passwordError!,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                // Resto de los campos (teléfono, ciudad, etc.)
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Teléfono'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu número de teléfono';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: 'Ciudad'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu ciudad';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _stateController,
                  decoration: InputDecoration(labelText: 'Estado'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu estado';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: 'País'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu país';
                    }
                    return null;
                  },
                ),
                // Botón para enviar el formulario
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: ElevatedButton(
                    onPressed: _register,
                    child: Text('Registrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
