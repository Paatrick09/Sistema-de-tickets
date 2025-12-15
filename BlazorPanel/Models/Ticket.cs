using System.ComponentModel.DataAnnotations;

namespace TicketSystem.Blazor.Models;

public class Ticket
{
    public int Id { get; set; }

    [MaxLength(200)]
    public string Titulo { get; set; } = string.Empty;

    public string Descripcion { get; set; } = string.Empty;

    public string Estado { get; set; } = "Abierto"; // Abierto, EnProceso, Cerrado

    public string Prioridad { get; set; } = "Media"; // Baja, Media, Alta

    public string ClienteNombre { get; set; } = string.Empty;

    public DateTime FechaCreacion { get; set; } = DateTime.UtcNow;

    public DateTime? FechaActualizacion { get; set; }
}
