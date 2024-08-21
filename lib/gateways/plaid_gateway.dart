import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaidGateway {
  final String apiKey = "20a3d10a78c986112a306eda26dfc9"; // Your Plaid API key
  final String clientId = "64934b64b8877f00142ed7e7";
  final String baseurl = "https://sandbox.plaid.com";
  PlaidGateway();

  Future<Map<String, dynamic>> createLinkToken() async {
    final url = Uri.parse('https://create-link-token-cyfokuklnq-uc.a.run.app'); // Replace with the actual Plaid API endpoint

    final response = await http.get(
      url,
      
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = Map<String, dynamic>.from(
        json.decode(response.body),
      );
      print(data);
      return data;
    } else {
      throw Exception('Failed to create Link token');
    }
  }

  Future<Map<String, dynamic>> exchangeToken(String publicToken)async {
    final url = Uri.parse('https://set-access-token-cyfokuklnq-uc.a.run.app'); // Replace with the actual Plaid API endpoint

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        
      },
      body: jsonEncode({
        "public_token": publicToken,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = Map<String, dynamic>.from(
        json.decode(response.body),
      );
      return data;
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }

  Future<Map<String, dynamic>> getAccounts(String accessToken) async {
    final url = Uri.parse('https://get-accounts-cyfokuklnq-uc.a.run.app'); // Replace with the actual Plaid API endpoint

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        
      },
      body: jsonEncode({
        "access_token": accessToken,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = Map<String, dynamic>.from(
        json.decode(response.body),
      );
      return data;
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }


  Future<Map<String, dynamic>> syncTransactions(String accessToken) async {
    final url = Uri.parse('https://sync-transactions-cyfokuklnq-uc.a.run.app'); // Replace with the actual Plaid API endpoint

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        
      },
      body: jsonEncode({  
        "access_token": accessToken,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = Map<String, dynamic>.from(
        json.decode(response.body),
      );
      return data;
    } else {
      throw Exception('Failed to fetch transactions');
    }
  }

  // You can add more methods for other Plaid API endpoints as needed
}
