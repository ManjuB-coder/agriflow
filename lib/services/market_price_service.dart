import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/market_price_model.dart';

class MarketPriceService {
  static const String apiKey = "";

  static const String resourceId = "";

  static Future<List<MarketPriceModel>> getCropPrices(
    String commodity,
  ) async {
    try {
      final url = "https://api.data.gov.in/resource/$resourceId"
          "?api-key=$apiKey"
          "&format=json"
          "&limit=100"
          "&filters[commodity]=$commodity";

      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List records = data["records"] ?? [];

        return records
            .map(
              (e) => MarketPriceModel.fromJson(e),
            )
            .toList();
      }

      return [];
    } catch (e) {
      print(
        "Crop Price Error: $e",
      );

      return [];
    }
  }

  static Future<List<MarketPriceModel>> getPricesByState(
    String state,
  ) async {
    try {
      final url = "https://api.data.gov.in/resource/$resourceId"
          "?api-key=$apiKey"
          "&format=json"
          "&limit=100"
          "&filters[state]=$state";

      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List records = data["records"] ?? [];

        return records
            .map(
              (e) => MarketPriceModel.fromJson(e),
            )
            .toList();
      }

      return [];
    } catch (e) {
      print(
        "State Error: $e",
      );

      return [];
    }
  }

  static Future<List<MarketPriceModel>> getCropByState(
    String commodity,
    String state,
  ) async {
    try {
      final url = "https://api.data.gov.in/resource/$resourceId"
          "?api-key=$apiKey"
          "&format=json"
          "&limit=100"
          "&filters[commodity]=$commodity"
          "&filters[state]=$state";

      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List records = data["records"] ?? [];

        return records
            .map(
              (e) => MarketPriceModel.fromJson(e),
            )
            .toList();
      }

      return [];
    } catch (e) {
      print(
        "Commodity + State Error: $e",
      );

      return [];
    }
  }
}
