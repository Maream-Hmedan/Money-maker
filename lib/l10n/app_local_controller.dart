import 'package:get/get.dart';
import 'package:money_maker/l10n/app_locale.dart';

mixin LocaleAwareController on GetxController {
  void onLocaleChanged();

  void _localeListener() => onLocaleChanged();

  @override
  void onInit() {
    super.onInit();
    AppLocale().addLocaleListener(_localeListener);
  }

  @override
  void onClose() {
    AppLocale().removeLocaleListener(_localeListener);
    super.onClose();
  }
}
