import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HotelBookingPage extends StatefulWidget {
  const HotelBookingPage({super.key});

  @override
  State<HotelBookingPage> createState() => _HotelBookingPageState();
}

class _HotelBookingPageState extends State<HotelBookingPage> {
  String location = "Cox's Bazar";
  DateTime checkInDate = DateTime(2025, 4, 16);
  DateTime checkOutDate = DateTime(2025, 4, 17);
  int guests = 2;
  int rooms = 1;
  final List<String> filters = ["Business", "Couples", "Families", "Friends", "Solo"];
  final Set<String> selectedFilters = {};

  // Sample cities and areas for selection
  final List<String> locations = ["Cox's Bazar", "Dhaka", "Chittagong", "Sylhet"];
  final List<int> guestOptions = [1, 2, 3, 4, 5, 6];
  final List<int> roomOptions = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Hotel'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _locationTile(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _dateColumn('CHECK IN', checkInDate, 'checkIn')),
                const SizedBox(width: 10),
                Expanded(child: _dateColumn('CHECK OUT', checkOutDate, 'checkOut')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _selectableColumn('GUESTS', '$guests Guests', guestOptions, 'guests')),
                const SizedBox(width: 10),
                Expanded(child: _selectableColumn('ROOMS', '$rooms Rooms', roomOptions, 'rooms')),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Optional Filters'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: filters.map((filter) => FilterChip(
                label: Text(filter),
                selected: selectedFilters.contains(filter),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      selectedFilters.add(filter);
                    } else {
                      selectedFilters.remove(filter);
                    }
                  });
                },
              )).toList(),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: () {},
                child: const Text('Search', style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 16),
            _helpTile(),
            const SizedBox(height: 16),
            _previousSearches(),
            const SizedBox(height: 16),
            _hotDeals(),
          ],
        ),
      ),
    );
  }

  Widget _locationTile() {
    return GestureDetector(
      onTap: () => _selectLocation(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CITY/AREA/PROPERTY NAME', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(location, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Text('Bangladesh', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _dateColumn(String label, DateTime date, String type) {
    final formatted = DateFormat('d MMM').format(date);
    final day = DateFormat('EEEE').format(date);
    return GestureDetector(
      onTap: () => _selectDate(type),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(formatted, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(day, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _selectableColumn(String label, String value, List<int> options, String type) {
    return GestureDetector(
      onTap: () => _selectOptions(type, options),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _selectLocation() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Location'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: locations.map((location) {
              return ListTile(
                title: Text(location),
                onTap: () {
                  Navigator.pop(context, location);
                },
              );
            }).toList(),
          ),
        );
      },
    );
    if (selected != null) {
      setState(() {
        location = selected;
      });
    }
  }

  void _selectDate(String type) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: type == 'checkIn' ? checkInDate : checkOutDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
    );
    if (selectedDate != null) {
      setState(() {
        if (type == 'checkIn') {
          checkInDate = selectedDate;
        } else {
          checkOutDate = selectedDate;
        }
      });
    }
  }

  void _selectOptions(String type, List<int> options) async {
    final selectedOption = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select $type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return ListTile(
                title: Text('$option'),
                onTap: () {
                  Navigator.pop(context, option);
                },
              );
            }).toList(),
          ),
        );
      },
    );
    if (selectedOption != null) {
      setState(() {
        if (type == 'guests') {
          guests = selectedOption;
        } else if (type == 'rooms') {
          rooms = selectedOption;
        }
      });
    }
  }

  Widget _helpTile() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.hotel, color: Colors.black54),
          const SizedBox(width: 10),
          const Expanded(child: Text('How to Book Hotel?')),
          TextButton(
            onPressed: () {},
            child: const Text('Watch Video', style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
    );
  }

  Widget _previousSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Previous Searches', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Clear All', style: TextStyle(color: Colors.blue)),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 4),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(location, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 4),
              Text('16 Apr’25  →  17 Apr’25'),
              const SizedBox(height: 2),
              const Text('👤 2 Adults'),
            ],
          ),
        )
      ],
    );
  }

  Widget _hotDeals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hot Deals', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _dealCard()),
            const SizedBox(width: 10),
            Expanded(child: _dealCard()),
          ],
        )
      ],
    );
  }

  Widget _dealCard() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            ),
            child: const Center(
              child: Text(
                'Up to\n65%\nDiscount*',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('On Domestic Hotels for', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Selected Cards'),
                  Text('View Details', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
