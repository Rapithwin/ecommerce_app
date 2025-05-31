import 'dart:convert';
import 'dart:developer' show log;
import 'dart:io';

import 'package:e_commerce_data/data_constants.dart';
import 'package:e_commerce_data/favorites_data/models/favorites_model.dart';
import 'package:http/http.dart' as http;

class FavoritesEmptyFailure implements Exception {}

class AuthApiClient {
  AuthApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  final _usersEndpoint = "api/favorites";

  Future<FavoritesModel> getFavorites() async {
    try {
      final favoritesRequest = Uri.http(
        Constants.authority,
        _usersEndpoint,
      );

      final favoritesResponse = await _httpClient.get(
        favoritesRequest,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );

      final favoritesJson =
          jsonDecode(favoritesResponse.body) as Map<String, dynamic>;
      final result = FavoritesModel.fromJson(favoritesJson);
      if (result.data != null && result.data!.items!.isEmpty) {
        throw FavoritesEmptyFailure();
      }
      return result;
    } catch (error, stacktrace) {
      log("Error during api call $error");
      log("Stacktrace $stacktrace");
      rethrow;
    }
  }
}
