using Microsoft.EntityFrameworkCore;
using TicketSystem.API.Models;

namespace TicketSystem.API.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    public DbSet<Ticket> Tickets { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Ticket>().HasData(
            new Ticket { Id = 1, Titulo = "Problema con impresora", Descripcion = "La impresora no conecta a la red", ClienteNombre = "Acme Corp", Prioridad = "Alta", Estado = "Abierto", FechaCreacion = DateTime.UtcNow.AddDays(-2) },
            new Ticket { Id = 2, Titulo = "Licencia expirada", Descripcion = "Necesito renovar la licencia de Office", ClienteNombre = "Juan Perez", Prioridad = "Media", Estado = "EnProceso", FechaCreacion = DateTime.UtcNow.AddDays(-1) },
            new Ticket { Id = 3, Titulo = "Solicitud de acceso", Descripcion = "Acceso a la carpeta compartida de Marketing", ClienteNombre = "Maria Lopez", Prioridad = "Baja", Estado = "Cerrado", FechaCreacion = DateTime.UtcNow.AddDays(-5), FechaActualizacion = DateTime.UtcNow.AddDays(-1) }
        );
    }
}
