import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetService {
  final Dio _dio = Dio();

  // Obtener el token almacenado
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Cambié 'authToken' a 'token'
  }

  // Solicitud GET para obtener las mascotas paginadas
  Future<Map<String, dynamic>> getPets(int page, int limit) async {
    try {
      final token = await _getToken();

      if (token == null) {
        throw Exception('Token de autenticación no encontrado');
      }

      final response = await _dio.get(
        'http://localhost:3000/api/pets',
        queryParameters: {'page': page, 'limit': limit},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error al obtener las mascotas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Añadir método para obtener mascota por ID
  Future<Map<String, dynamic>> getPetById(String id) async {
    try {
      final token = await _getToken();

      if (token == null) {
        throw Exception('Token de autenticación no encontrado');
      }

      final response = await _dio.get(
        'http://localhost:3000/api/pets/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Error al obtener la mascota');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
