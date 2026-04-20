import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/market_place/controller/market_place_controller.dart';
import 'package:money_maker/screens/market_place/model/market_place_response.dart';
import 'package:money_maker/widgets/app_cached_image.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class PurchaseRequestConfirmationScreen extends StatelessWidget {
  final MarketItem item;
  final int quantity;

  PurchaseRequestConfirmationScreen({
    super.key,
    required this.item,
    required this.quantity,
  });

  final MarketPlaceController controller = Get.find<MarketPlaceController>();

  @override
  Widget build(BuildContext context) {
    final String assetName =
        item.assetName.isNotEmpty ? item.assetName : 'Asset';
    final double totalPrice = item.price * quantity;
    final String imageUrl = item.image;

    return CommonBackground(
      showAppBar: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
        child: Column(
          children: [
            CommonViews().customText(
              textContent: S.of(context).confirmPurchase,
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

                  _infoRow(S.of(context).assetName, assetName),
                  SizedBox(height: 1.2.h),
                  _infoRow(
                    S.of(context).pricePerCopy,
                    '\$${item.price.toStringAsFixed(2)}',
                  ),
                  SizedBox(height: 1.2.h),
                  _infoRow(S.of(context).quantity, quantity.toString()),
                  SizedBox(height: 1.2.h),
                  _infoRow(S.of(context).totalPriceCon, '\$${totalPrice.toStringAsFixed(2)}'),
                  SizedBox(height: 1.2.h),
                  _infoRow(S.of(context).type, item.type),
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
                textContent: S.of(context).confirmPurchaseMessage(
                  quantity,
                  assetName,
                  totalPrice.toStringAsFixed(2),
                ),
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
                      textContent: S.of(context).cancel,
                      textColor: AppColors.darkBrandColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: CommonViews().customButton(
                    onTap: () {
                      AppNavigator.of(context).pop();
                      controller.buyAssets(
                        assetId: '',
                        copyCount: quantity.toString(),
                        saleOfferId: item.id.toString(),
                      );
                    },
                    color: AppColors.buttonColor,
                    border: 50,
                    elevation: 4,
                    shadowColor: Colors.black,
                    child: CommonViews().customText(
                      textContent: S.of(context).confirm,
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
          width: 28.w,
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
