import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key});

  final List<NotificationItem> notifications = [
    NotificationItem(
      icon: gift,
      title: 'You received 2,000 points!',
      subtitle: 'Congratulations! You ranked #1',
      time: 'this week',
    ),
    NotificationItem(
      icon: bonus,
      title: 'Bonus earned',
      subtitle: 'You earned a \$500 bonus',
      time: '1 day ago',
    ),
    NotificationItem(
      icon: invest,
      title: 'Investment successful',
      subtitle: 'Your investment just increased by 30%',
      time: '3 days ago',
    ),
    NotificationItem(
      icon: bell,
      title: 'Withdrawal complete',
      subtitle: 'You withdraw \$1,000 from your account',
      time: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.asset(
              appLogo,
              width: AppSize.logoWidthCommon,
              height: AppSize.logoHeightCommon,
              fit: BoxFit.cover,
            ),
            CommonViews().customText(
              textContent: "Notifications",
              fontSize: 20.sp,
              textAlign: TextAlign.center,
              maxLines: 2,
              fontWeight: FontWeight.w700,
              textColor: AppColors.buttonColor,
            ),
            SizedBox(height: 1.h,),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.borderTextFieldColor,width: 2),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          item.icon,
                          width: 14.w,
                          height: 7.h,
                          fit: BoxFit.fill,
                        ),
                         SizedBox(width: 6.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonViews().customText(
                                textContent: item.title,
                                fontSize: 16.sp,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                fontWeight: FontWeight.w700,
                                textColor: Colors.black,
                              ),
                               SizedBox(height: 1.h),
                              CommonViews().customText(
                                textContent:  item.subtitle,
                                fontSize: 14.sp,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                fontWeight: FontWeight.w500,
                                textColor: Colors.black54,
                              ),
                              if (item.time.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child:
                                  CommonViews().customText(
                                    textContent:  item.time,
                                    fontSize: 14.sp,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    fontWeight: FontWeight.w500,
                                    textColor:  Colors.black26,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        ),
    );
  }
}


class NotificationItem {
  final String icon;
  final String title;
  final String subtitle;
  final String time;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });
}