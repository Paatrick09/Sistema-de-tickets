import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ticket.dart';

class TicketService {
  // Nota: Para Android Emulator usar 10.0.2.2 en lugar de localhost
  // Para iOS Simulator usar localhost
  // Aquí usaremos localhost asumiendo iOS o Web, el usuario deberá cambiarlo si usa Android
  static const String baseUrl = 'http://localhost:5000/api/tickets';

  Future<List<Ticket>> getTickets() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Ticket.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<void> updateTicket(int id, Ticket ticket) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(ticket.toJson()),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update ticket');
    }
  }
}
