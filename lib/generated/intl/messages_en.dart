// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "${count} available";

  static String m1(count) => "Available copies to list: ${count}";

  static String m2(count) => "Available: ${count}";

  static String m3(count) => "Available to sell: ${count}";

  static String m4(name) => "By: ${name}";

  static String m5(quantity, assetName, totalPrice) =>
      "Are you sure you want to buy ${quantity} copy/copies of ${assetName} for \\\$${totalPrice}?\n\nAfter confirmation, the amount will be deducted instantly and the asset will be added to your portfolio.";

  static String m6(count) => "${count} copies are currently listed for sale.";

  static String m7(count) => "${count} copies currently on sale";

  static String m8(count) => "${count} left (hurry!)";

  static String m9(name) => "List ${name} for Sale";

  static String m10(date) => "Listed on: ${date}";

  static String m11(count) => "Max available is ${count}";

  static String m12(count) => "On sale: ${count}";

  static String m13(count) => "Owned: ${count} copies";

  static String m14(value) => "${value} pts";

  static String m15(count) =>
      "You only have ${count} copies. Please adjust the quantity.";

  static String m16(total) => "Total: ${total}";

  static String m17(type, count) =>
      "${type} • ${Intl.plural(count, zero: '0 copies', one: '1 copy', other: '${count} copies')}";

  static String m18(type) => "Type: ${type}";

  static String m19(price) => "Unit Price: ${price}";

  static String m20(count) =>
      "${Intl.plural(count, zero: 'No units are currently listed in the market.', one: '${count} unit is currently listed in the market.', other: '${count} units are currently listed in the market.')}";

  static String m21(value) =>
      "To activate your company and start playing, you need to purchase assets worth at least ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activateYourCompanyAndJumpIntoTheGameWorld":
            MessageLookupByLibrary.simpleMessage(
                "Activate your company and jump into the game world."),
        "active": MessageLookupByLibrary.simpleMessage("Active"),
        "addLogo": MessageLookupByLibrary.simpleMessage("Add Logo"),
        "address": MessageLookupByLibrary.simpleMessage("Address"),
        "all": MessageLookupByLibrary.simpleMessage("all"),
        "allTime": MessageLookupByLibrary.simpleMessage("All Time"),
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "am": MessageLookupByLibrary.simpleMessage("AM"),
        "anUnexpectedErrorOccurredWhileBuyingTheAssetPleaseTry":
            MessageLookupByLibrary.simpleMessage(
                "An unexpected error occurred while buying the asset. Please try again."),
        "and": MessageLookupByLibrary.simpleMessage("and"),
        "applePay": MessageLookupByLibrary.simpleMessage("Apple Pay"),
        "apply": MessageLookupByLibrary.simpleMessage("Apply"),
        "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
        "areYouSureYouWantToDeleteYourAccountThis":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to delete your account? This action cannot be undone."),
        "areYouSureYouWantToLogoutFromYourAccount":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to logout from your account?"),
        "ascending": MessageLookupByLibrary.simpleMessage("Ascending"),
        "assetBought": MessageLookupByLibrary.simpleMessage("Asset purchased"),
        "assetName": MessageLookupByLibrary.simpleMessage("Asset Name"),
        "assetSold": MessageLookupByLibrary.simpleMessage("Asset sold"),
        "assetType": MessageLookupByLibrary.simpleMessage("Asset Type"),
        "available": MessageLookupByLibrary.simpleMessage("Available:"),
        "availableCopies": m0,
        "availableCopiesToList": m1,
        "availableLabel": m2,
        "availableToSell": m3,
        "availableToTopUpInstantly": MessageLookupByLibrary.simpleMessage(
            "Available to top up instantly"),
        "balance": MessageLookupByLibrary.simpleMessage("Balance"),
        "balanceHistory":
            MessageLookupByLibrary.simpleMessage("Balance History"),
        "buildYourCompany":
            MessageLookupByLibrary.simpleMessage("BUILD YOUR COMPANY"),
        "buy": MessageLookupByLibrary.simpleMessage("BUY"),
        "buyAssets": MessageLookupByLibrary.simpleMessage("Buy Assets"),
        "buyConfirmationMessage": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to buy this asset?\n\nThe price will be deducted from your balance and the asset will be added to your portfolio immediately."),
        "buyNow": MessageLookupByLibrary.simpleMessage("BUY NOW"),
        "buyOffer": MessageLookupByLibrary.simpleMessage("Buy Offer"),
        "bySigningUpYouAgreeToOur": MessageLookupByLibrary.simpleMessage(
            "By signing up, you agree to our"),
        "byUser": m4,
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cancelSale": MessageLookupByLibrary.simpleMessage("Cancel Sale"),
        "category": MessageLookupByLibrary.simpleMessage("Category"),
        "categoryDot": MessageLookupByLibrary.simpleMessage("Category: "),
        "changeLanguage":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "changeYourPassword":
            MessageLookupByLibrary.simpleMessage("Change Your Password"),
        "chargeUserBalance":
            MessageLookupByLibrary.simpleMessage("Balance top up"),
        "code": MessageLookupByLibrary.simpleMessage("Code:"),
        "companyAccessLocked":
            MessageLookupByLibrary.simpleMessage("Company Access Locked 🔒"),
        "companyCreatedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Company Created Successfully 🎉"),
        "companyName": MessageLookupByLibrary.simpleMessage("Company Name"),
        "companyNameTooShort": MessageLookupByLibrary.simpleMessage(
            "Company name must be at least 3 characters"),
        "companyNotFound":
            MessageLookupByLibrary.simpleMessage("Company Not Found"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmCancel": MessageLookupByLibrary.simpleMessage("Confirm Cancel"),
        "confirmDeletion":
            MessageLookupByLibrary.simpleMessage("Confirm Deletion"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "confirmPurchase":
            MessageLookupByLibrary.simpleMessage("Confirm Purchase"),
        "confirmPurchaseMessage": m5,
        "confirmTopUp": MessageLookupByLibrary.simpleMessage("Confirm Top Up"),
        "contactUs": MessageLookupByLibrary.simpleMessage("Contact Us"),
        "continueAsGuest":
            MessageLookupByLibrary.simpleMessage("Continue as Guest"),
        "continuePress": MessageLookupByLibrary.simpleMessage("Continue"),
        "copiesListedForSale": m6,
        "copiesOnSale": m7,
        "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
        "createdAt": MessageLookupByLibrary.simpleMessage("Created At"),
        "credit": MessageLookupByLibrary.simpleMessage("Credit"),
        "creditTransaction":
            MessageLookupByLibrary.simpleMessage("Credit Transaction"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "debit": MessageLookupByLibrary.simpleMessage("Debit"),
        "debitTransaction":
            MessageLookupByLibrary.simpleMessage("Debit Transaction"),
        "deleteMyAccount":
            MessageLookupByLibrary.simpleMessage("Delete My Account"),
        "descending": MessageLookupByLibrary.simpleMessage("Descending"),
        "describeWhatMakesYourCompanyUniqueAndPowerful":
            MessageLookupByLibrary.simpleMessage(
                "Describe what makes your company unique and powerful..."),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "discoverRareAssetsFromOtherPlayersSendAPurchaseRequest":
            MessageLookupByLibrary.simpleMessage(
                "Discover rare assets from other players! Send a purchase request after seller confirmation."),
        "doYouWantToCancelTheActiveSaleForThis":
            MessageLookupByLibrary.simpleMessage(
                "Do you want to cancel the active sale for this asset?"),
        "doYouWantToCancelTheSaleForThisAsset":
            MessageLookupByLibrary.simpleMessage(
                "Do you want to cancel the sale for this asset? This action will remove it from the marketplace."),
        "dontHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "enjoyThisLimitedtimeSpecialOfferOnSelectedAssets":
            MessageLookupByLibrary.simpleMessage(
                "Enjoy this limited-time special offer on selected assets."),
        "enterAmount": MessageLookupByLibrary.simpleMessage("Enter Amount"),
        "enterCompanyName":
            MessageLookupByLibrary.simpleMessage("Enter company name"),
        "enterYourEmailToResetYourPassword":
            MessageLookupByLibrary.simpleMessage(
                "Enter your email to reset your password."),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "errorLoadingBalanceValue":
            MessageLookupByLibrary.simpleMessage("Error loading balance value"),
        "errorLoadingData":
            MessageLookupByLibrary.simpleMessage("Error loading data"),
        "errorLoadingPortfolioValue": MessageLookupByLibrary.simpleMessage(
            "Error loading portfolio value"),
        "expiresOn": MessageLookupByLibrary.simpleMessage("Expires on:"),
        "exploreAssets":
            MessageLookupByLibrary.simpleMessage("Explore Assets 🌍"),
        "failedToFetchProfileData": MessageLookupByLibrary.simpleMessage(
            "Failed to fetch profile data"),
        "failedToLoadCompanyInformation": MessageLookupByLibrary.simpleMessage(
            "Failed to load company information."),
        "failedToLoadTransactions":
            MessageLookupByLibrary.simpleMessage("Failed to load transactions"),
        "failedToResetPassword":
            MessageLookupByLibrary.simpleMessage("Failed to reset password"),
        "failedToTopUpBalancePleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "Failed to top up balance. Please try again later."),
        "fastAndSecurePayment":
            MessageLookupByLibrary.simpleMessage("Fast and secure payment"),
        "filter": MessageLookupByLibrary.simpleMessage("Filter"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "forgotPasswordL":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "founder": MessageLookupByLibrary.simpleMessage("Founder"),
        "founderName": MessageLookupByLibrary.simpleMessage("Founder Name"),
        "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
        "getStarted": MessageLookupByLibrary.simpleMessage("Get Started"),
        "getYourAssetsUnlockYourCompanyAndStartYourJourney":
            MessageLookupByLibrary.simpleMessage(
                "Get your assets, unlock your company, and start your journey."),
        "goBackTo": MessageLookupByLibrary.simpleMessage("Go Back To"),
        "goToMarketplace":
            MessageLookupByLibrary.simpleMessage("Go to Marketplace"),
        "great": MessageLookupByLibrary.simpleMessage("Great"),
        "growthRate": MessageLookupByLibrary.simpleMessage("Growth Rate"),
        "hideTopUp": MessageLookupByLibrary.simpleMessage("Hide Top Up"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "includedAssets":
            MessageLookupByLibrary.simpleMessage("Included Assets"),
        "insufficientBalance":
            MessageLookupByLibrary.simpleMessage("Insufficient Balance"),
        "invalidLoginCredentials": MessageLookupByLibrary.simpleMessage(
            "Please check your email and password and try again."),
        "invalidPrice": MessageLookupByLibrary.simpleMessage("Invalid price"),
        "invalidQuantity":
            MessageLookupByLibrary.simpleMessage("Invalid Quantity"),
        "keepSale": MessageLookupByLibrary.simpleMessage("Keep Sale"),
        "launchCompany":
            MessageLookupByLibrary.simpleMessage("Launch Company 🚀"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("LEADERBOARD"),
        "leftCopies": m8,
        "listForSale": m9,
        "listedOn": m10,
        "logIn": MessageLookupByLibrary.simpleMessage("Log In"),
        "logInOrSignUpToAccessYourPortfolioAnd":
            MessageLookupByLibrary.simpleMessage(
                "Log in or sign up to access your portfolio and start growing your wealth 🚀"),
        "logInOrSignUpToCreateAndManageYour": MessageLookupByLibrary.simpleMessage(
            "Log in or sign up to create and manage your company, grow your investments, and unlock new opportunities 🚀"),
        "logInOrSignUpToUnlockYourBalanceBuild":
            MessageLookupByLibrary.simpleMessage(
                "Log in or sign up to unlock your balance, build your portfolio, and start growing your wealth!"),
        "logInToViewYourBalance": MessageLookupByLibrary.simpleMessage(
            "Log in to view your balance 💰"),
        "logInToViewYourPortfolio": MessageLookupByLibrary.simpleMessage(
            "Log in to view your portfolio 📊"),
        "logOut": MessageLookupByLibrary.simpleMessage("Log Out"),
        "logout": MessageLookupByLibrary.simpleMessage("Logout"),
        "market": MessageLookupByLibrary.simpleMessage("Market"),
        "marketPlace": MessageLookupByLibrary.simpleMessage("MARKETPLACE"),
        "marketPlaceH": MessageLookupByLibrary.simpleMessage("Marketplace"),
        "marketS": MessageLookupByLibrary.simpleMessage("MARKET"),
        "maxAvailable": m11,
        "membersOnly": MessageLookupByLibrary.simpleMessage("Members Only 🔒"),
        "myAssets": MessageLookupByLibrary.simpleMessage("My Assets 🏠"),
        "myCompany": MessageLookupByLibrary.simpleMessage("My Company"),
        "myProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
        "no": MessageLookupByLibrary.simpleMessage("NO"),
        "noBalanceHistoryAvailable": MessageLookupByLibrary.simpleMessage(
            "No balance history available right now."),
        "noCategoriesAvailableAtTheMoment":
            MessageLookupByLibrary.simpleMessage(
                "No categories available at the moment."),
        "noCompanyFoundYet":
            MessageLookupByLibrary.simpleMessage("No company found yet"),
        "noCompanyIsLinkedToYourAccountPleaseContactSupport":
            MessageLookupByLibrary.simpleMessage(
                "No company is linked to your account. Please contact support or try again later."),
        "noContactInformationIsAvailableAtTheMoment":
            MessageLookupByLibrary.simpleMessage(
                "No contact information is available at the moment."),
        "noMarketItemsFound":
            MessageLookupByLibrary.simpleMessage("No market items found"),
        "noNotificationsYet":
            MessageLookupByLibrary.simpleMessage("No notifications yet."),
        "noPlayersFoundForTheSelectedPeriod":
            MessageLookupByLibrary.simpleMessage(
                "No players found for the selected period."),
        "noPortfolioDataFound":
            MessageLookupByLibrary.simpleMessage("No portfolio data found"),
        "noPrivacyPolicyIsAvailableAtTheMoment":
            MessageLookupByLibrary.simpleMessage(
                "No privacy policy is available at the moment."),
        "noSpecialOffersAreAvailableRightNow":
            MessageLookupByLibrary.simpleMessage(
                "No special offers are available right now."),
        "noTransactionsYet":
            MessageLookupByLibrary.simpleMessage("No transactions yet"),
        "notProvided": MessageLookupByLibrary.simpleMessage("Not provided"),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "offers": MessageLookupByLibrary.simpleMessage("Offers"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "onSaleLabel": m12,
        "onceCancelledThisAssetWillReturnToYourPortfolio":
            MessageLookupByLibrary.simpleMessage(
                "Once cancelled, this asset will return to your portfolio."),
        "order": MessageLookupByLibrary.simpleMessage("Order"),
        "orderId": MessageLookupByLibrary.simpleMessage("Order ID"),
        "ownedCopies": m13,
        "owner": MessageLookupByLibrary.simpleMessage("Owner"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "payWithYourCard":
            MessageLookupByLibrary.simpleMessage("Pay with your card"),
        "payment": MessageLookupByLibrary.simpleMessage("Transaction History"),
        "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment Method"),
        "pending": MessageLookupByLibrary.simpleMessage("Pending"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "pickACategoryToShowWhatYourCompanyIsAll":
            MessageLookupByLibrary.simpleMessage(
                "Pick a category to show what your company is all about!"),
        "pleaseAddYourCompanyLogo": MessageLookupByLibrary.simpleMessage(
            "Please add your company logo!"),
        "pleaseEnterAValidAmountGreaterThan0":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a valid amount greater than 0."),
        "pleaseEnterAValidPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid phone number."),
        "pleaseEnterAnAmount":
            MessageLookupByLibrary.simpleMessage("Please enter an amount."),
        "pleaseEnterAnAmountOfAtLeast1ToProceed":
            MessageLookupByLibrary.simpleMessage(
                "Please enter an amount of at least 1 to proceed."),
        "pleaseEnterCompanyName": MessageLookupByLibrary.simpleMessage(
            "Please enter your company name"),
        "pleaseEnterYourName":
            MessageLookupByLibrary.simpleMessage("Please enter your name."),
        "pleaseEnterYourValidEmail": MessageLookupByLibrary.simpleMessage(
            "Please enter your valid email."),
        "pleaseGiveYourCompanyANameThatShines":
            MessageLookupByLibrary.simpleMessage(
                "Please give your company a name that shines!"),
        "pleaseMakeSureBothPasswordsAreTheSame":
            MessageLookupByLibrary.simpleMessage(
                "Please make sure both passwords are the same."),
        "pleaseVerifyTheEmailAddress": MessageLookupByLibrary.simpleMessage(
            "Please verify the email address."),
        "pleaseVerifyThePhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Please verify the phone number."),
        "pm": MessageLookupByLibrary.simpleMessage("PM"),
        "points": m14,
        "portfolio": MessageLookupByLibrary.simpleMessage("Portfolio"),
        "portfolioValue":
            MessageLookupByLibrary.simpleMessage("Portfolio Value"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "priceMustBeAtLeast1":
            MessageLookupByLibrary.simpleMessage("Price must be at least 1"),
        "pricePerCopy": MessageLookupByLibrary.simpleMessage("Price Per Copy"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("PRIVACY POLICY"),
        "privacyPolicyBottom":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "privacyPolicyTerms":
            MessageLookupByLibrary.simpleMessage("Privacy Policy & Terms"),
        "processing": MessageLookupByLibrary.simpleMessage("Processing..."),
        "profileInformation":
            MessageLookupByLibrary.simpleMessage("Profile Information"),
        "purchaseAsset": MessageLookupByLibrary.simpleMessage("Purchase Asset"),
        "purchaseCompletedDesc": MessageLookupByLibrary.simpleMessage(
            "Your purchase has been completed successfully. The asset has been added to your portfolio."),
        "purchaseFailed":
            MessageLookupByLibrary.simpleMessage("Purchase Failed"),
        "purchaseSuccessful":
            MessageLookupByLibrary.simpleMessage("Purchase Successful"),
        "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
        "quantityExceedsOwnership":
            MessageLookupByLibrary.simpleMessage("Quantity Exceeds Ownership"),
        "quantityExceedsOwnershipN": m15,
        "quantityMustBeAtLeast1": MessageLookupByLibrary.simpleMessage(
            "Quantity must be at least 1."),
        "recentlyListed":
            MessageLookupByLibrary.simpleMessage("Recently listed"),
        "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
        "requestFailed": MessageLookupByLibrary.simpleMessage("Request Failed"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "riseToTheTop": MessageLookupByLibrary.simpleMessage("RISE TO THE TOP"),
        "saleCancelledSuccessfullynyourAssetIsNowBackInYourPortfolio":
            MessageLookupByLibrary.simpleMessage(
                "Sale cancelled successfully.\nYour asset is now back in your portfolio."),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "searchCountry": MessageLookupByLibrary.simpleMessage("Search Country"),
        "selectCountry": MessageLookupByLibrary.simpleMessage("Select Country"),
        "selectQuantityToPurchase":
            MessageLookupByLibrary.simpleMessage("Select quantity to purchase"),
        "sell": MessageLookupByLibrary.simpleMessage("SELL"),
        "sellMore": MessageLookupByLibrary.simpleMessage("Sell More"),
        "sellingPrice": MessageLookupByLibrary.simpleMessage("Selling Price"),
        "send": MessageLookupByLibrary.simpleMessage("Send"),
        "setNewPassword":
            MessageLookupByLibrary.simpleMessage("Set New Password"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "shortDescription":
            MessageLookupByLibrary.simpleMessage("Short Description"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Something went wrong"),
        "somethingWentWrongPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Something Went Wrong. Please Try Again."),
        "somethingWentWrongPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "Something went wrong. Please try again later."),
        "somethingWentWrongWhileCreatingTheCompanyPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Something went wrong while creating the company. Please try again."),
        "somethingWentWrongWhileLoadingSpecialOffers":
            MessageLookupByLibrary.simpleMessage(
                "Something went wrong while loading special offers."),
        "somethingWentWrongWhileLoadingTheLeaderboardPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Something went wrong while loading the leaderboard. Please try again."),
        "somethingWentWrongWhileProcessingYourRequestPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Something went wrong while processing your request. Please try again later."),
        "somethingWentWrongWhileUpdatingYourProfilePleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Something went wrong while updating your profile. Please try again."),
        "sort": MessageLookupByLibrary.simpleMessage("Sort"),
        "sortBy": MessageLookupByLibrary.simpleMessage("Sort by"),
        "sortOptions": MessageLookupByLibrary.simpleMessage("Sort Options"),
        "specialOffers": MessageLookupByLibrary.simpleMessage("SPECIAL OFFERS"),
        "startPlayingBuildYourCompany": MessageLookupByLibrary.simpleMessage(
            "Start Playing & Build Your Company"),
        "startPlayingBuyAssets":
            MessageLookupByLibrary.simpleMessage("Start Playing & Buy Assets"),
        "startYourInvestmentJourney": MessageLookupByLibrary.simpleMessage(
            "Start Your Investment Journey 🚀"),
        "statusPending":
            MessageLookupByLibrary.simpleMessage("Status: Pending"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "tellUsWhatMakesYourCompanyUniqueAndExciting":
            MessageLookupByLibrary.simpleMessage(
                "Tell us what makes your company unique and exciting!"),
        "terms": MessageLookupByLibrary.simpleMessage("Terms"),
        "theAssetHasBeenPurchasedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "The asset has been purchased successfully."),
        "thePasswordMustBeAtLeast6CharactersOrDigits":
            MessageLookupByLibrary.simpleMessage(
                "The password must be at least 6 characters or digits long."),
        "thePasswordMustBeAtLeast8CharactersOrDigits":
            MessageLookupByLibrary.simpleMessage(
                "The password must be at least 8 characters or digits long."),
        "thisEmailIsNotRegisteredInTheApp":
            MessageLookupByLibrary.simpleMessage(
                "This email is not registered in the app."),
        "thisListingIsCurrentlyActiveInTheMarketplace":
            MessageLookupByLibrary.simpleMessage(
                "This listing is currently active in the marketplace."),
        "thisMonth": MessageLookupByLibrary.simpleMessage("This Month"),
        "thisWeek": MessageLookupByLibrary.simpleMessage("This Week"),
        "top": MessageLookupByLibrary.simpleMessage("Top"),
        "topPlayers": MessageLookupByLibrary.simpleMessage("TOP PLAYERS"),
        "topUp": MessageLookupByLibrary.simpleMessage("Top Up"),
        "topUpYourBalance":
            MessageLookupByLibrary.simpleMessage("Top Up Your Balance"),
        "total": MessageLookupByLibrary.simpleMessage("Total:"),
        "totalBalance": MessageLookupByLibrary.simpleMessage("Total Balance"),
        "totalPrice": m16,
        "totalPriceCon": MessageLookupByLibrary.simpleMessage("Total Price"),
        "transactionCopies": m17,
        "transactionType":
            MessageLookupByLibrary.simpleMessage("Transaction Type"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
        "type": MessageLookupByLibrary.simpleMessage("Type"),
        "typeLabel": m18,
        "unableToCreateTheCompanyPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Unable to create the company. Please try again."),
        "unableToLoadCategoriesRightNowPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load categories right now. Please try again later."),
        "unableToLoadContactInformationRightNow":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load contact information right now."),
        "unableToLoadPrivacyPolicyRightNow":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load privacy policy right now."),
        "unableToLoadSpecialOffersRightNow":
            MessageLookupByLibrary.simpleMessage(
                "Unable to load special offers right now."),
        "unableToLoadTransactionHistory": MessageLookupByLibrary.simpleMessage(
            "Unable to load transaction history."),
        "unexpectedError":
            MessageLookupByLibrary.simpleMessage("Unexpected Error"),
        "unexpectedResponseFromServer": MessageLookupByLibrary.simpleMessage(
            "Unexpected response from server"),
        "unitPrice": m19,
        "unitsListedInMarket": m20,
        "unlockRequirement":
            MessageLookupByLibrary.simpleMessage("Unlock Requirement"),
        "unlockRequirementText": m21,
        "unlockYourCompanyAndEnterTheGameWorld":
            MessageLookupByLibrary.simpleMessage(
                "Unlock your company and enter the game world 🚀"),
        "updateFailed": MessageLookupByLibrary.simpleMessage("Update Failed"),
        "visa": MessageLookupByLibrary.simpleMessage("Visa"),
        "weHaveEmailedYourPasswordResetLink":
            MessageLookupByLibrary.simpleMessage(
                "We have emailed your password reset link."),
        "weWereUnableToCompleteYourPurchasePleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "We were unable to complete your purchase. Please try again."),
        "wereHereToHelpYou":
            MessageLookupByLibrary.simpleMessage("We’re here to help you"),
        "yes": MessageLookupByLibrary.simpleMessage("YES"),
        "youAreTryingToSellMoreCopiesThanYouOwn":
            MessageLookupByLibrary.simpleMessage(
                "You are trying to sell more copies than you own. Please adjust the quantity."),
        "youCanCancelTheSaleAtAnyTime": MessageLookupByLibrary.simpleMessage(
            "You can cancel the sale at any time."),
        "youCanCancelThisSaleBeforeAnotherPlayerBuysIt":
            MessageLookupByLibrary.simpleMessage(
                "You can cancel this sale before another player buys it."),
        "youCanListFewerCopiesAndChooseAnySellingPrice":
            MessageLookupByLibrary.simpleMessage(
                "You can list fewer copies and choose any selling price."),
        "youDontHaveAnyAssetsListedForSaleInThe":
            MessageLookupByLibrary.simpleMessage(
                "You don’t have any assets listed for sale in the market."),
        "youHaveSuccessfullyEstablishedYourCompanyButItIsStill":
            MessageLookupByLibrary.simpleMessage(
                "You have successfully established your company, but it is still inactive."),
        "yourAccountHasBeenDeletedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Your account has been deleted successfully."),
        "yourAccountHasBeenSuccessfullyCreatedPleaseLogInTo":
            MessageLookupByLibrary.simpleMessage(
                "Your account has been successfully created."),
        "yourAssetHasBeenSuccessfullyListedInTheMarketplace":
            MessageLookupByLibrary.simpleMessage(
                "Your asset has been successfully listed in the marketplace."),
        "yourBalanceHasBeenSuccessfullyToppedUp":
            MessageLookupByLibrary.simpleMessage(
                "Your balance has been successfully topped up."),
        "yourCompanyHasBeenCreatedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Your company has been created successfully."),
        "yourCompanyNeedsAFounderFillInYourName":
            MessageLookupByLibrary.simpleMessage(
                "Your company needs a founder — fill in your name!"),
        "yourCompanyProfileInOnePlace": MessageLookupByLibrary.simpleMessage(
            "Your company profile in one place"),
        "yourCompanyProfileWillAppearHereOnceItIsCreated":
            MessageLookupByLibrary.simpleMessage(
                "Your company profile will appear here once it is created."),
        "yourCompletedPurchasesWillAppearHereOnceAvailable":
            MessageLookupByLibrary.simpleMessage(
                "Your completed purchases will appear here once available."),
        "yourCurrentBalanceIsNotEnoughToCompleteThisPurchase":
            MessageLookupByLibrary.simpleMessage(
                "Your current balance is not enough to complete this purchase. Please top up your balance and try again."),
        "yourName": MessageLookupByLibrary.simpleMessage("Your name"),
        "yourPasswordWasUpdatedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Your password was updated successfully."),
        "yourPersonalInfoAndAccountDetails":
            MessageLookupByLibrary.simpleMessage(
                "Your personal info and account details"),
        "yourProfileHasBeenUpdatedSuccessfully":
            MessageLookupByLibrary.simpleMessage(
                "Your profile has been updated successfully.")
      };
}
