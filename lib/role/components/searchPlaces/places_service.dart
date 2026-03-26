
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class PlacesService {
  static const String _apiKey = 'AIzaSyC_nd3kNWBz2zRX0q8F8MSDEG36UW6k03I';
  static const String _url = "https://places.googleapis.com/v1/places:autocomplete";

  static Future<List<PlaceSuggestion>> getSuggestions(String input) async {
    if (input.trim().isEmpty) return [];

    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          "Content-Type": "application/json",
          "X-Goog-Api-Key": _apiKey,
        },
          body: jsonEncode({
            "input": input,
            "includedRegionCodes": ["US"],
            "languageCode": "en",
          })
      );

      log("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List suggestions = data['suggestions'] ?? [];

        return suggestions
            .map((s) => PlaceSuggestion.fromNewAutocompleteJson(
            Map<String, dynamic>.from(s)))
            .toList();
      } else {
        log("Google API Error: ${response.body}");
        return [];
      }
    } catch (e) {
      log("Autocomplete Error: $e");
      return [];
    }
  }
}

// ─────────────────────────────────────────

class PlaceSuggestion {
  final String placeId;
  final String description; // full description
  final String mainText;    // main part of place
  final String secondaryText; // secondary part (city, country, etc.)

  PlaceSuggestion({
    required this.placeId,
    required this.description,
    required this.mainText,
    required this.secondaryText,
  });

  /// Factory for new Places API v1 autocomplete response
  factory PlaceSuggestion.fromNewAutocompleteJson(Map<String, dynamic> json) {
    final prediction = json['placePrediction'] ?? {};
    final structured = prediction['structuredFormat'] ?? {};

    return PlaceSuggestion(
      placeId: prediction['placeId'] ?? '',
      description: prediction['text'] != null
          ? prediction['text']['text'] ?? ''
          : '',
      mainText: structured['mainText'] != null
          ? structured['mainText']['text'] ?? ''
          : '',
      secondaryText: structured['secondaryText'] != null
          ? structured['secondaryText']['text'] ?? ''
          : '',
    );
  }
}