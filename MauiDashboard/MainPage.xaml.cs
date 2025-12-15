using TicketSystem.Maui.Models;
using TicketSystem.Maui.Services;
using TicketSystem.Maui.Views;

namespace TicketSystem.Maui;

public partial class MainPage : ContentPage
{
    private readonly TicketService _ticketService;

    public MainPage()
    {
        InitializeComponent();
        _ticketService = new TicketService(); // Simplificación para demo
    }

    protected override async void OnAppearing()
    {
        base.OnAppearing();
        await LoadData();
    }

    private async void OnRefreshClicked(object sender, EventArgs e)
    {
        await LoadData();
    }

    private async Task LoadData()
    {
        var tickets = await _ticketService.GetTicketsAsync();

        lblAbiertos.Text = tickets.Count(t => t.Estado == "Abierto").ToString();
        lblEnProceso.Text = tickets.Count(t => t.Estado == "EnProceso").ToString();
        lblCerrados.Text = tickets.Count(t => t.Estado == "Cerrado").ToString();

        cvTickets.ItemsSource = tickets;
    }

    private async void OnTicketSelected(object sender, SelectionChangedEventArgs e)
    {
        if (e.CurrentSelection.FirstOrDefault() is Ticket selectedTicket)
        {
            await Navigation.PushAsync(new TicketDetailPage(selectedTicket));
            // Deseleccionar
            cvTickets.SelectedItem = null;
        }
    }
}
