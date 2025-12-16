import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TicketService, Ticket } from '../../services/ticket.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-create-ticket',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-8">
          <div class="card-elegant">
            <h2 class="mb-4 font-weight-bold">Crear Nuevo Ticket</h2>
            <form (ngSubmit)="onSubmit()">
              <div class="mb-3">
                <label class="form-label">Nombre del Cliente</label>
                <input type="text" class="form-control" [(ngModel)]="ticket.clienteNombre" name="clienteNombre" placeholder="Ej. Empresa SA" required>
              </div>
              <div class="mb-3">
                <label class="form-label">Título</label>
                <input type="text" class="form-control" [(ngModel)]="ticket.titulo" name="titulo" placeholder="Breve resumen del problema" required>
              </div>
              <div class="mb-3">
                <label class="form-label">Descripción</label>
                <textarea class="form-control" rows="4" [(ngModel)]="ticket.descripcion" name="descripcion" placeholder="Detalle lo sucedido..." required></textarea>
              </div>
              <div class="mb-4">
                <label class="form-label">Prioridad</label>
                <select class="form-select" [(ngModel)]="ticket.prioridad" name="prioridad">
                  <option value="Baja">Baja</option>
                  <option value="Media">Media</option>
                  <option value="Alta">Alta</option>
                </select>
              </div>
              <button type="submit" class="btn btn-primary w-100">
                Enviar Ticket
              </button>
            </form>
          </div>
        </div>
      </div>
    </div>
  `
})
export class CreateTicketComponent {
  ticket: Ticket = {
    titulo: '',
    descripcion: '',
    estado: 'Abierto',
    prioridad: 'Media',
    clienteNombre: ''
  };

  constructor(private ticketService: TicketService, private router: Router) { }

  onSubmit() {
    this.ticketService.createTicket(this.ticket).subscribe({
      next: () => {
        alert('Ticket creado con éxito');
        this.router.navigate(['/my-tickets']);
      },
      error: (err) => console.error(err)
    });
  }
}
