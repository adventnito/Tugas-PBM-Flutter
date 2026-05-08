import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';

class ApiService {
  static const _storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';

  // ─── Token Management ───────────────────────────────────────────
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  // ─── Headers ────────────────────────────────────────────────────
  static Map<String, String> _publicHeaders() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  static Future<Map<String, String>> _authHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // ─── 1. Login ───────────────────────────────────────────────────
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final url = Uri.parse('$kBaseUrl/api/auth/login');
    final response = await http.post(
      url,
      headers: _publicHeaders(),
      body: jsonEncode({'username': username, 'password': password}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['success'] == true) {
      final token = data['data']['token'] as String;
      await saveToken(token);
      final user = UserModel.fromJson(data['data']['user']);
      return {'token': token, 'user': user};
    } else {
      throw Exception(data['message'] ?? 'Login gagal');
    }
  }

  // ─── 2. Get Products ────────────────────────────────────────────
  static Future<List<ProductModel>> getProducts() async {
    final url = Uri.parse('$kBaseUrl/api/products');
    final response = await http.get(url, headers: await _authHeaders());

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['success'] == true) {
      final List products = data['data']['products'];
      return products.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception(data['message'] ?? 'Gagal memuat produk');
    }
  }

  // ─── 3. Create Product ──────────────────────────────────────────
  static Future<ProductModel> createProduct({
    required String name,
    required int price,
    required String description,
  }) async {
    final url = Uri.parse('$kBaseUrl/api/products');
    final response = await http.post(
      url,
      headers: await _authHeaders(),
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
      }),
    );

    final data = jsonDecode(response.body);
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        data['success'] == true) {
      return ProductModel.fromJson(data['data']['product']);
    } else {
      throw Exception(data['message'] ?? 'Gagal menyimpan produk');
    }
  }

  // ─── 4. Delete Product ──────────────────────────────────────────
  static Future<void> deleteProduct(int id) async {
    final url = Uri.parse('$kBaseUrl/api/products/$id');
    final response = await http.delete(url, headers: await _authHeaders());

    final data = jsonDecode(response.body);
    if (response.statusCode != 200 || data['success'] != true) {
      throw Exception(data['message'] ?? 'Gagal menghapus produk');
    }
  }

  // ─── 5. Submit Tugas ────────────────────────────────────────────
  static Future<void> submitTugas({
    required String name,
    required int price,
    required String description,
    required String githubUrl,
  }) async {
    final url = Uri.parse('$kBaseUrl/api/products/submit');
    final response = await http.post(
      url,
      headers: await _authHeaders(),
      body: jsonEncode({
        'name': name,
        'price': price,
        'description': description,
        'github_url': githubUrl,
      }),
    );

    final data = jsonDecode(response.body);
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        data['success'] == true) {
      return;
    } else {
      throw Exception(data['message'] ?? 'Gagal submit tugas');
    }
  }
}