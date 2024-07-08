import 'package:flutter/material.dart';
import 'package:tracking_cuaca/pages/search_field.dart'; // Sesuaikan dengan path yang benar

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // Fungsi untuk logout (contoh)
  void _logout(BuildContext context) {
    // Implementasi logika logout di sini (misalnya menghapus token atau data sesi)
    // Setelah logout, Anda bisa navigasi kembali ke halaman login atau halaman lain sesuai kebutuhan
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            setState(() {
              // Melakukan refresh tampilan dengan memanggil setState
            });
          },
          child: const Text(
            'TRACU',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: const [
                        Text(
                          'TRACU',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Tracking Cuaca',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Aplikasi TRACU adalah platform untuk mengetahui kondisi cuaca di berbagai kota dan negara di seluruh dunia. Proyek ini dibuat sebagai bagian dari penilaian akhir semester untuk menyediakan informasi cuaca yang akurat dan berguna bagi pengguna.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Temukan informasi cuaca terkini di berbagai lokasi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SearchField()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: const Text(
                      'Mulai Lacak Cuaca',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
