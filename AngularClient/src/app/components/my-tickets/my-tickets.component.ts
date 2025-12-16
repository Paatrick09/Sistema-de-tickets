import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TicketService, Ticket } from '../../services/ticket.service';

@Component({
  selector: 'app-my-tickets',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    <div class="container">
      <div class="card-elegant">
        <h2 class="mb-4">Mis Tickets</h2>
        
        <div class="mb-4">
          <label class="form-label">Buscar por nombre de cliente</label>
          <div class="input-group">
            <input type="text" class="form-control" [(ngModel)]="clienteFiltro" placeholder="Ingrese su nombre">
            <button class="btn btn-outline-secondary" type="button" (click)="filtrar()">
              Buscar
            </button>
          </div>
        </div>

        <div class="table-responsive" *ngIf="ticketsFiltrados.length > 0">
          <table class="table-elegant">
            <thead>
              <tr>
                <th>ID</th>
                <th>Título</th>
                <th>Estado</th>
                <th>Prioridad</th>
                <th>Fecha</th>
              </tr>
            </thead>
            <tbody>
              <tr *ngFor="let t of ticketsFiltrados">
                <td class="text-muted fw-bold">#{{t.id}}</td>
                <td class="fw-bold text-dark">{{t.titulo}}</td>
                <td>
                  <span [ngClass]="{
                    'badge-custom badge-open': t.estado === 'Abierto',
                    'badge-custom badge-process': t.estado === 'EnProceso',
                    'badge-custom badge-closed': t.estado === 'Cerrado'
                  }">{{t.estado}}</span>
                </td>
                <td>{{t.prioridad}}</td>
                <td class="text-secondary">{{t.fechaCreacion | date}}</td>
              </tr>
            </tbody>
          </table>
        </div>
        
        <div *ngIf="ticketsFiltrados.length === 0 && searched" class="text-center p-4 border rounded bg-light text-muted">
          No se encontraron tickets para este cliente.
        </div>
      </div>
    </div>
  `
})
export class MyTicketsComponent {
  tickets: Ticket[] = [];
  ticketsFiltrados: Ticket[] = [];
  clienteFiltro: string = '';
  searched = false;

  constructor(private ticketService: TicketService) { }

  ngOnInit() {
    this.ticketService.getTickets().subscribe(data => {
      this.tickets = data;
    });
  }

  filtrar() {
    this.searched = true;
    if (!this.clienteFiltro) {
      this.ticketsFiltrados = [];
      return;
    }
    this.ticketsFiltrados = this.tickets.filter(t =>
      t.clienteNombre.toLowerCase().includes(this.clienteFiltro.toLowerCase())
    );
  }
}
