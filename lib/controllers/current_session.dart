import 'package:money_maker/screens/register/model/register_response.dart';

class CurrentSession {
  static final CurrentSession _shared = CurrentSession._private();

  factory CurrentSession() => _shared;

  CurrentSession._private();

  User? _user;

  void setUser(User model) {
    _user = model;
  }

  User? getUser() {
    if (isAuth()) return _user;
    return null;
  }

  void clear() {
    _user = null;
  }

  bool isAuth() => _user != null;
}
