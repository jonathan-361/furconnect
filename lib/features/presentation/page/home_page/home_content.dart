import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:furconnect/features/data/services/pet_service.dart';
import 'package:furconnect/features/presentation/widget/item_pet.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final PetService _petService = PetService();
  List<dynamic> _pets = [];
  bool _isLoading = false;
  int _currentPage = 1;
  int _totalPages = 1;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _fetchPets();
  }

  // Método para obtener las mascotas
  Future<void> _fetchPets() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await _petService.getPets(_currentPage, 10);
      setState(() {
        _pets.addAll(data['pets']);
        _totalPages = data['pages'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error al obtener las mascotas: $e');
    }
  }

  // Método que maneja el desplazamiento y carga más datos
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMorePets();
    }
  }

  void _loadMorePets() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
      });
      _fetchPets();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _pets.length + 1,
        itemBuilder: (context, index) {
          if (index == _pets.length) {
            if (_currentPage < _totalPages) {
              return Center(child: CircularProgressIndicator());
            } else {
              return SizedBox.shrink();
            }
          }

          final pet = _pets[index];
          return ListTile(
            title: Text(pet['nombre']),
            subtitle: Text('Raza: ${pet['raza']}'),
            trailing: Icon(Icons.pets),
            onTap: () {
              final petId = pet['_id'];
              context.push('/pets/$petId');
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/newPets');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
