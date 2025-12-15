using System.Net.Http.Json;
using TicketSystem.Maui.Models;

namespace TicketSystem.Maui.Services;

public class TicketService
{
    private readonly HttpClient _http;
    // Ajustar URL según plataforma (localhost para iOS/Mac, 10.0.2.2 para Android)
    private const string BaseUrl = "http://localhost:5000/api/tickets";

    public TicketService()
    {
        _http = new HttpClient();
    }

    public async Task<List<Ticket>> GetTicketsAsync()
    {
        try
        {
            return await _http.GetFromJsonAsync<List<Ticket>>(BaseUrl) ?? new List<Ticket>();
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            return new List<Ticket>();
        }
    }

    public async Task UpdateTicketAsync(int id, Ticket ticket)
    {
        await _http.PutAsJsonAsync($"{BaseUrl}/{id}", ticket);
    }
}
