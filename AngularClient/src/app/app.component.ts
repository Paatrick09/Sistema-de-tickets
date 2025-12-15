import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet, RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, RouterLink, RouterLinkActive],
  template: `
    <nav class="navbar navbar-expand-lg navbar-custom mb-5">
      <div class="container">
        <a class="navbar-brand" href="#">
           🎟️ TicketClient
        </a>
        <div class="navbar-nav ms-auto">
          <a class="nav-link" routerLink="/create-ticket" routerLinkActive="active">Nuevo Ticket</a>
          <a class="nav-link" routerLink="/my-tickets" routerLinkActive="active">Mis Tickets</a>
        </div>
      </div>
    </nav>
    <router-outlet></router-outlet>
  `
})
export class AppComponent {
  title = 'angular-client';
}
