import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:store_app/core/theme/app_asset.dart';

class JsonService{
  static Future<dynamic> getLocations()async{
    final String response = await rootBundle.loadString('${AppAsset.jsonUrl}countries.json');
    return json.decode(response);
  }

}