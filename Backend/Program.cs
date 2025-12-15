using Microsoft.EntityFrameworkCore;
using TicketSystem.API.Data;
using TicketSystem.API.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configurar DbContext con SQLite
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlite(builder.Configuration.GetConnectionString("DefaultConnection")));

// Configurar CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        policy =>
        {
            policy.AllowAnyOrigin()
                  .AllowAnyMethod()
                  .AllowAnyHeader();
        });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowAll");

// Migración automática al iniciar (solo para demo)
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    db.Database.EnsureCreated();
}

// Endpoints
var api = app.MapGroup("/api/tickets");

// GET /api/tickets
api.MapGet("/", async (AppDbContext db) =>
    await db.Tickets.ToListAsync());

// GET /api/tickets/{id}
api.MapGet("/{id}", async (int id, AppDbContext db) =>
    await db.Tickets.FindAsync(id)
        is Ticket ticket
            ? Results.Ok(ticket)
            : Results.NotFound());

// POST /api/tickets
api.MapPost("/", async (Ticket ticket, AppDbContext db) =>
{
    ticket.FechaCreacion = DateTime.UtcNow;
    db.Tickets.Add(ticket);
    await db.SaveChangesAsync();

    return Results.Created($"/api/tickets/{ticket.Id}", ticket);
});

// PUT /api/tickets/{id}
api.MapPut("/{id}", async (int id, Ticket inputTicket, AppDbContext db) =>
{
    var ticket = await db.Tickets.FindAsync(id);

    if (ticket is null) return Results.NotFound();

    ticket.Titulo = inputTicket.Titulo;
    ticket.Descripcion = inputTicket.Descripcion;
    ticket.Estado = inputTicket.Estado;
    ticket.Prioridad = inputTicket.Prioridad;
    ticket.FechaActualizacion = DateTime.UtcNow;

    await db.SaveChangesAsync();

    return Results.NoContent();
});

// DELETE /api/tickets/{id}
api.MapDelete("/{id}", async (int id, AppDbContext db) =>
{
    if (await db.Tickets.FindAsync(id) is Ticket ticket)
    {
        db.Tickets.Remove(ticket);
        await db.SaveChangesAsync();
        return Results.NoContent();
    }

    return Results.NotFound();
});

app.Run();
