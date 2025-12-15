import 'package:flutter/material.dart';
import '../models/ticket.dart';
import '../services/ticket_service.dart';

class TicketDetailScreen extends StatefulWidget {
  final Ticket ticket;

  const TicketDetailScreen({super.key, required this.ticket});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  final TicketService _ticketService = TicketService();
  late Ticket _ticket;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _ticket = widget.ticket;
  }

  Future<void> _updateStatus(String newStatus) async {
    setState(() => _isLoading = true);
    try {
      final updatedTicket = Ticket(
        id: _ticket.id,
        titulo: _ticket.titulo,
        descripcion: _ticket.descripcion,
        estado: newStatus,
        prioridad: _ticket.prioridad,
        clienteNombre: _ticket.clienteNombre,
        fechaCreacion: _ticket.fechaCreacion,
      );

      await _ticketService.updateTicket(_ticket.id!, updatedTicket);
      
      setState(() {
        _ticket = updatedTicket;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Estado actualizado con éxito')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(title: Text('Ticket #${_ticket.id}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 20),
            if (_isLoading) 
              const Center(child: CircularProgressIndicator())
            else 
              _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              children: [
                _StatusBadge(status: _ticket.estado),
                const Spacer(),
                Text(_ticket.prioridad.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.0, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _ticket.titulo,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 24),
            _buildLabel('CLIENTE'),
            Text(_ticket.clienteNombre, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            _buildLabel('DESCRIPCIÓN'),
            Text(_ticket.descripcion, style: const TextStyle(fontSize: 15, height: 1.5, color: Color(0xFF475569))),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFF94A3B8),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _updateStatus('EnProceso'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[50],
              foregroundColor: Colors.amber[900],
            ),
            child: const Text('MARCAR EN PROCESO'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _updateStatus('Cerrado'),
             style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF10B981), // Emerald 500
              foregroundColor: Colors.white,
            ),
            child: const Text('CERRAR TICKET'),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (status) {
      case 'Abierto':
        bg = Colors.red[50]!;
        fg = Colors.red[700]!;
        break;
      case 'EnProceso':
        bg = Colors.amber[50]!;
        fg = Colors.amber[800]!;
        break;
      case 'Cerrado':
        bg = Colors.green[50]!;
        fg = Colors.green[800]!;
        break;
      default:
        bg = Colors.grey[100]!;
        fg = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }
}
