import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(
                  provider.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                ),
                onPressed: () {
                  provider.toggleTheme(!provider.isDarkMode);
                },
                tooltip: 'Ubah Tema',
              ),
            ],
          ),
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.home,
                          size: 64,
                          color: Colors.deepPurple,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          provider.user.isLoggedIn
                              ? 'Selamat datang, ${provider.user.name}!'
                              : 'Selamat datang, Tamu!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Chip(
                          avatar: const Icon(Icons.remove_red_eye, size: 18),
                          label: Text('Aplikasi dibuka: ${provider.visitCount} kali'),
                        ),
                        const SizedBox(height: 12),
                        if (provider.user.isLoggedIn) ...[
                          Text(
                            'Email: ${provider.user.email}',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                        ],
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                            );
                          },
                          icon: Icon(
                            provider.user.isLoggedIn ? Icons.person : Icons.login,
                            size: 18,
                          ),
                          label: Text(
                            provider.user.isLoggedIn
                                ? 'Lihat Profil'
                                : 'Login / Daftar',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple.shade50,
                            foregroundColor: Colors.deepPurple,
                            elevation: 0,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}