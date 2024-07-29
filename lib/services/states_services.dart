import 'dart:convert';

import '../services/utilities/app_url.dart';
import '../model/world_state_model.dart';

import 'package:http/http.dart' as http;

class StatesServices {

  Future<WorldStateModel> fetchWorldStatesRecord() async {

    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body.toString());
      return WorldStateModel.fromJson(jsonData);
    }

    else {
      throw Exception('Error..!!');
    }
  }


  Future<List<dynamic>> fetchCountryData() async {

    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    }
    else {
      throw Exception('Error..!!');
    }

  }

}