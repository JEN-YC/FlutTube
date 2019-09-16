import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class Secret {
  final String movieApiKey;

  Secret({this.movieApiKey = ""});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(movieApiKey: jsonMap['movie_api_key']);
  }
}

class SecretLoader {
  final String secretPath;
  SecretLoader({this.secretPath});

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath,
        (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }
}
