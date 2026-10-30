import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User(name: '', email: '', isLoggedIn: false);
  bool _isLoading = true;
  bool _isDarkMode = false;
  int _visitCount = 0;
  List<String> _favorites = [];

  User get user => _user;
  bool get isLoading => _isLoading;
  bool get isDarkMode => _isDarkMode;
  int get visitCount => _visitCount;
  List<String> get favorites => _favorites;

  UserProvider() {
    _loadDataFromPrefs();
  }

  Future<void> _loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _visitCount = (prefs.getInt('visit_count') ?? 0) + 1;
    await prefs.setInt('visit_count', _visitCount);

    _isDarkMode = prefs.getBool('is_dark_mode') ?? false;

    final name = prefs.getString('user_name') ?? '';
    final email = prefs.getString('user_email') ?? '';
    _user = User(name: name, email: email, isLoggedIn: name.isNotEmpty);

    _favorites = prefs.getStringList('user_favorites') ?? [];

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateUser(User newUser) async {
    _user = newUser;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', newUser.name);
    await prefs.setString('user_email', newUser.email);
    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_dark_mode', value);
    _isDarkMode = value;
    notifyListeners();
  }

  Future<void> addFavorite(String item) async {
    _favorites.add(item);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user_favorites', _favorites);
    notifyListeners();
  }
  Future<void> removeFavorite(int index) async {
    _favorites.removeAt(index);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user_favorites', _favorites);
    notifyListeners();
  }
  Future<void> logout() async {
    _user = User(name: '', email: '', isLoggedIn: false);
    notifyListeners();
  }
}