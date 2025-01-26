import 'package:flutter/material.dart';

class PetFormScreen extends StatelessWidget {
  const PetFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final List<String> sizes = ['Pequeño', 'Mediano', 'Grande'];
    final List<String> genders = ['Macho', 'Hembra'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Mascota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Raza'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Tipo'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Color'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Tamaño'),
                  items: sizes
                      .map((size) => DropdownMenuItem(
                            value: size,
                            child: Text(size),
                          ))
                      .toList(),
                  onChanged: (value) {},
                  validator: (value) =>
                      value == null ? 'Selecciona un tamaño' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Edad'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la edad';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Sexo'),
                  items: genders
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {},
                  validator: (value) =>
                      value == null ? 'Selecciona el sexo' : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Temperamento'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Vacunas'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subir imagen:'),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Seleccionar archivo'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                    const Text('Pedigree')
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Formulario enviado')),
                        );
                      }
                    },
                    child: const Text('Enviar'),
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
