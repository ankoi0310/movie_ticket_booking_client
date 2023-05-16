import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/branch/branch_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/branch.dart';

class BranchProvider with ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  Branch? _branch;

  Branch? get branch => _branch;

  List<Branch> _branches = [];

  List<Branch> get branches => _branches;

  Future<HttpResponse> getBranches(BranchSearch search) async {
    HttpResponse response = await apiProvider.post(
      Uri.parse('$baseUrl/branch/search'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(search.toJson()),
    );

    try {
      _branches = response.data.map<Branch>((e) => Branch.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }

    return response;
  }

  Future<Branch?> getBranchById(int id) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/branch/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _branch = Branch.fromJson(jsonResponse['data']);
      }

      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<Branch?> createBranch(Branch branch) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/branch'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': branch.name,
          'address': branch.address,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _branch = Branch.fromJson(jsonResponse['data']);
      }

      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<Branch?> updateBranch(Branch branch) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/api/branch/${branch.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': branch.name,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _branch = Branch.fromJson(jsonResponse['data']);
      }

      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteBranch(String id) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:3000/api/branch/$id'));

      if (response.statusCode == 200) {
        _branches.removeWhere((element) => element.id == id);
      }
    } catch (_) {
      rethrow;
    }
  }
}
