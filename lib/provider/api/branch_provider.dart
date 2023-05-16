import 'package:movie_ticket_booking_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_flutter_nlu/dto/branch/branch_search.dart';
import 'package:movie_ticket_booking_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_flutter_nlu/model/branch.dart';

class BranchProvider with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;

  Future<HttpResponse> searchBranch(BranchSearch search) async {
    try {
      HttpResponse response = await _apiProvider.post(
        Uri.parse('$baseUrl/branch/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(search.toJson()),
      );

      notifyListeners();
      return response;
    } catch (_) {
      print('error: $_');
      rethrow;
    }
  }

  Future<HttpResponse> getBranchById(int id) async {
    try {
      HttpResponse response = await _apiProvider.get(
        Uri.parse('$baseUrl/branch/$id'),
      );

      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<HttpResponse> createBranch(Branch branch) async {
    try {
      HttpResponse response = await _apiProvider.post(
        Uri.parse('http://localhost:3000/api/branch'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': branch.name,
          'address': branch.address,
        }),
      );

      notifyListeners();
      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<HttpResponse> updateBranch(Branch branch) async {
    try {
      HttpResponse response = await _apiProvider.put(
        Uri.parse('http://localhost:3000/api/branch/${branch.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': branch.name,
        }),
      );

      notifyListeners();
      return response;
    } catch (_) {
      rethrow;
    }
  }

  Future<HttpResponse> deleteBranch(String id) async {
    try {
      HttpResponse response = await _apiProvider.delete(
        Uri.parse('http://localhost:3000/api/branch/$id'),
      );

      notifyListeners();
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
