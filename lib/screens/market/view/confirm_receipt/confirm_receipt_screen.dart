import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class ConfirmReceiptScreen extends StatelessWidget {
  final dynamic item;
  final String buyerName;
  final String transactionDate;

  const ConfirmReceiptScreen({
    super.key,
    required this.item,
    required this.buyerName,
    required this.transactionDate,
  });

  @override
  Widget build(BuildContext context) {
    final String assetName = item.name ?? 'Red Sea Hotel';
    final String price = item.price?.toString() ?? '0';

    return CommonBackground(
      showAppBar: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
        child: Column(
          children: [
            /// TITLE
            CommonViews().customText(
              textContent: 'Confirm Receipt',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              textColor: AppColors.buttonColor,
            ),

            SizedBox(height: 3.h),

            /// INFO CARD
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
                children: [
                  _infoRow('Asset Name', assetName),
                  SizedBox(height: 1.2.h),
                  _infoRow('Agreed Price', price),
                  SizedBox(height: 1.2.h),
                  _infoRow('Buyer', buyerName),
                  SizedBox(height: 1.2.h),
                  _infoRow('Transaction Date', transactionDate),
                ],
              ),
            ),

            SizedBox(height: 4.h),

            /// MESSAGE
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppColors.buttonColor.withAlpha(20),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CommonViews().customText(
                textContent:
                'Please confirm that you have received the payment from the buyer. '
                    'Once confirmed, ownership of the asset will be transferred to the buyer immediately within the app.',
                textColor: AppColors.darkBrandColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.start,
                fontSize: 16.5.sp,
              ),
            ),

            const Spacer(),

            /// BUTTON
            CommonViews().customButton(
              onTap: () {
                // TODO:
                // 1) transfer asset ownership to buyer
                // 2) remove asset from marketplace if still visible
                // 3) notify buyer that they are the new owner
                AppNavigator.of(context).pop();

                Get.snackbar(
                  'Receipt Confirmed',
                  'The asset ownership has been transferred to the buyer.',
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
              width: double.infinity,
              child: CommonViews().customText(
                textContent: 'Confirm Receipt',
                textColor: AppColors.darkBrandColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
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
          width: 30.w,
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