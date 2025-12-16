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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
              children: [
                _StatusBadge(status: _ticket.estado),
                const Spacer(),
                Text(
                  'PRIORIDAD ${_ticket.prioridad.toUpperCase()}', 
                  style: TextStyle(
                    fontSize: 11, 
                    fontWeight: FontWeight.bold, 
                    letterSpacing: 1.0, 
                    color: _getPriorityColor(_ticket.prioridad)
                  )
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _ticket.titulo,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 20,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 32),
            _buildLabel('SOLICITADO POR'),
            Text(_ticket.clienteNombre, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            _buildLabel('DESCRIPCIÓN DETALLADA'),
            Text(
              _ticket.descripcion, 
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.6)
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Alta': return const Color(0xFFEF4444);
      case 'Media': return const Color(0xFFF59E0B);
      case 'Baja': return const Color(0xFF10B981);
      default: return Colors.grey;
    }
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF94A3B8), // Slate 400
          letterSpacing: 0.8,
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
              backgroundColor: const Color(0xFF334155), // Slate 700
              foregroundColor: Colors.white,
            ),
            child: const Text('MARCAR EN PROCESO'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => _updateStatus('Cerrado'),
             style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF0F172A), // Slate 900
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              textStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
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
    Color border;

    switch (status) {
      case 'Abierto':
        bg = Colors.white;
        fg = const Color(0xFFEF4444);
        border = const Color(0xFFFECACA); 
        break;
      case 'EnProceso':
        bg = Colors.white;
        fg = const Color(0xFFD97706); 
        border = const Color(0xFFFDE68A); 
        break;
      case 'Cerrado':
        bg = Colors.white;
        fg = const Color(0xFF059669); 
        border = const Color(0xFFA7F3D0); 
        break;
      default:
        bg = Colors.white;
        fg = const Color(0xFF475569);
        border = const Color(0xFFE2E8F0);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: border),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }
}
