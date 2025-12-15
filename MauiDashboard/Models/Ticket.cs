namespace TicketSystem.Maui.Models;

public class Ticket
{
    public int Id { get; set; }
    public string Titulo { get; set; } = string.Empty;
    public string Descripcion { get; set; } = string.Empty;
    public string Estado { get; set; } = "Abierto";
    public string Prioridad { get; set; } = "Media";
    public string ClienteNombre { get; set; } = string.Empty;
    public DateTime FechaCreacion { get; set; }
    public DateTime? FechaActualizacion { get; set; }
}
