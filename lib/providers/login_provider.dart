import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {

  bool _isSignIn = false;
  set isSignIn(bool v) {
    _isSignIn = v;
    notifyListeners();
  }
  bool get isSignIn => _isSignIn;

  final Map<String, String> _users = {
    'Administrador': 'admin98',
    'Vendedor': 'seller67',
  };
  List<String> getUsers() {
    return [..._users.keys];
  }

  String _selectedUser = 'Administrador';
  set selectedUser(String newUser) {    
    _selectedUser = newUser;
    notifyListeners();
  }
  String get selectedUser => _selectedUser;

  bool checkPassword(String pwd) {
    // TODO: sha-256
    if (pwd != _users[_selectedUser]) return false;

    _isSignIn = true;
    return true;
  }
  
}