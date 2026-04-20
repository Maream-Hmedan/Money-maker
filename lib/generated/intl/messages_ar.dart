// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(count) => "${count} متوفر";

  static String m1(count) => "عدد النسخ المتاحة للعرض: ${count}";

  static String m2(count) => "المتاح: ${count}";

  static String m3(count) => "المتاح للبيع: ${count}";

  static String m4(name) => "بواسطة: ${name}";

  static String m5(quantity, assetName, totalPrice) =>
      "هل أنت متأكد أنك تريد شراء ${quantity} نسخة من ${assetName} مقابل \\\$${totalPrice}؟\n\nبعد التأكيد، سيتم خصم المبلغ من رصيدك فوراً وإضافة الأصل إلى محفظتك بنجاح.";

  static String m6(count) => "${count} نسخة مدرجة للبيع حالياً";

  static String m7(count) => "${count} نسخة معروضة للبيع حالياً";

  static String m8(count) => "باقي ${count} فقط!";

  static String m9(name) => "عرض ${name} للبيع";

  static String m10(date) => "تم إدراجه في: ${date}";

  static String m11(count) => "الحد الأقصى هو ${count}";

  static String m12(count) => "المعروض للبيع: ${count}";

  static String m13(count) => "المملوك: ${count} نسخة";

  static String m14(value) => "${value} نقطة";

  static String m15(count) => "لديك فقط ${count} نسخة. الرجاء تعديل الكمية.";

  static String m16(total) => "الإجمالي: ${total}";

  static String m17(type, count) =>
      "${type} • ${Intl.plural(count, zero: '0 نسخة', one: 'نسخة واحدة', two: 'نسختان', few: '${count} نسخ', many: '${count} نسخة', other: '${count} نسخة')}";

  static String m18(type) => "النوع: ${type}";

  static String m19(price) => "سعر الوحدة: ${price}";

  static String m20(count) =>
      "${Intl.plural(count, zero: 'لا توجد وحدات معروضة حالياً في السوق.', one: 'وحدة واحدة معروضة حالياً في السوق.', two: 'وحدتان معروضتان حالياً في السوق.', few: '${count} وحدات معروضة حالياً في السوق.', many: '${count} وحدة معروضة حالياً في السوق.', other: '${count} وحدة معروضة حالياً في السوق.')}";

  static String m21(value) =>
      "لتفعيل شركتك وبدء اللعب، يجب عليك شراء أصول بقيمة لا تقل عن ${value}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activateYourCompanyAndJumpIntoTheGameWorld":
            MessageLookupByLibrary.simpleMessage(
                "فعّل شركتك وانطلق إلى عالم اللعبة"),
        "active": MessageLookupByLibrary.simpleMessage("نشط"),
        "addLogo": MessageLookupByLibrary.simpleMessage("أضف شعارك"),
        "address": MessageLookupByLibrary.simpleMessage("العنوان"),
        "all": MessageLookupByLibrary.simpleMessage("الكل"),
        "allTime": MessageLookupByLibrary.simpleMessage("طوال الوقت"),
        "alreadyHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("لديك حساب بالفعل؟"),
        "am": MessageLookupByLibrary.simpleMessage("ص"),
        "anUnexpectedErrorOccurredWhileBuyingTheAssetPleaseTry":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ غير متوقع أثناء شراء الأصل. يرجى المحاولة مرة أخرى."),
        "and": MessageLookupByLibrary.simpleMessage("و"),
        "applePay": MessageLookupByLibrary.simpleMessage("Apple Pay"),
        "apply": MessageLookupByLibrary.simpleMessage("تنفيذ"),
        "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
        "areYouSureYouWantToDeleteYourAccountThis":
            MessageLookupByLibrary.simpleMessage(
                "هل أنت متأكد أنك تريد حذف حسابك؟ هذا الإجراء لا يمكن التراجع عنه."),
        "areYouSureYouWantToLogoutFromYourAccount":
            MessageLookupByLibrary.simpleMessage(
                "هل أنت متأكد أنك تريد تسجيل الخروج من حسابك؟"),
        "ascending": MessageLookupByLibrary.simpleMessage("تصاعدي"),
        "assetBought": MessageLookupByLibrary.simpleMessage("تم شراء أصل"),
        "assetName": MessageLookupByLibrary.simpleMessage("اسم الأصل"),
        "assetSold": MessageLookupByLibrary.simpleMessage("تم بيع أصل"),
        "assetType": MessageLookupByLibrary.simpleMessage("نوع الأصل"),
        "available": MessageLookupByLibrary.simpleMessage("المتوفر:"),
        "availableCopies": m0,
        "availableCopiesToList": m1,
        "availableLabel": m2,
        "availableToSell": m3,
        "availableToTopUpInstantly":
            MessageLookupByLibrary.simpleMessage("متاح للشحن الفوري"),
        "balance": MessageLookupByLibrary.simpleMessage("الرصيد"),
        "balanceHistory": MessageLookupByLibrary.simpleMessage("سجل الرصيد"),
        "buildYourCompany": MessageLookupByLibrary.simpleMessage("ابنِ شركتك"),
        "buy": MessageLookupByLibrary.simpleMessage("شراء"),
        "buyAssets": MessageLookupByLibrary.simpleMessage("ابدأ بشراء الأصول"),
        "buyConfirmationMessage": MessageLookupByLibrary.simpleMessage(
            "هل أنت متأكد أنك تريد شراء هذا الأصل؟\n\nسيتم خصم السعر من رصيدك، وسيتم إضافة الأصل إلى محفظتك مباشرة."),
        "buyNow": MessageLookupByLibrary.simpleMessage("شراء الآن"),
        "buyOffer": MessageLookupByLibrary.simpleMessage("عرض شراء"),
        "bySigningUpYouAgreeToOur": MessageLookupByLibrary.simpleMessage(
            "بإنشائك حسابًا، فإنك توافق على"),
        "byUser": m4,
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "cancelSale": MessageLookupByLibrary.simpleMessage("إلغاء البيع"),
        "category": MessageLookupByLibrary.simpleMessage("التصنيف"),
        "categoryDot": MessageLookupByLibrary.simpleMessage("التصنيف : "),
        "changeLanguage": MessageLookupByLibrary.simpleMessage("تغيير اللغة"),
        "changePassword":
            MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
        "changeYourPassword":
            MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
        "chargeUserBalance": MessageLookupByLibrary.simpleMessage("شحن الرصيد"),
        "code": MessageLookupByLibrary.simpleMessage("رمز العرض:"),
        "companyAccessLocked":
            MessageLookupByLibrary.simpleMessage("إدارة شركتك مقفلة 🔒"),
        "companyCreatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم تأسيس شركتك بنجاح 🎉"),
        "companyName": MessageLookupByLibrary.simpleMessage("اسم الشركة"),
        "companyNameTooShort": MessageLookupByLibrary.simpleMessage(
            "يجب أن يكون اسم الشركة 3 أحرف على الأقل"),
        "companyNotFound":
            MessageLookupByLibrary.simpleMessage("لم يتم العثور على الشركة"),
        "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
        "confirmCancel": MessageLookupByLibrary.simpleMessage("تأكيد الإلغاء"),
        "confirmDeletion": MessageLookupByLibrary.simpleMessage("تأكيد الحذف"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور"),
        "confirmPurchase": MessageLookupByLibrary.simpleMessage("تأكيد الشراء"),
        "confirmPurchaseMessage": m5,
        "confirmTopUp": MessageLookupByLibrary.simpleMessage("تأكيد الشحن"),
        "contactUs": MessageLookupByLibrary.simpleMessage("اتصل بنا"),
        "continueAsGuest":
            MessageLookupByLibrary.simpleMessage("المتابعة كزائر"),
        "continuePress": MessageLookupByLibrary.simpleMessage("متابعة"),
        "copiesListedForSale": m6,
        "copiesOnSale": m7,
        "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "createdAt": MessageLookupByLibrary.simpleMessage("تاريخ الإنشاء"),
        "credit": MessageLookupByLibrary.simpleMessage("إيداع"),
        "creditTransaction":
            MessageLookupByLibrary.simpleMessage("عملية إيداع"),
        "date": MessageLookupByLibrary.simpleMessage("التاريخ"),
        "debit": MessageLookupByLibrary.simpleMessage("خصم"),
        "debitTransaction": MessageLookupByLibrary.simpleMessage("عملية خصم"),
        "deleteMyAccount": MessageLookupByLibrary.simpleMessage("حذف حسابي"),
        "descending": MessageLookupByLibrary.simpleMessage("تنازلي"),
        "describeWhatMakesYourCompanyUniqueAndPowerful":
            MessageLookupByLibrary.simpleMessage(
                "صف ما يجعل شركتك مميزة وقوية..."),
        "description": MessageLookupByLibrary.simpleMessage("الوصف"),
        "discoverRareAssetsFromOtherPlayersSendAPurchaseRequest":
            MessageLookupByLibrary.simpleMessage(
                "اكتشف الأصول النادرة من لاعبين آخرين! أرسل طلب شراء بعد تأكيد البائع."),
        "doYouWantToCancelTheActiveSaleForThis":
            MessageLookupByLibrary.simpleMessage(
                "هل تريد إلغاء عملية البيع النشطة لهذا الأصل؟"),
        "doYouWantToCancelTheSaleForThisAsset":
            MessageLookupByLibrary.simpleMessage(
                "هل تريد إلغاء بيع هذا الأصل؟ سيتم حذفه من السوق."),
        "dontHaveAnAccount":
            MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
        "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
        "english": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
        "enjoyThisLimitedtimeSpecialOfferOnSelectedAssets":
            MessageLookupByLibrary.simpleMessage(
                "استمتع بعرض خاص لفترة محدودة على مجموعة مختارة من الأصول."),
        "enterAmount": MessageLookupByLibrary.simpleMessage("أدخل المبلغ"),
        "enterCompanyName":
            MessageLookupByLibrary.simpleMessage("أدخل اسم شركتك"),
        "enterYourEmailToResetYourPassword":
            MessageLookupByLibrary.simpleMessage(
                "أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور."),
        "error": MessageLookupByLibrary.simpleMessage("خطأ"),
        "errorLoadingBalanceValue":
            MessageLookupByLibrary.simpleMessage("حدث خطأ أثناء تحميل الرصيد"),
        "errorLoadingData": MessageLookupByLibrary.simpleMessage(
            "حدث خطأ أثناء تحميل البيانات"),
        "errorLoadingPortfolioValue":
            MessageLookupByLibrary.simpleMessage("خطأ في تحميل قيمة المحفظة"),
        "expiresOn": MessageLookupByLibrary.simpleMessage("ينتهي في:"),
        "exploreAssets":
            MessageLookupByLibrary.simpleMessage("استكشف الأصول 🌍"),
        "failedToFetchProfileData": MessageLookupByLibrary.simpleMessage(
            "فشل في تحميل بيانات الملف الشخصي"),
        "failedToLoadCompanyInformation": MessageLookupByLibrary.simpleMessage(
            "فشل في تحميل معلومات الشركة."),
        "failedToLoadTransactions":
            MessageLookupByLibrary.simpleMessage("فشل في تحميل المعاملات"),
        "failedToResetPassword": MessageLookupByLibrary.simpleMessage(
            "فشل في إعادة تعيين كلمة المرور"),
        "failedToTopUpBalancePleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "فشل في شحن الرصيد. يرجى المحاولة لاحقًا."),
        "fastAndSecurePayment":
            MessageLookupByLibrary.simpleMessage("دفع سريع وآمن"),
        "filter": MessageLookupByLibrary.simpleMessage("تصفية"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور"),
        "forgotPasswordL":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
        "founder": MessageLookupByLibrary.simpleMessage("المؤسس"),
        "founderName": MessageLookupByLibrary.simpleMessage("اسم المؤسس"),
        "fullName": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
        "getStarted": MessageLookupByLibrary.simpleMessage("ابدأ الآن"),
        "getYourAssetsUnlockYourCompanyAndStartYourJourney":
            MessageLookupByLibrary.simpleMessage(
                "جهّز أصولك، افتح شركتك، وابدأ رحلتك"),
        "goBackTo": MessageLookupByLibrary.simpleMessage("العودة إلى"),
        "goToMarketplace":
            MessageLookupByLibrary.simpleMessage("الانتقال إلى السوق"),
        "great": MessageLookupByLibrary.simpleMessage("رائع"),
        "growthRate": MessageLookupByLibrary.simpleMessage("معدل النمو"),
        "hideTopUp": MessageLookupByLibrary.simpleMessage("إخفاء الشحن"),
        "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "includedAssets":
            MessageLookupByLibrary.simpleMessage("الأصول المشمولة"),
        "insufficientBalance":
            MessageLookupByLibrary.simpleMessage("رصيد غير كافٍ"),
        "invalidLoginCredentials": MessageLookupByLibrary.simpleMessage(
            "يرجى التأكد من البريد الإلكتروني وكلمة المرور ثم المحاولة مرة أخرى."),
        "invalidPrice": MessageLookupByLibrary.simpleMessage("سعر غير صالح"),
        "invalidQuantity":
            MessageLookupByLibrary.simpleMessage("كمية غير صالحة"),
        "keepSale": MessageLookupByLibrary.simpleMessage("الاستمرار في البيع"),
        "launchCompany": MessageLookupByLibrary.simpleMessage("أطلق شركتك 🚀"),
        "leaderboard": MessageLookupByLibrary.simpleMessage("لوحة المتصدرين"),
        "leftCopies": m8,
        "listForSale": m9,
        "listedOn": m10,
        "logIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "logInOrSignUpToAccessYourPortfolioAnd":
            MessageLookupByLibrary.simpleMessage(
                "سجّل الدخول أو أنشئ حسابًا لفتح محفظتك وابدأ بتنمية ثروتك 🚀"),
        "logInOrSignUpToCreateAndManageYour": MessageLookupByLibrary.simpleMessage(
            "سجّل الدخول أو أنشئ حسابًا لتأسيس شركتك، إدارة استثماراتك، واغتنام فرص جديدة 🚀"),
        "logInOrSignUpToUnlockYourBalanceBuild":
            MessageLookupByLibrary.simpleMessage(
                "سجّل الدخول أو أنشئ حسابًا لفتح رصيدك، وبناء محفظتك، والبدء في تنمية ثروتك!"),
        "logInToViewYourBalance":
            MessageLookupByLibrary.simpleMessage("سجّل الدخول لعرض رصيدك 💰"),
        "logInToViewYourPortfolio":
            MessageLookupByLibrary.simpleMessage("سجّل الدخول لعرض محفظتك 📊"),
        "logOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "market": MessageLookupByLibrary.simpleMessage("السوق"),
        "marketPlace": MessageLookupByLibrary.simpleMessage("منصة السوق"),
        "marketPlaceH": MessageLookupByLibrary.simpleMessage("منصة السوق"),
        "marketS": MessageLookupByLibrary.simpleMessage("السوق"),
        "maxAvailable": m11,
        "membersOnly":
            MessageLookupByLibrary.simpleMessage("مخصصة للاعبين فقط 🔒"),
        "myAssets": MessageLookupByLibrary.simpleMessage("أصولي 🏠"),
        "myCompany": MessageLookupByLibrary.simpleMessage("شركتي"),
        "myProfile": MessageLookupByLibrary.simpleMessage("حسابي"),
        "no": MessageLookupByLibrary.simpleMessage("لا"),
        "noBalanceHistoryAvailable": MessageLookupByLibrary.simpleMessage(
            "لا يوجد سجل رصيد متاح حالياً."),
        "noCategoriesAvailableAtTheMoment":
            MessageLookupByLibrary.simpleMessage(
                "لا توجد تصنيفات متاحة حالياً."),
        "noCompanyFoundYet":
            MessageLookupByLibrary.simpleMessage("لا توجد شركة حتى الآن."),
        "noCompanyIsLinkedToYourAccountPleaseContactSupport":
            MessageLookupByLibrary.simpleMessage(
                "لا توجد شركة مرتبطة بحسابك. يرجى التواصل مع الدعم أو المحاولة لاحقًا."),
        "noContactInformationIsAvailableAtTheMoment":
            MessageLookupByLibrary.simpleMessage(
                "لا تتوفر معلومات تواصل حالياً."),
        "noMarketItemsFound":
            MessageLookupByLibrary.simpleMessage("لا توجد أصول متاحة حاليًا"),
        "noNotificationsYet":
            MessageLookupByLibrary.simpleMessage("لا توجد إشعارات حالياً."),
        "noPlayersFoundForTheSelectedPeriod":
            MessageLookupByLibrary.simpleMessage("لا يوجد لاعبين لهذه الفترة."),
        "noPortfolioDataFound":
            MessageLookupByLibrary.simpleMessage("لا توجد بيانات للمحفظة"),
        "noPrivacyPolicyIsAvailableAtTheMoment":
            MessageLookupByLibrary.simpleMessage(
                "لا تتوفر سياسة الخصوصية في الوقت الحالي."),
        "noSpecialOffersAreAvailableRightNow":
            MessageLookupByLibrary.simpleMessage(
                "لا توجد عروض خاصة متاحة في الوقت الحالي."),
        "noTransactionsYet":
            MessageLookupByLibrary.simpleMessage("لا توجد معاملات حتى الآن"),
        "notProvided": MessageLookupByLibrary.simpleMessage("غير متوفر"),
        "notification": MessageLookupByLibrary.simpleMessage("الإشعارات"),
        "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
        "offers": MessageLookupByLibrary.simpleMessage("العروض"),
        "ok": MessageLookupByLibrary.simpleMessage("موافق"),
        "onSaleLabel": m12,
        "onceCancelledThisAssetWillReturnToYourPortfolio":
            MessageLookupByLibrary.simpleMessage(
                "بعد الإلغاء، سيعود هذا الأصل إلى محفظتك."),
        "order": MessageLookupByLibrary.simpleMessage("اتجاه الترتيب"),
        "orderId": MessageLookupByLibrary.simpleMessage("رقم الطلب"),
        "ownedCopies": m13,
        "owner": MessageLookupByLibrary.simpleMessage("المالك"),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "payWithYourCard":
            MessageLookupByLibrary.simpleMessage("الدفع باستخدام البطاقة"),
        "payment": MessageLookupByLibrary.simpleMessage("سجل العمليات"),
        "paymentMethod": MessageLookupByLibrary.simpleMessage("طريقة الدفع"),
        "pending": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
        "phone": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
        "pickACategoryToShowWhatYourCompanyIsAll":
            MessageLookupByLibrary.simpleMessage(
                "اختر تصنيفًا يوضح مجال شركتك!"),
        "pleaseAddYourCompanyLogo": MessageLookupByLibrary.simpleMessage(
            "أضف شعار شركتك لتكتمل هويتها!"),
        "pleaseEnterAValidAmountGreaterThan0":
            MessageLookupByLibrary.simpleMessage(
                "يرجى إدخال مبلغ صحيح أكبر من 0."),
        "pleaseEnterAValidPhoneNumber":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال رقم هاتف صحيح."),
        "pleaseEnterAnAmount":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال المبلغ."),
        "pleaseEnterAnAmountOfAtLeast1ToProceed":
            MessageLookupByLibrary.simpleMessage(
                "يرجى إدخال مبلغ لا يقل عن 1 للمتابعة."),
        "pleaseEnterCompanyName":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال اسم الشركة"),
        "pleaseEnterYourName":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال اسمك."),
        "pleaseEnterYourValidEmail": MessageLookupByLibrary.simpleMessage(
            "يرجى إدخال بريد إلكتروني صحيح."),
        "pleaseGiveYourCompanyANameThatShines":
            MessageLookupByLibrary.simpleMessage(
                "امنح شركتك اسمًا يلمع ويترك بصمة!"),
        "pleaseMakeSureBothPasswordsAreTheSame":
            MessageLookupByLibrary.simpleMessage(
                "يرجى التأكد من تطابق كلمتي المرور."),
        "pleaseVerifyTheEmailAddress": MessageLookupByLibrary.simpleMessage(
            "يرجى التحقق من صحة البريد الإلكتروني."),
        "pleaseVerifyThePhoneNumber":
            MessageLookupByLibrary.simpleMessage("يرجى التحقق من رقم الهاتف."),
        "pm": MessageLookupByLibrary.simpleMessage("م"),
        "points": m14,
        "portfolio": MessageLookupByLibrary.simpleMessage("المحفظة"),
        "portfolioValue": MessageLookupByLibrary.simpleMessage("قيمة المحفظة"),
        "price": MessageLookupByLibrary.simpleMessage("السعر"),
        "priceMustBeAtLeast1":
            MessageLookupByLibrary.simpleMessage("يجب إدخال سعر لا يقل عن 1"),
        "pricePerCopy": MessageLookupByLibrary.simpleMessage("سعر الوحدة"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
        "privacyPolicyBottom":
            MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
        "privacyPolicyTerms":
            MessageLookupByLibrary.simpleMessage("سياسة الخصوصية والشروط"),
        "processing": MessageLookupByLibrary.simpleMessage("جاري المعالجة..."),
        "profileInformation":
            MessageLookupByLibrary.simpleMessage("معلومات الحساب"),
        "purchaseAsset": MessageLookupByLibrary.simpleMessage("شراء الأصل"),
        "purchaseCompletedDesc": MessageLookupByLibrary.simpleMessage(
            "تمت عملية الشراء بنجاح، وتمت إضافة الأصل إلى محفظتك."),
        "purchaseSuccessful":
            MessageLookupByLibrary.simpleMessage("تمت عملية الشراء بنجاح"),
        "quantity": MessageLookupByLibrary.simpleMessage("الكمية"),
        "quantityExceedsOwnership":
            MessageLookupByLibrary.simpleMessage("الكمية تتجاوز ملكيتك"),
        "quantityExceedsOwnershipN": m15,
        "quantityMustBeAtLeast1": MessageLookupByLibrary.simpleMessage(
            "يجب أن تكون الكمية على الأقل 1"),
        "recentlyListed":
            MessageLookupByLibrary.simpleMessage("المعروضة حديثاً"),
        "refresh": MessageLookupByLibrary.simpleMessage("تحديث"),
        "requestFailed": MessageLookupByLibrary.simpleMessage("فشل الطلب"),
        "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
        "riseToTheTop": MessageLookupByLibrary.simpleMessage("انطلق نحو القمة"),
        "saleCancelledSuccessfullynyourAssetIsNowBackInYourPortfolio":
            MessageLookupByLibrary.simpleMessage(
                "تم إلغاء البيع بنجاح.\nعاد الأصل إلى محفظتك."),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "searchCountry": MessageLookupByLibrary.simpleMessage("ابحث عن دولة"),
        "selectCountry": MessageLookupByLibrary.simpleMessage("اختر الدولة"),
        "selectQuantityToPurchase":
            MessageLookupByLibrary.simpleMessage("اختر الكمية المراد شراؤها"),
        "sell": MessageLookupByLibrary.simpleMessage("بيع"),
        "sellMore": MessageLookupByLibrary.simpleMessage("عرض المزيد للبيع"),
        "sellingPrice": MessageLookupByLibrary.simpleMessage("سعر البيع"),
        "send": MessageLookupByLibrary.simpleMessage("إرسال"),
        "setNewPassword":
            MessageLookupByLibrary.simpleMessage("تعيين كلمة مرور جديدة"),
        "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
        "shortDescription": MessageLookupByLibrary.simpleMessage("وصف مختصر"),
        "signIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "signUp": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
        "somethingWentWrong":
            MessageLookupByLibrary.simpleMessage("حدث خطأ ما."),
        "somethingWentWrongPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ ما، يرجى المحاولة مرة أخرى."),
        "somethingWentWrongPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا."),
        "somethingWentWrongWhileCreatingTheCompanyPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ أثناء إنشاء الشركة. حاول مرة أخرى."),
        "somethingWentWrongWhileLoadingSpecialOffers":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ أثناء تحميل العروض الخاصة."),
        "somethingWentWrongWhileLoadingTheLeaderboardPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ أثناء تحميل قائمة المتصدرين. يرجى المحاولة مرة أخرى."),
        "somethingWentWrongWhileProcessingYourRequestPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ أثناء معالجة طلبك. يرجى المحاولة مرة أخرى لاحقًا."),
        "somethingWentWrongWhileUpdatingYourProfilePleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "حدث خطأ أثناء تحديث ملفك الشخصي، يرجى المحاولة مرة أخرى."),
        "sort": MessageLookupByLibrary.simpleMessage("ترتيب"),
        "sortBy": MessageLookupByLibrary.simpleMessage("ترتيب حسب"),
        "sortOptions": MessageLookupByLibrary.simpleMessage("خيارات الترتيب"),
        "specialOffers": MessageLookupByLibrary.simpleMessage("العروض الخاصة"),
        "startPlayingBuildYourCompany":
            MessageLookupByLibrary.simpleMessage("ابدأ اللعب وابنِ شركتك"),
        "startPlayingBuyAssets":
            MessageLookupByLibrary.simpleMessage("ابدأ اللعب واشتري الأصول"),
        "startYourInvestmentJourney":
            MessageLookupByLibrary.simpleMessage("ابدأ رحلتك الاستثمارية 🚀"),
        "statusPending": MessageLookupByLibrary.simpleMessage("الحالة: معلقة"),
        "success": MessageLookupByLibrary.simpleMessage("تم بنجاح"),
        "tellUsWhatMakesYourCompanyUniqueAndExciting":
            MessageLookupByLibrary.simpleMessage(
                "أخبرنا ما الذي يجعل شركتك فريدة ومثيرة!"),
        "terms": MessageLookupByLibrary.simpleMessage("الشروط والأحكام"),
        "theAssetHasBeenPurchasedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم شراء الأصل بنجاح."),
        "thePasswordMustBeAtLeast6CharactersOrDigits":
            MessageLookupByLibrary.simpleMessage(
                "يجب أن تتكون كلمة المرور من 6 أحرف أو أرقام على الأقل."),
        "thePasswordMustBeAtLeast8CharactersOrDigits":
            MessageLookupByLibrary.simpleMessage(
                "يجب أن تتكون كلمة المرور من 8 أحرف أو أرقام على الأقل."),
        "thisEmailIsNotRegisteredInTheApp":
            MessageLookupByLibrary.simpleMessage(
                "هذا البريد الإلكتروني غير مسجل في التطبيق."),
        "thisListingIsCurrentlyActiveInTheMarketplace":
            MessageLookupByLibrary.simpleMessage(
                "هذا العرض نشط حالياً في السوق."),
        "thisMonth": MessageLookupByLibrary.simpleMessage("هذا الشهر"),
        "thisWeek": MessageLookupByLibrary.simpleMessage("هذا الأسبوع"),
        "top": MessageLookupByLibrary.simpleMessage("المتصدرين"),
        "topPlayers": MessageLookupByLibrary.simpleMessage("أفضل اللاعبين"),
        "topUp": MessageLookupByLibrary.simpleMessage("شحن الرصيد"),
        "topUpYourBalance": MessageLookupByLibrary.simpleMessage("شحن الرصيد"),
        "total": MessageLookupByLibrary.simpleMessage("الإجمالي:"),
        "totalBalance": MessageLookupByLibrary.simpleMessage("إجمالي الرصيد"),
        "totalPrice": m16,
        "totalPriceCon": MessageLookupByLibrary.simpleMessage("السعر الإجمالي"),
        "transactionCopies": m17,
        "transactionType": MessageLookupByLibrary.simpleMessage("نوع العملية"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
        "type": MessageLookupByLibrary.simpleMessage("النوع"),
        "typeLabel": m18,
        "unableToCreateTheCompanyPleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "تعذر إنشاء الشركة. يُرجى المحاولة مرة أخرى."),
        "unableToLoadCategoriesRightNowPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "تعذر تحميل التصنيفات حالياً. يرجى المحاولة مرة أخرى لاحقاً."),
        "unableToLoadPrivacyPolicyRightNow":
            MessageLookupByLibrary.simpleMessage(
                "يتعذر تحميل سياسة الخصوصية حاليًا."),
        "unableToLoadSpecialOffersRightNow":
            MessageLookupByLibrary.simpleMessage(
                "يتعذر تحميل العروض الخاصة حاليًا."),
        "unableToLoadTransactionHistory":
            MessageLookupByLibrary.simpleMessage("تعذر تحميل سجل العمليات."),
        "unexpectedError":
            MessageLookupByLibrary.simpleMessage("خطأ غير متوقع"),
        "unexpectedResponseFromServer": MessageLookupByLibrary.simpleMessage(
            "استجابة غير متوقعة من الخادم"),
        "unitPrice": m19,
        "unitsListedInMarket": m20,
        "unlockRequirement":
            MessageLookupByLibrary.simpleMessage("شروط فتح الشركة"),
        "unlockRequirementText": m21,
        "unlockYourCompanyAndEnterTheGameWorld":
            MessageLookupByLibrary.simpleMessage(
                "فعّل شركتك وانطلق إلى عالم اللعبة 🚀"),
        "updateFailed": MessageLookupByLibrary.simpleMessage("فشل التحديث"),
        "visa": MessageLookupByLibrary.simpleMessage("فيزا"),
        "weHaveEmailedYourPasswordResetLink":
            MessageLookupByLibrary.simpleMessage(
                "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني."),
        "weWereUnableToCompleteYourPurchasePleaseTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "تعذر إتمام عملية الشراء. يرجى المحاولة مرة أخرى."),
        "wereHereToHelpYou":
            MessageLookupByLibrary.simpleMessage("نحن هنا لمساعدتك"),
        "yes": MessageLookupByLibrary.simpleMessage("نعم"),
        "youAreTryingToSellMoreCopiesThanYouOwn":
            MessageLookupByLibrary.simpleMessage(
                "أنت تحاول بيع عدد نسخ أكبر مما تمتلك. يرجى تعديل الكمية."),
        "youCanCancelTheSaleAtAnyTime": MessageLookupByLibrary.simpleMessage(
            "يمكنك إلغاء عملية البيع في أي وقت."),
        "youCanCancelThisSaleBeforeAnotherPlayerBuysIt":
            MessageLookupByLibrary.simpleMessage(
                "يمكنك إلغاء البيع قبل أن يقوم لاعب آخر بشرائه."),
        "youCanListFewerCopiesAndChooseAnySellingPrice":
            MessageLookupByLibrary.simpleMessage(
                "يمكنك عرض عدد أقل من النسخ للبيع وتحديد السعر الذي تريده."),
        "youDontHaveAnyAssetsListedForSaleInThe":
            MessageLookupByLibrary.simpleMessage(
                "ليس لديك أي أصول معروضة للبيع في السوق."),
        "youHaveSuccessfullyEstablishedYourCompanyButItIsStill":
            MessageLookupByLibrary.simpleMessage(
                "لقد بدأت رحلتك بنجاح، لكن شركتك ما تزال غير مفعّلة."),
        "yourAccountHasBeenDeletedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم حذف حسابك بنجاح."),
        "yourAccountHasBeenSuccessfullyCreatedPleaseLogInTo":
            MessageLookupByLibrary.simpleMessage("تم إنشاء حسابك بنجاح."),
        "yourAssetHasBeenSuccessfullyListedInTheMarketplace":
            MessageLookupByLibrary.simpleMessage(
                "تم إدراج الأصل بنجاح في السوق."),
        "yourBalanceHasBeenSuccessfullyToppedUp":
            MessageLookupByLibrary.simpleMessage("تم شحن رصيدك بنجاح."),
        "yourCompanyHasBeenCreatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم إنشاء شركتك بنجاح."),
        "yourCompanyNeedsAFounderFillInYourName":
            MessageLookupByLibrary.simpleMessage(
                "كل شركة تحتاج إلى مؤسس — أدخل اسمك!"),
        "yourCompanyProfileInOnePlace":
            MessageLookupByLibrary.simpleMessage("ملف شركتك في مكان واحد"),
        "yourCompanyProfileWillAppearHereOnceItIsCreated":
            MessageLookupByLibrary.simpleMessage(
                "سيظهر ملف شركتك هنا بمجرد إنشائها."),
        "yourCompletedPurchasesWillAppearHereOnceAvailable":
            MessageLookupByLibrary.simpleMessage(
                "ستظهر مشترياتك المكتملة هنا عند توفرها."),
        "yourCurrentBalanceIsNotEnoughToCompleteThisPurchase":
            MessageLookupByLibrary.simpleMessage(
                "رصيدك الحالي غير كافٍ لإتمام هذه العملية. قم بشحن رصيدك الآن للمتابعة."),
        "yourName": MessageLookupByLibrary.simpleMessage("اسمك"),
        "yourPasswordWasUpdatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم تحديث كلمة المرور بنجاح."),
        "yourPersonalInfoAndAccountDetails":
            MessageLookupByLibrary.simpleMessage(
                "معلوماتك الشخصية وتفاصيل حسابك"),
        "yourProfileHasBeenUpdatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("تم تحديث ملفك الشخصي بنجاح.")
      };
}
