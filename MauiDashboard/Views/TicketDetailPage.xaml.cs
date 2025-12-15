using TicketSystem.Maui.Models;
using TicketSystem.Maui.Services;

namespace TicketSystem.Maui.Views;

public partial class TicketDetailPage : ContentPage
{
    public Ticket Ticket { get; set; }
    private readonly TicketService _ticketService;

    public TicketDetailPage(Ticket ticket)
    {
        InitializeComponent();
        Ticket = ticket;
        BindingContext = this;
        _ticketService = new TicketService();
    }

    private async void OnEnProcesoClicked(object sender, EventArgs e)
    {
        await UpdateStatus("EnProceso");
    }

    private async void OnCerrarClicked(object sender, EventArgs e)
    {
        await UpdateStatus("Cerrado");
    }

    private async Task UpdateStatus(string nuevoEstado)
    {
        Ticket.Estado = nuevoEstado;
        await _ticketService.UpdateTicketAsync(Ticket.Id, Ticket);
        await DisplayAlert("Éxito", $"Ticket actualizado a {nuevoEstado}", "OK");
        await Navigation.PopAsync();
    }
}
