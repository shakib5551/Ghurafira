import 'package:flutter/material.dart';
import 'hotel_booking_page.dart'; // Import the hotel booking page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HotelBookingPage(), // Set the home page
    );
  }
}
