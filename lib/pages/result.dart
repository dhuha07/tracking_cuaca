import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final String place;
  const Result({Key? key, required this.place}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  late Future<Map<String, dynamic>> _weatherData;
  late AnimationController _controller; // AnimationController declaration
  bool _isLoading = true;
  bool _cityNotFound = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _weatherData = getDataFromAPI();
  }

  Future<Map<String, dynamic>> getDataFromAPI() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${widget.place}&appid=210f7d44aa9f8ec2fb0feac1133e3766&units=metric"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _isLoading = false;
        _cityNotFound = false;
        // Start animation if condition met
        if (data["weather"][0]["main"].toString().toLowerCase().contains("clear") ||
            data["weather"][0]["main"].toString().toLowerCase().contains("sun")) {
          _controller.repeat(); // Repeat animation
        } else {
          _controller.reset(); // Stop animation
        }
      });
      return data;
    } else if (response.statusCode == 404) {
      setState(() {
        _isLoading = false;
        _cityNotFound = true;
      });
      return {};
    } else {
      throw Exception("Failed to load weather data. Status code: ${response.statusCode}");
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hasil Tracking", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.lightBlueAccent.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _cityNotFound
                ? Center(child: Text("Tempat tidak ditemukan", style: TextStyle(fontSize: 24, color: Colors.white)))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FutureBuilder<Map<String, dynamic>>(
                      future: _weatherData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error: ${snapshot.error}"));
                        } else if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RotationTransition(
                                  turns: _controller,
                                  child: Icon(
                                    _getWeatherIcon(data["weather"][0]["main"]),
                                    size: 100,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "${data["weather"][0]["main"]}",
                                  style: TextStyle(fontSize: 36, color: Colors.white),
                                ),
                                Text(
                                  "${data["weather"][0]["description"]}",
                                  style: TextStyle(fontSize: 24, color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Suhu: ${data["main"]["temp"]}°C",
                                  style: TextStyle(fontSize: 36, color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
      ),
    );
  }

  IconData _getWeatherIcon(String weatherDescription) {
    if (weatherDescription.toLowerCase().contains("rain")) {
      return Icons.beach_access;
    } else {
      return Icons.wb_sunny;
    }
  }
}
