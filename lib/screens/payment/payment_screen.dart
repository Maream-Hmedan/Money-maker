import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
              textContent: "Confirm Receipt of \nPayment",
              fontSize: 20.sp,
              textAlign: TextAlign.center,
              maxLines: 2,
              fontWeight: FontWeight.w700,
              textColor: AppColors.buttonColor,
            ),
            SizedBox(height: 2.h),
            CommonViews().customText(
              textContent:
                  "You are about to confirm that you received the payment from the buyer.",
              fontSize: 16.sp,
              maxLines: 2,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w700,
              textColor: Colors.black,
            ),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: AppColors.borderTextFieldColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(yacht, height: 7.h, fit: BoxFit.contain),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonViews().customText(
                              textContent: 'Yacht – \$800,000',
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                              textColor: Colors.black,
                            ),
                            CommonViews().customText(
                              textContent: 'Alex Johnson #123456',
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                              textColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  CommonViews().customText(
                    textContent:
                        'This action is irreversible. Please\nconfirm only if you received the full amount.',
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Expanded(
                        child: CommonViews().customButton(
                          child: CommonViews().customText(
                            textContent: 'Confirm',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                          ),
                          borderColor:  Colors.black45,
                          color: Colors.green,
                          border:12,

                          onTap: () {},
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: CommonViews().customButton(
                          child: CommonViews().customText(
                            textContent:  'Cancel',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            textColor: Colors.white,
                          ),
                          borderColor:  Colors.black45,
                          color: Colors.black26,
                          border:12,

                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
