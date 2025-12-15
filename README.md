# Multi-Platform Ticket System Demo

Este repositorio contiene un ejemplo completo de una aplicación multi-plataforma para un sistema de tickets, utilizando .NET 8, Angular, Flutter y MAUI.

## Estructura de la Solución

- **Backend**: ASP.NET Core Web API (.NET 8) con Entity Framework Core y SQLite.
- **BlazorPanel**: Blazor Server (.NET 8) para el panel de administración interno.
- **AngularClient**: Aplicación Angular para el portal de clientes.
- **FlutterApp**: Aplicación móvil Flutter para técnicos/clientes.
- **MauiDashboard**: Aplicación .NET MAUI para dashboard de escritorio/móvil.

## Prerrequisitos

- .NET 8 SDK
- Node.js y npm
- Angular CLI (`npm install -g @angular/cli`)
- Flutter SDK
- Visual Studio 2022 (para MAUI) o VS Code con extensiones.

## Instrucciones de Ejecución

### 1. Backend (API)

El backend debe estar corriendo para que los demás proyectos funcionen.

```bash
cd Backend
dotnet restore
dotnet run
```

La API estará disponible en `http://localhost:5000` (o el puerto que asigne Kestrel, verifica la consola).
**Nota:** La base de datos SQLite `tickets.db` se creará automáticamente con datos de prueba al iniciar.

### 2. Blazor Server (Panel Interno)

```bash
cd BlazorPanel
dotnet restore
dotnet run
```

Abre el navegador en la URL indicada (ej. `http://localhost:5002`).

### 3. Angular (Portal Cliente)

```bash
cd AngularClient
npm install
npm start
```

Abre `http://localhost:4200`.

### 4. Flutter (App Móvil)

```bash
cd FlutterApp
flutter pub get
flutter run
/Users/patrick/develop/flutter/bin/flutter run
```

**Nota:** Si usas Android Emulator, asegúrate de cambiar la URL en `lib/services/ticket_service.dart` a `http://10.0.2.2:5000`.

### 5. .NET MAUI (Dashboard)

Abre la solución o el proyecto en Visual Studio 2022 y ejecuta el proyecto `TicketSystem.Maui` seleccionando el framework de destino deseado (Windows Machine, Android Emulator, iOS Simulator).

## Flujo de Prueba Sugerido

1. **Crear Ticket (Angular):** Ve al portal Angular, llena el formulario y crea un ticket.
2. **Ver Ticket (Blazor):** Ve al panel Blazor, refresca la lista y verás el nuevo ticket. Entra al detalle.
3. **Cambiar Estado (Flutter/MAUI):** Abre la app móvil o dashboard, busca el ticket y cambia su estado a "En Proceso" o "Cerrado".
4. **Verificar:** Vuelve a Blazor o Angular y verifica que el estado se haya actualizado.
