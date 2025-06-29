import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/screens/notification/notification_screen.dart';
import 'package:money_maker/screens/payment/payment_screen.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: Padding(padding:  const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.asset(
            appLogo,
            width: AppSize.logoWidthCommon,
            height: AppSize.logoHeightCommon,
            fit: BoxFit.cover,
          ),
          CommonViews().customText(
            textContent: "SETTINGS",
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),
          SizedBox(height: 2.h),
          Expanded(
            child:
            ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: 1.h),
                buildSettingItem(
                  title: 'Notification',
                  onTap: () {
                    AppNavigator.of(context).push(NotificationScreen());
                  },
                  showDivider: true,
                ),

                buildSettingItem(
                  title: 'Payment',
                  onTap: () {
                    AppNavigator.of(context).push(PaymentScreen());
                  },
                  showDivider: false,
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget buildSettingItem({
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    bool showDivider = false,
  }) {
    return Column(
      children: [
        ListTile(
          title: CommonViews().customText(
            textContent: title,
            textColor: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          trailing: trailing ?? const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(color: AppColors.buttonColor, thickness: 2),
          ),
      ],
    );
  }
}
