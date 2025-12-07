// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Profile Information`
  String get profileInformation {
    return Intl.message(
      'Profile Information',
      name: 'profileInformation',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yes {
    return Intl.message(
      'YES',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `NO`
  String get no {
    return Intl.message(
      'NO',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account? This action cannot be undone.`
  String get areYouSureYouWantToDeleteYourAccountThis {
    return Intl.message(
      'Are you sure you want to delete your account? This action cannot be undone.',
      name: 'areYouSureYouWantToDeleteYourAccountThis',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get confirmDeletion {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirmDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Delete My Account`
  String get deleteMyAccount {
    return Intl.message(
      'Delete My Account',
      name: 'deleteMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy & Terms`
  String get privacyPolicyTerms {
    return Intl.message(
      'Privacy Policy & Terms',
      name: 'privacyPolicyTerms',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Portfolio`
  String get portfolio {
    return Intl.message(
      'Portfolio',
      name: 'portfolio',
      desc: '',
      args: [],
    );
  }

  /// `Top`
  String get top {
    return Intl.message(
      'Top',
      name: 'top',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectCountry {
    return Intl.message(
      'Select Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been successfully created. Please log in to continue.`
  String get yourAccountHasBeenSuccessfullyCreatedPleaseLogInTo {
    return Intl.message(
      'Your account has been successfully created. Please log in to continue.',
      name: 'yourAccountHasBeenSuccessfullyCreatedPleaseLogInTo',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name.`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name.',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please verify the email address.`
  String get pleaseVerifyTheEmailAddress {
    return Intl.message(
      'Please verify the email address.',
      name: 'pleaseVerifyTheEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `The password must be at least 8 characters or digits long.`
  String get thePasswordMustBeAtLeast8CharactersOrDigits {
    return Intl.message(
      'The password must be at least 8 characters or digits long.',
      name: 'thePasswordMustBeAtLeast8CharactersOrDigits',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure both passwords are the same.`
  String get pleaseMakeSureBothPasswordsAreTheSame {
    return Intl.message(
      'Please make sure both passwords are the same.',
      name: 'pleaseMakeSureBothPasswordsAreTheSame',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected response from server`
  String get unexpectedResponseFromServer {
    return Intl.message(
      'Unexpected response from server',
      name: 'unexpectedResponseFromServer',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong. Please Try Again.`
  String get somethingWentWrongPleaseTryAgain {
    return Intl.message(
      'Something Went Wrong. Please Try Again.',
      name: 'somethingWentWrongPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch profile data`
  String get failedToFetchProfileData {
    return Intl.message(
      'Failed to fetch profile data',
      name: 'failedToFetchProfileData',
      desc: '',
      args: [],
    );
  }

  /// `Your personal info and account details`
  String get yourPersonalInfoAndAccountDetails {
    return Intl.message(
      'Your personal info and account details',
      name: 'yourPersonalInfoAndAccountDetails',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please verify the phone number.`
  String get pleaseVerifyThePhoneNumber {
    return Intl.message(
      'Please verify the phone number.',
      name: 'pleaseVerifyThePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number.`
  String get pleaseEnterAValidPhoneNumber {
    return Intl.message(
      'Please enter a valid phone number.',
      name: 'pleaseEnterAValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `We have emailed your password reset link.`
  String get weHaveEmailedYourPasswordResetLink {
    return Intl.message(
      'We have emailed your password reset link.',
      name: 'weHaveEmailedYourPasswordResetLink',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to reset your password.`
  String get enterYourEmailToResetYourPassword {
    return Intl.message(
      'Enter your email to reset your password.',
      name: 'enterYourEmailToResetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Go Back To`
  String get goBackTo {
    return Intl.message(
      'Go Back To',
      name: 'goBackTo',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Error loading portfolio value`
  String get errorLoadingPortfolioValue {
    return Intl.message(
      'Error loading portfolio value',
      name: 'errorLoadingPortfolioValue',
      desc: '',
      args: [],
    );
  }

  /// `MARKET PLACE`
  String get marketPlace {
    return Intl.message(
      'MARKET PLACE',
      name: 'marketPlace',
      desc: '',
      args: [],
    );
  }

  /// `BUY`
  String get buy {
    return Intl.message(
      'BUY',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `No market items found`
  String get noMarketItemsFound {
    return Intl.message(
      'No market items found',
      name: 'noMarketItemsFound',
      desc: '',
      args: [],
    );
  }

  /// `Error loading data`
  String get errorLoadingData {
    return Intl.message(
      'Error loading data',
      name: 'errorLoadingData',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
