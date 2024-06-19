import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event.dart';

class EventController {
  static Future<List<Event>> fetchEvents() async {
    var headers = {
      'Authorization': 'Bearer 2f68dbbf-519d-4f01-9636-e2421b68f379'
    };
    var request = http.Request('GET',
        Uri.parse('https://mock.apidog.com/m1/561191-524377-default/Event'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      List<dynamic> data = jsonDecode(jsonResponse)['data'];
      return data.map((eventData) => Event.fromJson(eventData)).toList();
    } else {
      throw Exception('Failed to load events: ${response.reasonPhrase}');
    }
  }
}
