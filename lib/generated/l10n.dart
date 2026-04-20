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

  /// `العربية`
  String get arabic {
    return Intl.message(
      'العربية',
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

  /// `Transaction History`
  String get payment {
    return Intl.message(
      'Transaction History',
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

  /// `Your account has been successfully created.`
  String get yourAccountHasBeenSuccessfullyCreatedPleaseLogInTo {
    return Intl.message(
      'Your account has been successfully created.',
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

  /// `Forgot Password?`
  String get forgotPasswordL {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordL',
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

  /// `MARKETPLACE`
  String get marketPlace {
    return Intl.message(
      'MARKETPLACE',
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

  /// `Change Your Password`
  String get changeYourPassword {
    return Intl.message(
      'Change Your Password',
      name: 'changeYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your valid email.`
  String get pleaseEnterYourValidEmail {
    return Intl.message(
      'Please enter your valid email.',
      name: 'pleaseEnterYourValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `The password must be at least 6 characters or digits long.`
  String get thePasswordMustBeAtLeast6CharactersOrDigits {
    return Intl.message(
      'The password must be at least 6 characters or digits long.',
      name: 'thePasswordMustBeAtLeast6CharactersOrDigits',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Set New Password`
  String get setNewPassword {
    return Intl.message(
      'Set New Password',
      name: 'setNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your password was updated successfully.`
  String get yourPasswordWasUpdatedSuccessfully {
    return Intl.message(
      'Your password was updated successfully.',
      name: 'yourPasswordWasUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to reset password`
  String get failedToResetPassword {
    return Intl.message(
      'Failed to reset password',
      name: 'failedToResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Market`
  String get market {
    return Intl.message(
      'Market',
      name: 'market',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  /// `LEADERBOARD`
  String get leaderboard {
    return Intl.message(
      'LEADERBOARD',
      name: 'leaderboard',
      desc: '',
      args: [],
    );
  }

  /// `SPECIAL OFFERS`
  String get specialOffers {
    return Intl.message(
      'SPECIAL OFFERS',
      name: 'specialOffers',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while loading special offers.`
  String get somethingWentWrongWhileLoadingSpecialOffers {
    return Intl.message(
      'Something went wrong while loading special offers.',
      name: 'somethingWentWrongWhileLoadingSpecialOffers',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy this limited-time special offer on selected assets.`
  String get enjoyThisLimitedtimeSpecialOfferOnSelectedAssets {
    return Intl.message(
      'Enjoy this limited-time special offer on selected assets.',
      name: 'enjoyThisLimitedtimeSpecialOfferOnSelectedAssets',
      desc: '',
      args: [],
    );
  }

  /// `Included Assets`
  String get includedAssets {
    return Intl.message(
      'Included Assets',
      name: 'includedAssets',
      desc: '',
      args: [],
    );
  }

  /// `Expires on:`
  String get expiresOn {
    return Intl.message(
      'Expires on:',
      name: 'expiresOn',
      desc: '',
      args: [],
    );
  }

  /// `Code:`
  String get code {
    return Intl.message(
      'Code:',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `BUY NOW`
  String get buyNow {
    return Intl.message(
      'BUY NOW',
      name: 'buyNow',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load special offers right now.`
  String get unableToLoadSpecialOffersRightNow {
    return Intl.message(
      'Unable to load special offers right now.',
      name: 'unableToLoadSpecialOffersRightNow',
      desc: '',
      args: [],
    );
  }

  /// `No special offers are available right now.`
  String get noSpecialOffersAreAvailableRightNow {
    return Intl.message(
      'No special offers are available right now.',
      name: 'noSpecialOffersAreAvailableRightNow',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been deleted successfully.`
  String get yourAccountHasBeenDeletedSuccessfully {
    return Intl.message(
      'Your account has been deleted successfully.',
      name: 'yourAccountHasBeenDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `PRIVACY POLICY`
  String get privacyPolicy {
    return Intl.message(
      'PRIVACY POLICY',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicyBottom {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicyBottom',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load privacy policy right now.`
  String get unableToLoadPrivacyPolicyRightNow {
    return Intl.message(
      'Unable to load privacy policy right now.',
      name: 'unableToLoadPrivacyPolicyRightNow',
      desc: '',
      args: [],
    );
  }

  /// `No privacy policy is available at the moment.`
  String get noPrivacyPolicyIsAvailableAtTheMoment {
    return Intl.message(
      'No privacy policy is available at the moment.',
      name: 'noPrivacyPolicyIsAvailableAtTheMoment',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `By signing up, you agree to our`
  String get bySigningUpYouAgreeToOur {
    return Intl.message(
      'By signing up, you agree to our',
      name: 'bySigningUpYouAgreeToOur',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get terms {
    return Intl.message(
      'Terms',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Portfolio Value`
  String get portfolioValue {
    return Intl.message(
      'Portfolio Value',
      name: 'portfolioValue',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `No portfolio data found`
  String get noPortfolioDataFound {
    return Intl.message(
      'No portfolio data found',
      name: 'noPortfolioDataFound',
      desc: '',
      args: [],
    );
  }

  /// `Owned: {count} copies`
  String ownedCopies(Object count) {
    return Intl.message(
      'Owned: $count copies',
      name: 'ownedCopies',
      desc: '',
      args: [count],
    );
  }

  /// `Type: {type}`
  String typeLabel(Object type) {
    return Intl.message(
      'Type: $type',
      name: 'typeLabel',
      desc: '',
      args: [type],
    );
  }

  /// `SELL`
  String get sell {
    return Intl.message(
      'SELL',
      name: 'sell',
      desc: '',
      args: [],
    );
  }

  /// `Unit Price: {price}`
  String unitPrice(Object price) {
    return Intl.message(
      'Unit Price: $price',
      name: 'unitPrice',
      desc: '',
      args: [price],
    );
  }

  /// `Total: {total}`
  String totalPrice(Object total) {
    return Intl.message(
      'Total: $total',
      name: 'totalPrice',
      desc: '',
      args: [total],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Selling Price`
  String get sellingPrice {
    return Intl.message(
      'Selling Price',
      name: 'sellingPrice',
      desc: '',
      args: [],
    );
  }

  /// `List {name} for Sale`
  String listForSale(Object name) {
    return Intl.message(
      'List $name for Sale',
      name: 'listForSale',
      desc: '',
      args: [name],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `You can list fewer copies and choose any selling price.`
  String get youCanListFewerCopiesAndChooseAnySellingPrice {
    return Intl.message(
      'You can list fewer copies and choose any selling price.',
      name: 'youCanListFewerCopiesAndChooseAnySellingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Sort Options`
  String get sortOptions {
    return Intl.message(
      'Sort Options',
      name: 'sortOptions',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message(
      'Sort by',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Growth Rate`
  String get growthRate {
    return Intl.message(
      'Growth Rate',
      name: 'growthRate',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Ascending`
  String get ascending {
    return Intl.message(
      'Ascending',
      name: 'ascending',
      desc: '',
      args: [],
    );
  }

  /// `Descending`
  String get descending {
    return Intl.message(
      'Descending',
      name: 'descending',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get all {
    return Intl.message(
      'all',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Asset Type`
  String get assetType {
    return Intl.message(
      'Asset Type',
      name: 'assetType',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to buy this asset?\n\nThe price will be deducted from your balance and the asset will be added to your portfolio immediately.`
  String get buyConfirmationMessage {
    return Intl.message(
      'Are you sure you want to buy this asset?\n\nThe price will be deducted from your balance and the asset will be added to your portfolio immediately.',
      name: 'buyConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Purchase`
  String get confirmPurchase {
    return Intl.message(
      'Confirm Purchase',
      name: 'confirmPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Update Failed`
  String get updateFailed {
    return Intl.message(
      'Update Failed',
      name: 'updateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while updating your profile. Please try again.`
  String get somethingWentWrongWhileUpdatingYourProfilePleaseTryAgain {
    return Intl.message(
      'Something went wrong while updating your profile. Please try again.',
      name: 'somethingWentWrongWhileUpdatingYourProfilePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Your profile has been updated successfully.`
  String get yourProfileHasBeenUpdatedSuccessfully {
    return Intl.message(
      'Your profile has been updated successfully.',
      name: 'yourProfileHasBeenUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `No notifications yet.`
  String get noNotificationsYet {
    return Intl.message(
      'No notifications yet.',
      name: 'noNotificationsYet',
      desc: '',
      args: [],
    );
  }

  /// `Marketplace`
  String get marketPlaceH {
    return Intl.message(
      'Marketplace',
      name: 'marketPlaceH',
      desc: '',
      args: [],
    );
  }

  /// `MARKET`
  String get marketS {
    return Intl.message(
      'MARKET',
      name: 'marketS',
      desc: '',
      args: [],
    );
  }

  /// `Discover rare assets from other players! Send a purchase request after seller confirmation.`
  String get discoverRareAssetsFromOtherPlayersSendAPurchaseRequest {
    return Intl.message(
      'Discover rare assets from other players! Send a purchase request after seller confirmation.',
      name: 'discoverRareAssetsFromOtherPlayersSendAPurchaseRequest',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message(
      'Owner',
      name: 'owner',
      desc: '',
      args: [],
    );
  }

  /// `Processing...`
  String get processing {
    return Intl.message(
      'Processing...',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Recently listed`
  String get recentlyListed {
    return Intl.message(
      'Recently listed',
      name: 'recentlyListed',
      desc: '',
      args: [],
    );
  }

  /// `Listed on: {date}`
  String listedOn(Object date) {
    return Intl.message(
      'Listed on: $date',
      name: 'listedOn',
      desc: '',
      args: [date],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Your asset has been successfully listed in the marketplace.`
  String get yourAssetHasBeenSuccessfullyListedInTheMarketplace {
    return Intl.message(
      'Your asset has been successfully listed in the marketplace.',
      name: 'yourAssetHasBeenSuccessfullyListedInTheMarketplace',
      desc: '',
      args: [],
    );
  }

  /// `Great`
  String get great {
    return Intl.message(
      'Great',
      name: 'great',
      desc: '',
      args: [],
    );
  }

  /// `You are trying to sell more copies than you own. Please adjust the quantity.`
  String get youAreTryingToSellMoreCopiesThanYouOwn {
    return Intl.message(
      'You are trying to sell more copies than you own. Please adjust the quantity.',
      name: 'youAreTryingToSellMoreCopiesThanYouOwn',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Quantity`
  String get invalidQuantity {
    return Intl.message(
      'Invalid Quantity',
      name: 'invalidQuantity',
      desc: '',
      args: [],
    );
  }

  /// `Quantity Exceeds Ownership`
  String get quantityExceedsOwnership {
    return Intl.message(
      'Quantity Exceeds Ownership',
      name: 'quantityExceedsOwnership',
      desc: '',
      args: [],
    );
  }

  /// `Quantity must be at least 1.`
  String get quantityMustBeAtLeast1 {
    return Intl.message(
      'Quantity must be at least 1.',
      name: 'quantityMustBeAtLeast1',
      desc: '',
      args: [],
    );
  }

  /// `You only have {count} copies. Please adjust the quantity.`
  String quantityExceedsOwnershipN(Object count) {
    return Intl.message(
      'You only have $count copies. Please adjust the quantity.',
      name: 'quantityExceedsOwnershipN',
      desc: '',
      args: [count],
    );
  }

  /// `Unable to load contact information right now.`
  String get unableToLoadContactInformationRightNow {
    return Intl.message(
      'Unable to load contact information right now.',
      name: 'unableToLoadContactInformationRightNow',
      desc: '',
      args: [],
    );
  }

  /// `No contact information is available at the moment.`
  String get noContactInformationIsAvailableAtTheMoment {
    return Intl.message(
      'No contact information is available at the moment.',
      name: 'noContactInformationIsAvailableAtTheMoment',
      desc: '',
      args: [],
    );
  }

  /// `We’re here to help you`
  String get wereHereToHelpYou {
    return Intl.message(
      'We’re here to help you',
      name: 'wereHereToHelpYou',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout from your account?`
  String get areYouSureYouWantToLogoutFromYourAccount {
    return Intl.message(
      'Are you sure you want to logout from your account?',
      name: 'areYouSureYouWantToLogoutFromYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `RISE TO THE TOP`
  String get riseToTheTop {
    return Intl.message(
      'RISE TO THE TOP',
      name: 'riseToTheTop',
      desc: '',
      args: [],
    );
  }

  /// `Start Playing & Build Your Company`
  String get startPlayingBuildYourCompany {
    return Intl.message(
      'Start Playing & Build Your Company',
      name: 'startPlayingBuildYourCompany',
      desc: '',
      args: [],
    );
  }

  /// `BUILD YOUR COMPANY`
  String get buildYourCompany {
    return Intl.message(
      'BUILD YOUR COMPANY',
      name: 'buildYourCompany',
      desc: '',
      args: [],
    );
  }

  /// `Add Logo`
  String get addLogo {
    return Intl.message(
      'Add Logo',
      name: 'addLogo',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get companyName {
    return Intl.message(
      'Company Name',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `Enter company name`
  String get enterCompanyName {
    return Intl.message(
      'Enter company name',
      name: 'enterCompanyName',
      desc: '',
      args: [],
    );
  }

  /// `Please give your company a name that shines!`
  String get pleaseGiveYourCompanyANameThatShines {
    return Intl.message(
      'Please give your company a name that shines!',
      name: 'pleaseGiveYourCompanyANameThatShines',
      desc: '',
      args: [],
    );
  }

  /// `Founder Name`
  String get founderName {
    return Intl.message(
      'Founder Name',
      name: 'founderName',
      desc: '',
      args: [],
    );
  }

  /// `Your name`
  String get yourName {
    return Intl.message(
      'Your name',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Your company needs a founder — fill in your name!`
  String get yourCompanyNeedsAFounderFillInYourName {
    return Intl.message(
      'Your company needs a founder — fill in your name!',
      name: 'yourCompanyNeedsAFounderFillInYourName',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Category: `
  String get categoryDot {
    return Intl.message(
      'Category: ',
      name: 'categoryDot',
      desc: '',
      args: [],
    );
  }

  /// `Short Description`
  String get shortDescription {
    return Intl.message(
      'Short Description',
      name: 'shortDescription',
      desc: '',
      args: [],
    );
  }

  /// `Describe what makes your company unique and powerful...`
  String get describeWhatMakesYourCompanyUniqueAndPowerful {
    return Intl.message(
      'Describe what makes your company unique and powerful...',
      name: 'describeWhatMakesYourCompanyUniqueAndPowerful',
      desc: '',
      args: [],
    );
  }

  /// `Tell us what makes your company unique and exciting!`
  String get tellUsWhatMakesYourCompanyUniqueAndExciting {
    return Intl.message(
      'Tell us what makes your company unique and exciting!',
      name: 'tellUsWhatMakesYourCompanyUniqueAndExciting',
      desc: '',
      args: [],
    );
  }

  /// `Pick a category to show what your company is all about!`
  String get pickACategoryToShowWhatYourCompanyIsAll {
    return Intl.message(
      'Pick a category to show what your company is all about!',
      name: 'pickACategoryToShowWhatYourCompanyIsAll',
      desc: '',
      args: [],
    );
  }

  /// `Please add your company logo!`
  String get pleaseAddYourCompanyLogo {
    return Intl.message(
      'Please add your company logo!',
      name: 'pleaseAddYourCompanyLogo',
      desc: '',
      args: [],
    );
  }

  /// `Launch Company 🚀`
  String get launchCompany {
    return Intl.message(
      'Launch Company 🚀',
      name: 'launchCompany',
      desc: '',
      args: [],
    );
  }

  /// `Status: Pending`
  String get statusPending {
    return Intl.message(
      'Status: Pending',
      name: 'statusPending',
      desc: '',
      args: [],
    );
  }

  /// `Company Created Successfully 🎉`
  String get companyCreatedSuccessfully {
    return Intl.message(
      'Company Created Successfully 🎉',
      name: 'companyCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully established your company, but it is still inactive.`
  String get youHaveSuccessfullyEstablishedYourCompanyButItIsStill {
    return Intl.message(
      'You have successfully established your company, but it is still inactive.',
      name: 'youHaveSuccessfullyEstablishedYourCompanyButItIsStill',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Requirement`
  String get unlockRequirement {
    return Intl.message(
      'Unlock Requirement',
      name: 'unlockRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Buy Assets`
  String get buyAssets {
    return Intl.message(
      'Buy Assets',
      name: 'buyAssets',
      desc: '',
      args: [],
    );
  }

  /// `Unlock your company and enter the game world 🚀`
  String get unlockYourCompanyAndEnterTheGameWorld {
    return Intl.message(
      'Unlock your company and enter the game world 🚀',
      name: 'unlockYourCompanyAndEnterTheGameWorld',
      desc: '',
      args: [],
    );
  }

  /// `Founder`
  String get founder {
    return Intl.message(
      'Founder',
      name: 'founder',
      desc: '',
      args: [],
    );
  }

  /// `My Company`
  String get myCompany {
    return Intl.message(
      'My Company',
      name: 'myCompany',
      desc: '',
      args: [],
    );
  }

  /// `Your company has been created successfully.`
  String get yourCompanyHasBeenCreatedSuccessfully {
    return Intl.message(
      'Your company has been created successfully.',
      name: 'yourCompanyHasBeenCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Unable to create the company. Please try again.`
  String get unableToCreateTheCompanyPleaseTryAgain {
    return Intl.message(
      'Unable to create the company. Please try again.',
      name: 'unableToCreateTheCompanyPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while creating the company. Please try again.`
  String get somethingWentWrongWhileCreatingTheCompanyPleaseTryAgain {
    return Intl.message(
      'Something went wrong while creating the company. Please try again.',
      name: 'somethingWentWrongWhileCreatingTheCompanyPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load company information.`
  String get failedToLoadCompanyInformation {
    return Intl.message(
      'Failed to load company information.',
      name: 'failedToLoadCompanyInformation',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `No company found yet`
  String get noCompanyFoundYet {
    return Intl.message(
      'No company found yet',
      name: 'noCompanyFoundYet',
      desc: '',
      args: [],
    );
  }

  /// `Your company profile will appear here once it is created.`
  String get yourCompanyProfileWillAppearHereOnceItIsCreated {
    return Intl.message(
      'Your company profile will appear here once it is created.',
      name: 'yourCompanyProfileWillAppearHereOnceItIsCreated',
      desc: '',
      args: [],
    );
  }

  /// `Not provided`
  String get notProvided {
    return Intl.message(
      'Not provided',
      name: 'notProvided',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Created At`
  String get createdAt {
    return Intl.message(
      'Created At',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Your company profile in one place`
  String get yourCompanyProfileInOnePlace {
    return Intl.message(
      'Your company profile in one place',
      name: 'yourCompanyProfileInOnePlace',
      desc: '',
      args: [],
    );
  }

  /// `Company Not Found`
  String get companyNotFound {
    return Intl.message(
      'Company Not Found',
      name: 'companyNotFound',
      desc: '',
      args: [],
    );
  }

  /// `No company is linked to your account. Please contact support or try again later.`
  String get noCompanyIsLinkedToYourAccountPleaseContactSupport {
    return Intl.message(
      'No company is linked to your account. Please contact support or try again later.',
      name: 'noCompanyIsLinkedToYourAccountPleaseContactSupport',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Successful`
  String get purchaseSuccessful {
    return Intl.message(
      'Purchase Successful',
      name: 'purchaseSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `The asset has been purchased successfully.`
  String get theAssetHasBeenPurchasedSuccessfully {
    return Intl.message(
      'The asset has been purchased successfully.',
      name: 'theAssetHasBeenPurchasedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Failed`
  String get purchaseFailed {
    return Intl.message(
      'Purchase Failed',
      name: 'purchaseFailed',
      desc: '',
      args: [],
    );
  }

  /// `We were unable to complete your purchase. Please try again.`
  String get weWereUnableToCompleteYourPurchasePleaseTryAgain {
    return Intl.message(
      'We were unable to complete your purchase. Please try again.',
      name: 'weWereUnableToCompleteYourPurchasePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Request Failed`
  String get requestFailed {
    return Intl.message(
      'Request Failed',
      name: 'requestFailed',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while processing your request. Please try again later.`
  String get somethingWentWrongWhileProcessingYourRequestPleaseTryAgain {
    return Intl.message(
      'Something went wrong while processing your request. Please try again later.',
      name: 'somethingWentWrongWhileProcessingYourRequestPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Error`
  String get unexpectedError {
    return Intl.message(
      'Unexpected Error',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred while buying the asset. Please try again.`
  String get anUnexpectedErrorOccurredWhileBuyingTheAssetPleaseTry {
    return Intl.message(
      'An unexpected error occurred while buying the asset. Please try again.',
      name: 'anUnexpectedErrorOccurredWhileBuyingTheAssetPleaseTry',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Available:`
  String get available {
    return Intl.message(
      'Available:',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Total:`
  String get total {
    return Intl.message(
      'Total:',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `{value} pts`
  String points(Object value) {
    return Intl.message(
      '$value pts',
      name: 'points',
      desc: '',
      args: [value],
    );
  }

  /// `Continue`
  String get continuePress {
    return Intl.message(
      'Continue',
      name: 'continuePress',
      desc: '',
      args: [],
    );
  }

  /// `Max available is {count}`
  String maxAvailable(Object count) {
    return Intl.message(
      'Max available is $count',
      name: 'maxAvailable',
      desc: '',
      args: [count],
    );
  }

  /// `Select quantity to purchase`
  String get selectQuantityToPurchase {
    return Intl.message(
      'Select quantity to purchase',
      name: 'selectQuantityToPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Your purchase has been completed successfully. The asset has been added to your portfolio.`
  String get purchaseCompletedDesc {
    return Intl.message(
      'Your purchase has been completed successfully. The asset has been added to your portfolio.',
      name: 'purchaseCompletedDesc',
      desc: '',
      args: [],
    );
  }

  /// `{count} available`
  String availableCopies(Object count) {
    return Intl.message(
      '$count available',
      name: 'availableCopies',
      desc: '',
      args: [count],
    );
  }

  /// `{count} left (hurry!)`
  String leftCopies(Object count) {
    return Intl.message(
      '$count left (hurry!)',
      name: 'leftCopies',
      desc: '',
      args: [count],
    );
  }

  /// `TOP PLAYERS`
  String get topPlayers {
    return Intl.message(
      'TOP PLAYERS',
      name: 'topPlayers',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get thisWeek {
    return Intl.message(
      'This Week',
      name: 'thisWeek',
      desc: '',
      args: [],
    );
  }

  /// `This Month`
  String get thisMonth {
    return Intl.message(
      'This Month',
      name: 'thisMonth',
      desc: '',
      args: [],
    );
  }

  /// `All Time`
  String get allTime {
    return Intl.message(
      'All Time',
      name: 'allTime',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while loading the leaderboard. Please try again.`
  String get somethingWentWrongWhileLoadingTheLeaderboardPleaseTryAgain {
    return Intl.message(
      'Something went wrong while loading the leaderboard. Please try again.',
      name: 'somethingWentWrongWhileLoadingTheLeaderboardPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `No players found for the selected period.`
  String get noPlayersFoundForTheSelectedPeriod {
    return Intl.message(
      'No players found for the selected period.',
      name: 'noPlayersFoundForTheSelectedPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient Balance`
  String get insufficientBalance {
    return Intl.message(
      'Insufficient Balance',
      name: 'insufficientBalance',
      desc: '',
      args: [],
    );
  }

  /// `Your current balance is not enough to complete this purchase. Please top up your balance and try again.`
  String get yourCurrentBalanceIsNotEnoughToCompleteThisPurchase {
    return Intl.message(
      'Your current balance is not enough to complete this purchase. Please top up your balance and try again.',
      name: 'yourCurrentBalanceIsNotEnoughToCompleteThisPurchase',
      desc: '',
      args: [],
    );
  }

  /// `Top Up Your Balance`
  String get topUpYourBalance {
    return Intl.message(
      'Top Up Your Balance',
      name: 'topUpYourBalance',
      desc: '',
      args: [],
    );
  }

  /// `Error loading balance value`
  String get errorLoadingBalanceValue {
    return Intl.message(
      'Error loading balance value',
      name: 'errorLoadingBalanceValue',
      desc: '',
      args: [],
    );
  }

  /// `Your balance has been successfully topped up.`
  String get yourBalanceHasBeenSuccessfullyToppedUp {
    return Intl.message(
      'Your balance has been successfully topped up.',
      name: 'yourBalanceHasBeenSuccessfullyToppedUp',
      desc: '',
      args: [],
    );
  }

  /// `Failed to top up balance. Please try again later.`
  String get failedToTopUpBalancePleaseTryAgainLater {
    return Intl.message(
      'Failed to top up balance. Please try again later.',
      name: 'failedToTopUpBalancePleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an amount of at least 1 to proceed.`
  String get pleaseEnterAnAmountOfAtLeast1ToProceed {
    return Intl.message(
      'Please enter an amount of at least 1 to proceed.',
      name: 'pleaseEnterAnAmountOfAtLeast1ToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Total Balance`
  String get totalBalance {
    return Intl.message(
      'Total Balance',
      name: 'totalBalance',
      desc: '',
      args: [],
    );
  }

  /// `Available to top up instantly`
  String get availableToTopUpInstantly {
    return Intl.message(
      'Available to top up instantly',
      name: 'availableToTopUpInstantly',
      desc: '',
      args: [],
    );
  }

  /// `Hide Top Up`
  String get hideTopUp {
    return Intl.message(
      'Hide Top Up',
      name: 'hideTopUp',
      desc: '',
      args: [],
    );
  }

  /// `Top Up`
  String get topUp {
    return Intl.message(
      'Top Up',
      name: 'topUp',
      desc: '',
      args: [],
    );
  }

  /// `Enter Amount`
  String get enterAmount {
    return Intl.message(
      'Enter Amount',
      name: 'enterAmount',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Apple Pay`
  String get applePay {
    return Intl.message(
      'Apple Pay',
      name: 'applePay',
      desc: '',
      args: [],
    );
  }

  /// `Fast and secure payment`
  String get fastAndSecurePayment {
    return Intl.message(
      'Fast and secure payment',
      name: 'fastAndSecurePayment',
      desc: '',
      args: [],
    );
  }

  /// `Visa`
  String get visa {
    return Intl.message(
      'Visa',
      name: 'visa',
      desc: '',
      args: [],
    );
  }

  /// `Pay with your card`
  String get payWithYourCard {
    return Intl.message(
      'Pay with your card',
      name: 'payWithYourCard',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Top Up`
  String get confirmTopUp {
    return Intl.message(
      'Confirm Top Up',
      name: 'confirmTopUp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an amount.`
  String get pleaseEnterAnAmount {
    return Intl.message(
      'Please enter an amount.',
      name: 'pleaseEnterAnAmount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid amount greater than 0.`
  String get pleaseEnterAValidAmountGreaterThan0 {
    return Intl.message(
      'Please enter a valid amount greater than 0.',
      name: 'pleaseEnterAValidAmountGreaterThan0',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Asset`
  String get purchaseAsset {
    return Intl.message(
      'Purchase Asset',
      name: 'purchaseAsset',
      desc: '',
      args: [],
    );
  }

  /// `Asset Name`
  String get assetName {
    return Intl.message(
      'Asset Name',
      name: 'assetName',
      desc: '',
      args: [],
    );
  }

  /// `Price Per Copy`
  String get pricePerCopy {
    return Intl.message(
      'Price Per Copy',
      name: 'pricePerCopy',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPriceCon {
    return Intl.message(
      'Total Price',
      name: 'totalPriceCon',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to buy {quantity} copy/copies of {assetName} for \${totalPrice}?\n\nAfter confirmation, the amount will be deducted instantly and the asset will be added to your portfolio.`
  String confirmPurchaseMessage(
      Object quantity, Object assetName, Object totalPrice) {
    return Intl.message(
      'Are you sure you want to buy $quantity copy/copies of $assetName for \\\$$totalPrice?\n\nAfter confirmation, the amount will be deducted instantly and the asset will be added to your portfolio.',
      name: 'confirmPurchaseMessage',
      desc: '',
      args: [quantity, assetName, totalPrice],
    );
  }

  /// `Sell More`
  String get sellMore {
    return Intl.message(
      'Sell More',
      name: 'sellMore',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Sale`
  String get cancelSale {
    return Intl.message(
      'Cancel Sale',
      name: 'cancelSale',
      desc: '',
      args: [],
    );
  }

  /// `You can cancel the sale at any time.`
  String get youCanCancelTheSaleAtAnyTime {
    return Intl.message(
      'You can cancel the sale at any time.',
      name: 'youCanCancelTheSaleAtAnyTime',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cancel the active sale for this asset?`
  String get doYouWantToCancelTheActiveSaleForThis {
    return Intl.message(
      'Do you want to cancel the active sale for this asset?',
      name: 'doYouWantToCancelTheActiveSaleForThis',
      desc: '',
      args: [],
    );
  }

  /// `Keep Sale`
  String get keepSale {
    return Intl.message(
      'Keep Sale',
      name: 'keepSale',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Cancel`
  String get confirmCancel {
    return Intl.message(
      'Confirm Cancel',
      name: 'confirmCancel',
      desc: '',
      args: [],
    );
  }

  /// `Invalid price`
  String get invalidPrice {
    return Intl.message(
      'Invalid price',
      name: 'invalidPrice',
      desc: '',
      args: [],
    );
  }

  /// `Price must be at least 1`
  String get priceMustBeAtLeast1 {
    return Intl.message(
      'Price must be at least 1',
      name: 'priceMustBeAtLeast1',
      desc: '',
      args: [],
    );
  }

  /// `Available to sell: {count}`
  String availableToSell(Object count) {
    return Intl.message(
      'Available to sell: $count',
      name: 'availableToSell',
      desc: '',
      args: [count],
    );
  }

  /// `{count} copies currently on sale`
  String copiesOnSale(Object count) {
    return Intl.message(
      '$count copies currently on sale',
      name: 'copiesOnSale',
      desc: '',
      args: [count],
    );
  }

  /// `On sale: {count}`
  String onSaleLabel(Object count) {
    return Intl.message(
      'On sale: $count',
      name: 'onSaleLabel',
      desc: '',
      args: [count],
    );
  }

  /// `Available: {count}`
  String availableLabel(Object count) {
    return Intl.message(
      'Available: $count',
      name: 'availableLabel',
      desc: '',
      args: [count],
    );
  }

  /// `{count} copies are currently listed for sale.`
  String copiesListedForSale(Object count) {
    return Intl.message(
      '$count copies are currently listed for sale.',
      name: 'copiesListedForSale',
      desc: '',
      args: [count],
    );
  }

  /// `Available copies to list: {count}`
  String availableCopiesToList(Object count) {
    return Intl.message(
      'Available copies to list: $count',
      name: 'availableCopiesToList',
      desc: '',
      args: [count],
    );
  }

  /// `Failed to load transactions`
  String get failedToLoadTransactions {
    return Intl.message(
      'Failed to load transactions',
      name: 'failedToLoadTransactions',
      desc: '',
      args: [],
    );
  }

  /// `No transactions yet`
  String get noTransactionsYet {
    return Intl.message(
      'No transactions yet',
      name: 'noTransactionsYet',
      desc: '',
      args: [],
    );
  }

  /// `Your completed purchases will appear here once available.`
  String get yourCompletedPurchasesWillAppearHereOnceAvailable {
    return Intl.message(
      'Your completed purchases will appear here once available.',
      name: 'yourCompletedPurchasesWillAppearHereOnceAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Sale cancelled successfully.\nYour asset is now back in your portfolio.`
  String get saleCancelledSuccessfullynyourAssetIsNowBackInYourPortfolio {
    return Intl.message(
      'Sale cancelled successfully.\nYour asset is now back in your portfolio.',
      name: 'saleCancelledSuccessfullynyourAssetIsNowBackInYourPortfolio',
      desc: '',
      args: [],
    );
  }

  /// `This listing is currently active in the marketplace.`
  String get thisListingIsCurrentlyActiveInTheMarketplace {
    return Intl.message(
      'This listing is currently active in the marketplace.',
      name: 'thisListingIsCurrentlyActiveInTheMarketplace',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to cancel the sale for this asset? This action will remove it from the marketplace.`
  String get doYouWantToCancelTheSaleForThisAsset {
    return Intl.message(
      'Do you want to cancel the sale for this asset? This action will remove it from the marketplace.',
      name: 'doYouWantToCancelTheSaleForThisAsset',
      desc: '',
      args: [],
    );
  }

  /// `Explore Assets 🌍`
  String get exploreAssets {
    return Intl.message(
      'Explore Assets 🌍',
      name: 'exploreAssets',
      desc: '',
      args: [],
    );
  }

  /// `My Assets 🏠`
  String get myAssets {
    return Intl.message(
      'My Assets 🏠',
      name: 'myAssets',
      desc: '',
      args: [],
    );
  }

  /// `You can cancel this sale before another player buys it.`
  String get youCanCancelThisSaleBeforeAnotherPlayerBuysIt {
    return Intl.message(
      'You can cancel this sale before another player buys it.',
      name: 'youCanCancelThisSaleBeforeAnotherPlayerBuysIt',
      desc: '',
      args: [],
    );
  }

  /// `Once cancelled, this asset will return to your portfolio.`
  String get onceCancelledThisAssetWillReturnToYourPortfolio {
    return Intl.message(
      'Once cancelled, this asset will return to your portfolio.',
      name: 'onceCancelledThisAssetWillReturnToYourPortfolio',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{No units are currently listed in the market.} =1{{count} unit is currently listed in the market.} other{{count} units are currently listed in the market.}}`
  String unitsListedInMarket(int count) {
    return Intl.plural(
      count,
      zero: 'No units are currently listed in the market.',
      one: '$count unit is currently listed in the market.',
      other: '$count units are currently listed in the market.',
      name: 'unitsListedInMarket',
      desc: 'Number of units listed in the market',
      args: [count],
    );
  }

  /// `Go to Marketplace`
  String get goToMarketplace {
    return Intl.message(
      'Go to Marketplace',
      name: 'goToMarketplace',
      desc: '',
      args: [],
    );
  }

  /// `By: {name}`
  String byUser(Object name) {
    return Intl.message(
      'By: $name',
      name: 'byUser',
      desc: '',
      args: [name],
    );
  }

  /// `{type} • {count, plural, =0 {0 copies} =1 {1 copy} other {{count} copies}}`
  String transactionCopies(Object type, num count) {
    return Intl.message(
      '$type • ${Intl.plural(count, zero: '0 copies', one: '1 copy', other: '$count copies')}',
      name: 'transactionCopies',
      desc: '',
      args: [type, count],
    );
  }

  /// `Unable to load transaction history.`
  String get unableToLoadTransactionHistory {
    return Intl.message(
      'Unable to load transaction history.',
      name: 'unableToLoadTransactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get somethingWentWrongPleaseTryAgainLater {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'somethingWentWrongPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Balance History`
  String get balanceHistory {
    return Intl.message(
      'Balance History',
      name: 'balanceHistory',
      desc: '',
      args: [],
    );
  }

  /// `No balance history available right now.`
  String get noBalanceHistoryAvailable {
    return Intl.message(
      'No balance history available right now.',
      name: 'noBalanceHistoryAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Credit Transaction`
  String get creditTransaction {
    return Intl.message(
      'Credit Transaction',
      name: 'creditTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Debit Transaction`
  String get debitTransaction {
    return Intl.message(
      'Debit Transaction',
      name: 'debitTransaction',
      desc: '',
      args: [],
    );
  }

  /// `Transaction Type`
  String get transactionType {
    return Intl.message(
      'Transaction Type',
      name: 'transactionType',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Debit`
  String get debit {
    return Intl.message(
      'Debit',
      name: 'debit',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get orderId {
    return Intl.message(
      'Order ID',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Balance top up`
  String get chargeUserBalance {
    return Intl.message(
      'Balance top up',
      name: 'chargeUserBalance',
      desc: '',
      args: [],
    );
  }

  /// `Asset purchased`
  String get assetBought {
    return Intl.message(
      'Asset purchased',
      name: 'assetBought',
      desc: '',
      args: [],
    );
  }

  /// `Asset sold`
  String get assetSold {
    return Intl.message(
      'Asset sold',
      name: 'assetSold',
      desc: '',
      args: [],
    );
  }

  /// `AM`
  String get am {
    return Intl.message(
      'AM',
      name: 'am',
      desc: '',
      args: [],
    );
  }

  /// `PM`
  String get pm {
    return Intl.message(
      'PM',
      name: 'pm',
      desc: '',
      args: [],
    );
  }

  /// `To activate your company and start playing, you need to purchase assets worth at least {value}.`
  String unlockRequirementText(Object value) {
    return Intl.message(
      'To activate your company and start playing, you need to purchase assets worth at least $value.',
      name: 'unlockRequirementText',
      desc: '',
      args: [value],
    );
  }

  /// `You don’t have any assets listed for sale in the market.`
  String get youDontHaveAnyAssetsListedForSaleInThe {
    return Intl.message(
      'You don’t have any assets listed for sale in the market.',
      name: 'youDontHaveAnyAssetsListedForSaleInThe',
      desc: '',
      args: [],
    );
  }

  /// `Buy Offer`
  String get buyOffer {
    return Intl.message(
      'Buy Offer',
      name: 'buyOffer',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get continueAsGuest {
    return Intl.message(
      'Continue as Guest',
      name: 'continueAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Log in to view your balance 💰`
  String get logInToViewYourBalance {
    return Intl.message(
      'Log in to view your balance 💰',
      name: 'logInToViewYourBalance',
      desc: '',
      args: [],
    );
  }

  /// `Log in to view your portfolio 📊`
  String get logInToViewYourPortfolio {
    return Intl.message(
      'Log in to view your portfolio 📊',
      name: 'logInToViewYourPortfolio',
      desc: '',
      args: [],
    );
  }

  /// `Start Your Investment Journey 🚀`
  String get startYourInvestmentJourney {
    return Intl.message(
      'Start Your Investment Journey 🚀',
      name: 'startYourInvestmentJourney',
      desc: '',
      args: [],
    );
  }

  /// `Log in or sign up to unlock your balance, build your portfolio, and start growing your wealth!`
  String get logInOrSignUpToUnlockYourBalanceBuild {
    return Intl.message(
      'Log in or sign up to unlock your balance, build your portfolio, and start growing your wealth!',
      name: 'logInOrSignUpToUnlockYourBalanceBuild',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Members Only 🔒`
  String get membersOnly {
    return Intl.message(
      'Members Only 🔒',
      name: 'membersOnly',
      desc: '',
      args: [],
    );
  }

  /// `Log in or sign up to access your portfolio and start growing your wealth 🚀`
  String get logInOrSignUpToAccessYourPortfolioAnd {
    return Intl.message(
      'Log in or sign up to access your portfolio and start growing your wealth 🚀',
      name: 'logInOrSignUpToAccessYourPortfolioAnd',
      desc: '',
      args: [],
    );
  }

  /// `Company Access Locked 🔒`
  String get companyAccessLocked {
    return Intl.message(
      'Company Access Locked 🔒',
      name: 'companyAccessLocked',
      desc: '',
      args: [],
    );
  }

  /// `Log in or sign up to create and manage your company, grow your investments, and unlock new opportunities 🚀`
  String get logInOrSignUpToCreateAndManageYour {
    return Intl.message(
      'Log in or sign up to create and manage your company, grow your investments, and unlock new opportunities 🚀',
      name: 'logInOrSignUpToCreateAndManageYour',
      desc: '',
      args: [],
    );
  }

  /// `Search Country`
  String get searchCountry {
    return Intl.message(
      'Search Country',
      name: 'searchCountry',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email and password and try again.`
  String get invalidLoginCredentials {
    return Intl.message(
      'Please check your email and password and try again.',
      name: 'invalidLoginCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load categories right now. Please try again later.`
  String get unableToLoadCategoriesRightNowPleaseTryAgainLater {
    return Intl.message(
      'Unable to load categories right now. Please try again later.',
      name: 'unableToLoadCategoriesRightNowPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `No categories available at the moment.`
  String get noCategoriesAvailableAtTheMoment {
    return Intl.message(
      'No categories available at the moment.',
      name: 'noCategoriesAvailableAtTheMoment',
      desc: '',
      args: [],
    );
  }

  /// `This email is not registered in the app.`
  String get thisEmailIsNotRegisteredInTheApp {
    return Intl.message(
      'This email is not registered in the app.',
      name: 'thisEmailIsNotRegisteredInTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Activate your company and jump into the game world.`
  String get activateYourCompanyAndJumpIntoTheGameWorld {
    return Intl.message(
      'Activate your company and jump into the game world.',
      name: 'activateYourCompanyAndJumpIntoTheGameWorld',
      desc: '',
      args: [],
    );
  }

  /// `Get your assets, unlock your company, and start your journey.`
  String get getYourAssetsUnlockYourCompanyAndStartYourJourney {
    return Intl.message(
      'Get your assets, unlock your company, and start your journey.',
      name: 'getYourAssetsUnlockYourCompanyAndStartYourJourney',
      desc: '',
      args: [],
    );
  }

  /// `Start Playing & Buy Assets`
  String get startPlayingBuyAssets {
    return Intl.message(
      'Start Playing & Buy Assets',
      name: 'startPlayingBuyAssets',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your company name`
  String get pleaseEnterCompanyName {
    return Intl.message(
      'Please enter your company name',
      name: 'pleaseEnterCompanyName',
      desc: '',
      args: [],
    );
  }

  /// `Company name must be at least 3 characters`
  String get companyNameTooShort {
    return Intl.message(
      'Company name must be at least 3 characters',
      name: 'companyNameTooShort',
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
