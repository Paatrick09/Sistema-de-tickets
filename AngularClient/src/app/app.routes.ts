import { Routes } from '@angular/router';
import { CreateTicketComponent } from './components/create-ticket/create-ticket.component';
import { MyTicketsComponent } from './components/my-tickets/my-tickets.component';

export const routes: Routes = [
    { path: '', redirectTo: 'create-ticket', pathMatch: 'full' },
    { path: 'create-ticket', component: CreateTicketComponent },
    { path: 'my-tickets', component: MyTicketsComponent }
];
