import 'package:get/get.dart';
import 'package:money_maker/screens/register/model/register_response.dart';

class CurrentSession {
  static final CurrentSession _shared = CurrentSession._private();

  factory CurrentSession() => _shared;

  CurrentSession._private();

  UserModel? _user;

  void setUser(UserModel user) {
    _user = user;
  }

  UserModel? getUser() => _user;

  bool isAuth() => _user != null;

  void updateBalance(double newBalance) {
    if (_user != null) {
      _user = _user!.copyWith(balance: newBalance);
    }
  }

  void updatePortfolioValue(double newValue) {
    if (_user != null) {
      _user = _user!.copyWith(portfolioValue: newValue);
    }
  }

  void clear() {
    _user = null;
  }
}

class SessionController extends GetxController {
  UserModel? user;

  bool get isAuth => user != null;

  void setUser(UserModel newUser) {
    user = newUser;
    CurrentSession().setUser(newUser);
    update();
  }

  void updateBalance(double balance) {
    if (user != null) {
      user = user!.copyWith(balance: balance);
      CurrentSession().setUser(user!);
      update();
    }
  }

  void updatePortfolioValue(double value) {
    if (user != null) {
      user = user!.copyWith(portfolioValue: value);
      CurrentSession().setUser(user!);
      update();
    }
  }

  void updateUserData({
    double? balance,
    double? portfolioValue,
  }) {
    if (user != null) {
      user = user!.copyWith(
        balance: balance,
        portfolioValue: portfolioValue,
      );
      CurrentSession().setUser(user!);
      update();
    }
  }

  void addCompany(CompanyModel company) {
    if (user != null) {
      final updatedCompanies = List<CompanyModel>.from(user!.companies)
        ..add(company);

      user = user!.copyWith(
        hasCompanies: true,
        companies: updatedCompanies,
      );

      CurrentSession().setUser(user!);
      update();
    }
  }

  void clearSession() {
    user = null;
    CurrentSession().clear();
    update();
  }

  void loadFromSession() {
    user = CurrentSession().getUser();
    update();
  }
}