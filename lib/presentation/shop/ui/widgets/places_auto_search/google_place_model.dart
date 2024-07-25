import 'dart:convert';
import 'package:http/http.dart';

class GooglePlace {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;

  GooglePlace({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}

class GoogleSuggestion {
  final String? placeId;
  final String? description;
  final String? containerId;
  final String? address;
  final String? postalCode;
  final String? lat;
  final String? lng;
  final String? line3;
  final String? city;
  final String? type;
  final String? company;

  GoogleSuggestion({
    this.type,
    this.postalCode,
    this.company,
    this.lat,
    this.lng,
    this.line3,
    this.city,
    this.placeId,
    this.description,
    this.containerId,
    this.address,
  });

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

// class GooglePlaceApiProvider {
//   final String placeId;
//   final String description;
//
//   GooglePlaceApiProvider(this.placeId, this.description);
//
//   @override
//   String toString() {
//     return 'Suggestion(description: $description, placeId: $placeId)';
//   }
// }

class GooglePlaceApiProvider {
  final client = Client();

  GooglePlaceApiProvider();

  Future<List<GoogleSuggestion>?> fetchSuggestions(
      String input, String lang) async {
    final googleApiKey = 'AIzaSyBh3ESbnGlRA3dYVMdG-iHUbGWzFGXWOFY';
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:usa&key=$googleApiKey';
    Uri uri = Uri.parse(request);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<GoogleSuggestion>((p) => GoogleSuggestion(
                placeId: p['place_id'], description: p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<GoogleSuggestion> getPlaceDetailFromId(
      String? placeId, String? desc) async {
    final googleApiKey = 'AIzaSyBh3ESbnGlRA3dYVMdG-iHUbGWzFGXWOFY';
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleApiKey';
    Uri uri = Uri.parse(request);
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        String address = desc ?? '';
        String locationLat =
            result['result']['geometry']['location']['lat'].toString();
        String locationLng =
            result['result']['geometry']['location']['lng'].toString();

        GoogleSuggestion suggestion = GoogleSuggestion(
          address: address,
          lat: locationLat,
          lng: locationLng,
        );

        return Future.value(suggestion);
        // return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
