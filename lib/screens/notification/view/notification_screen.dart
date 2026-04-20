import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/notification/controller/notification_controller.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: GetBuilder<NotificationController>(
        builder: (controller) {
          return Padding(
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
                  textContent: S.of(context).notifications,
                  fontSize: 20.sp,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.buttonColor,
                ),
                SizedBox(height: 1.h),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.getNotifications();
                    },
                    child: Builder(
                      builder: (context) {
                        /// LOADING
                        if (controller.isLoading) {
                          return ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.75,
                                child: _buildShimmer(),
                              ),
                            ],
                          );
                        }

                        /// ERROR
                        if (controller.isError) {
                          return ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.75,
                                child: Center(
                                  child: CommonViews().customText(
                                    textContent: S
                                        .of(context)
                                        .somethingWentWrongPleaseTryAgain,
                                    fontSize: 16.sp,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        /// EMPTY
                        if (controller.isEmpty) {
                          return ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.75,
                                child: Center(
                                  child: CommonViews().customText(
                                    textContent:
                                    S.of(context).noNotificationsYet,
                                    fontSize: 16.sp,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        /// SUCCESS
                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: controller.notificationsList.length,
                          itemBuilder: (context, index) {
                            final item = controller.notificationsList[index];

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.borderTextFieldColor,
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    bell,
                                    width: 14.w,
                                    height: 7.h,
                                    fit: BoxFit.fill,
                                  ),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CommonViews().customText(
                                          textContent:
                                          controller.notificationBody(item),
                                          fontSize: 16.sp,
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          fontWeight: FontWeight.w700,
                                          textColor: Colors.black,
                                        ),
                                        SizedBox(height: 1.h),
                                        if (item.createdAt != null)
                                          CommonViews().customText(
                                            textContent:
                                            formatDate(item.createdAt!),
                                            fontSize: 15.sp,
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            fontWeight: FontWeight.w500,
                                            textColor: Colors.black26,
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.borderTextFieldColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 14.w,
                  height: 7.h,
                  color: Colors.white,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 10,
                        width: 40.w,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String formatDate(DateTime date) {
    final langCode = AppLocale().currentLocale.languageCode;

    if (langCode == 'ar') {
      return DateFormat('d MMMM yyyy', 'ar').format(date);
    } else {
      return DateFormat('MMMM d, yyyy', 'en').format(date);
    }
  }
}

// class NotificationScreen extends StatelessWidget {
//   NotificationScreen({super.key});
//
//   final NotificationController controller =
//   Get.put(NotificationController());
//
//   @override
//   Widget build(BuildContext context) {
//     return CommonBackground(
//       showAppBar: true,
//       child: GetBuilder<NotificationController>(
//         builder: (controller) {
//           return Padding(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               children: [
//                 Image.asset(
//                   appLogo,
//                   width: AppSize.logoWidthCommon,
//                   height: AppSize.logoHeightCommon,
//                   fit: BoxFit.cover,
//                 ),
//                 CommonViews().customText(
//                   textContent: S.of(context).notifications,
//                   fontSize: 20.sp,
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   fontWeight: FontWeight.w700,
//                   textColor: AppColors.buttonColor,
//                 ),
//                 SizedBox(height: 1.h),
//
//                 /// 🔹 LOADING
//                 if (controller.isLoading)
//                   Expanded(child: _buildShimmer())
//
//                 /// 🔹 ERROR
//                 else if (controller.isError)
//                   Expanded(
//                     child: Center(
//                       child: CommonViews().customText(
//                         textContent: S.of(context).somethingWentWrongPleaseTryAgain,
//                         fontSize: 16.sp,
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         fontWeight: FontWeight.w500,
//                         textColor: Colors.black54,
//                       ),
//                     ),
//                   )
//
//                 /// 🔹 EMPTY
//                 else if (controller.isEmpty)
//                     Expanded(
//                       child: Center(
//                         child: CommonViews().customText(
//                           textContent: S.of(context).noNotificationsYet,
//                           fontSize: 16.sp,
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           fontWeight: FontWeight.w500,
//                           textColor: Colors.black54,
//                         ),
//                       ),
//                     )
//
//                   /// 🔹 SUCCESS
//                   else
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: controller.notificationsList.length,
//                         itemBuilder: (context, index) {
//                           final item = controller.notificationsList[index];
//
//                           return Container(
//                             margin: const EdgeInsets.symmetric(vertical: 6),
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16),
//                               border: Border.all(
//                                 color: AppColors.borderTextFieldColor,
//                                 width: 2,
//                               ),
//                             ),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Image.asset(
//                                   bell,
//                                   width: 14.w,
//                                   height: 7.h,
//                                   fit: BoxFit.fill,
//                                 ),
//                                 SizedBox(width: 6.w),
//
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       CommonViews().customText(
//                                         textContent:
//                                         controller.notificationBody(item),
//                                         fontSize: 16.sp,
//                                         textAlign: TextAlign.start,
//                                         maxLines: 2,
//                                         fontWeight: FontWeight.w700,
//                                         textColor: Colors.black,
//                                       ),
//
//                                       SizedBox(height: 1.h),
//
//                                       if (item.createdAt != null)
//                                         CommonViews().customText(
//                                           textContent:
//                                           formatDate(item.createdAt!),
//                                           fontSize: 15.sp,
//                                           textAlign: TextAlign.start,
//                                           maxLines: 1,
//                                           fontWeight: FontWeight.w500,
//                                           textColor: Colors.black26,
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildShimmer() {
//     return ListView.builder(
//       itemCount: 6,
//       itemBuilder: (_, __) {
//         return Shimmer.fromColors(
//           baseColor: Colors.grey.shade300,
//           highlightColor: Colors.grey.shade100,
//           child: Container(
//             margin: const EdgeInsets.symmetric(vertical: 6),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 color: AppColors.borderTextFieldColor,
//                 width: 2,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 14.w,
//                   height: 7.h,
//                   color: Colors.white,
//                 ),
//                 SizedBox(width: 6.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         height: 12,
//                         width: double.infinity,
//                         color: Colors.white,
//                       ),
//                       SizedBox(height: 8),
//                       Container(
//                         height: 10,
//                         width: 40.w,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   String formatDate(DateTime date) {
//     final langCode = AppLocale().currentLocale.languageCode;
//
//     if (langCode == 'ar') {
//       return DateFormat('d MMMM yyyy', 'ar').format(date);
//     } else {
//       return DateFormat('MMMM d, yyyy', 'en').format(date);
//     }
//   }
//
// }
