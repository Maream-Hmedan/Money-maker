import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/transaction_history/controller/transaction_history_controller.dart';
import 'package:money_maker/screens/transaction_history/model/transaction_history_response.dart';
import 'package:money_maker/widgets/app_cached_image.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TransactionHistoryController());

    return CommonBackground(
      showAppBar: true,
      child: Column(
        children: [
          Image.asset(
            appLogo,
            width: AppSize.logoWidthCommon,
            height: AppSize.logoHeightCommon,
            fit: BoxFit.cover,
          ),
          CommonViews().customText(
            textContent: S.of(context).payment,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),
          SizedBox(height: 1.h),

          Expanded(
            child: GetBuilder<TransactionHistoryController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const _TransactionHistoryShimmer();
                }

                if (controller.isError) {
                  return _StateView(
                    icon: Icons.error_outline_rounded,
                    title: S.of(context).failedToLoadTransactions,
                    subtitle: controller.errorMessage,
                    buttonText: S.of(context).tryAgain,
                    onTap: controller.getTransactionHistory,
                  );
                }

                if (controller.isEmpty) {
                  return _StateView(
                    icon: Icons.receipt_long_outlined,
                    title: S.of(context).noTransactionsYet,
                    subtitle:
                        S
                            .of(context)
                            .yourCompletedPurchasesWillAppearHereOnceAvailable,
                    buttonText: S.of(context).refresh,
                    onTap: controller.getTransactionHistory,
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.orders.length,
                  separatorBuilder: (_, __) => SizedBox(height: 1.6.h),
                  itemBuilder: (context, index) {
                    final order = controller.orders[index];
                    return _TransactionCard(order: order);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final Order order;

  const _TransactionCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final displayName = order.displayUserName;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.borderTextFieldColor, width: 1.2),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCachedImage(
            url: order.hasValidImage ? order.assetImage! : '',
            width: 18.w,
            height: 18.w,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(12),

            errorWidget: Container(
              width: 18.w,
              height: 18.w,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported),
            ),
          ),

          SizedBox(width: 4.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonViews().customText(
                  textContent: order.assetName ?? 'Unknown Asset',
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.black,
                ),

                SizedBox(height: .6.h),

                CommonViews().customText(
                  textContent: S.of(context).transactionCopies(
                    _getTranslatedType(context, order.type),
                    order.copyCount ?? 0,
                  ),
                  fontSize: 15.5.sp,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.black87,
                ),

                SizedBox(height: .6.h),

                if (displayName.isNotEmpty)
                  CommonViews().customText(
                    textContent: S.of(context).byUser(displayName),
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w400,
                    textColor: Colors.black54,
                  ),
              ],
            ),
          ),

          SizedBox(width: 2.w),

          CommonViews().customText(
            textContent: '\$${order.priceAsDouble.toStringAsFixed(2)}',
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),
        ],
      ),
    );
  }


  String _getTranslatedType(BuildContext context, String? type) {
    switch (type?.toLowerCase()) {
      case 'buy':
        return S.of(context).buy;
      case 'sell':
        return S.of(context).sell;
      case 'buy_offer':
        return S.of(context).buyOffer;
      default:
        return type ?? '';
    }
  }

}

class _StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;

  const _StateView({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 70, color: AppColors.buttonColor),
            SizedBox(height: 2.h),
            CommonViews().customText(
              textContent: title,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              textColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            CommonViews().customText(
              textContent: subtitle,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              textColor: Colors.black54,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            SizedBox(height: 2.5.h),
            SizedBox(
              width: 45.w,
              child: CommonViews().customButton(
                onTap: onTap,
                color: AppColors.buttonColor,
                borderColor: AppColors.buttonColor,
                border: 14,
                child: CommonViews().customText(
                  textContent: buttonText,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionHistoryShimmer extends StatelessWidget {
  const _TransactionHistoryShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 1.6.h),
      itemBuilder: (_, __) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14, width: 40.w, color: Colors.white),
                      SizedBox(height: 1.h),
                      Container(height: 12, width: 28.w, color: Colors.white),
                      SizedBox(height: 1.h),
                      Container(height: 12, width: 24.w, color: Colors.white),
                      SizedBox(height: 1.h),
                      Container(height: 10, width: 35.w, color: Colors.white),
                    ],
                  ),
                ),
                SizedBox(width: 3.w),
                Container(height: 14, width: 14.w, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}
