import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/widgets/app_cached_image.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class PurchaseRequestConfirmationScreen extends StatelessWidget {
  final dynamic item;

  const PurchaseRequestConfirmationScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final String assetName = item.name ?? 'Red Sea Hotel';
    final String sellerName = item.ownerName ?? 'Seller';
    final String price = item.price?.toString() ?? '0';
    final String? imageUrl = item.image;

    return CommonBackground(
      showAppBar: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
        child: Column(
          children: [
            /// TITLE
            CommonViews().customText(
              textContent: 'Confirm Purchase',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              textColor: AppColors.buttonColor,
            ),

            SizedBox(height: 2.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCachedImage(
                    url: imageUrl,
                    width: double.infinity,
                    height: 22.h,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(18),
                  ),

                  SizedBox(height: 2.h),

                  _infoRow('Asset Name', assetName),
                  SizedBox(height: 1.2.h),
                  _infoRow('Price', price),
                  SizedBox(height: 1.2.h),
                  _infoRow('Seller', sellerName),
                ],
              ),
            ),

            SizedBox(height: 3.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppColors.buttonColor.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CommonViews().customText(
                textContent:
                'Are you sure you want to buy this asset for $price?\n\n'
                    'After confirmation, the seller will be notified that there is a purchase request awaiting approval. '
                    'Payment is made outside the app, and no amount will be deducted from your balance directly.',
                textColor: AppColors.darkBrandColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                fontSize: 16.5.sp,
              ),
            ),

            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: CommonViews().customButton(
                    onTap: () {
                      AppNavigator.of(context).pop();
                    },
                    color: Colors.grey.shade200,
                    border: 50,
                    elevation: 0,
                    child: CommonViews().customText(
                      textContent: 'Cancel',
                      textColor: AppColors.darkBrandColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: CommonViews().customButton(
                    onTap: () {
                      // TODO:
                      // 1) send notification to seller
                      // 2) freeze/hide asset temporarily from marketplace
                      // 3) create purchase request with pending status
                      AppNavigator.of(context).pop();

                      Get.snackbar(
                        'Request Sent',
                        'The seller has been notified of your purchase request.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                        margin: EdgeInsets.all(3.w),
                        borderRadius: 12,
                      );
                    },
                    color: AppColors.buttonColor,
                    border: 50,
                    elevation: 4,
                    shadowColor: Colors.black,
                    child: CommonViews().customText(
                      textContent: 'Confirm',
                      textColor: AppColors.darkBrandColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24.w,
          child: CommonViews().customText(
            textContent: '$title:',
            textColor: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
            fontSize: 15.5.sp,
          ),
        ),
        Expanded(
          child: CommonViews().customText(
            textContent: value,
            textColor: AppColors.darkBrandColor,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}