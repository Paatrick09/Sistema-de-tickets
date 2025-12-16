import 'package:flutter/material.dart';
import 'screens/ticket_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket App',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      home: const TicketListScreen(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    // Professional color palette (Slate/Blue focus)
    const primaryColor = Color(0xFF0F172A); // Slate 900
    const secondaryColor = Color(0xFF334155); // Slate 700
    const surfaceColor = Colors.white;
    const scaffoldBackgroundColor = Color(0xFFF1F5F9); // Slate 100

    var baseTheme = ThemeData(
      brightness: brightness, 
      useMaterial3: true,
      fontFamily: 'Roboto', // Standard professional font
    );

    return baseTheme.copyWith(
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        brightness: brightness,
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: false, // More corporate left-aligned
        elevation: 0,
        backgroundColor: surfaceColor,
        foregroundColor: primaryColor,
        scrolledUnderElevation: 2,
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: secondaryColor),
      ),
      cardTheme: CardThemeData(
        elevation: 0, // Flat design with border
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Sharper corners
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1), // Slate 200 border
        ),
        color: surfaceColor,
        surfaceTintColor: surfaceColor,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)), // Slate 300
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          elevation: 0,
          textStyle: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: primaryColor, 
          fontWeight: FontWeight.w700, 
          letterSpacing: -0.5
        ),
        titleMedium: TextStyle(
          color: primaryColor, 
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        bodyMedium: TextStyle(color: secondaryColor),
      ),
    );
  }
}
