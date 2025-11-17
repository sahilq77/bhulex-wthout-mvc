import 'dart:convert';

import 'package:bhulexapp/model/global_model/state_model.dart';
import 'package:bhulexapp/network/url.dart';
import 'package:http/http.dart' as http;

class StateService {
  URLS urls = URLS();
 

  Future<List<StateModel>> fetchStates() async {
    try {
      final response = await http.post(
        Uri.parse(urls.get_all_state_apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'true') {
          final List<dynamic> stateList = data['data'];
          return stateList.map((json) => StateModel.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load states: ${data['message']}');
        }
      } else {
        throw Exception(
          'Failed to load states. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching states: $e');
    }
  }
}
