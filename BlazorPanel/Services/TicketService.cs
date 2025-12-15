using System.Net.Http.Json;
using TicketSystem.Blazor.Models;

namespace TicketSystem.Blazor.Services;

public class TicketService
{
    private readonly HttpClient _http;

    public TicketService(HttpClient http)
    {
        _http = http;
    }

    public async Task<List<Ticket>> GetTicketsAsync()
    {
        return await _http.GetFromJsonAsync<List<Ticket>>("api/tickets") ?? new List<Ticket>();
    }

    public async Task<Ticket?> GetTicketByIdAsync(int id)
    {
        return await _http.GetFromJsonAsync<Ticket>($"api/tickets/{id}");
    }

    public async Task CreateTicketAsync(Ticket ticket)
    {
        await _http.PostAsJsonAsync("api/tickets", ticket);
    }

    public async Task UpdateTicketAsync(int id, Ticket ticket)
    {
        await _http.PutAsJsonAsync($"api/tickets/{id}", ticket);
    }
}
