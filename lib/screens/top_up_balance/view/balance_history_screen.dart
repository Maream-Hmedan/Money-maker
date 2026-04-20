import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/top_up_balance/controller/top_up_controller.dart';
import 'package:money_maker/screens/top_up_balance/model/balance_history_response.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class BalanceHistoryScreen extends StatefulWidget {
  const BalanceHistoryScreen({super.key});

  @override
  State<BalanceHistoryScreen> createState() => _BalanceHistoryScreenState();
}

class _BalanceHistoryScreenState extends State<BalanceHistoryScreen> {
  late final TopUpController controller;

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<TopUpController>()) {
      controller = Get.find<TopUpController>();
    } else {
      controller = Get.put(TopUpController());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getBalanceHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: Column(
        children: [
          CommonViews().customText(
            textContent: S.of(context).balanceHistory,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: GetBuilder<TopUpController>(
              builder: (controller) {
                if (controller.status == ApiStatus.loading) {
                  return _buildLoading();
                }

                if (controller.status == ApiStatus.error) {
                  return _buildError(controller);
                }

                if (controller.status == ApiStatus.empty) {
                  return _buildEmpty();
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.transaction.length,
                  itemBuilder: (context, index) {
                    final item = controller.transaction[index];
                    return _transactionCard(item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.buttonColor,
      ),
    );
  }

  Widget _buildError(TopUpController controller) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 40,
              color: Colors.red.shade400,
            ),
            SizedBox(height: 1.5.h),
            CommonViews().customText(
              textContent: controller.errorMessage.isNotEmpty
                  ? controller.errorMessage
                  : S.of(context).somethingWentWrongPleaseTryAgain,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: Colors.black87,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: 45.w,
              child: CommonViews().customButton(
                onTap: () {
                  controller.getBalanceHistory();
                },
                border: 30,
                color: AppColors.buttonColor,
                child: CommonViews().customText(
                  textContent: S.of(context).retry,
                  fontSize: 15.sp,
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

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: CommonViews().customText(
          textContent: S.of(context).noBalanceHistoryAvailable,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          textColor: Colors.black87,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _transactionCard(Transaction item) {
    final bool isCredit = item.type == TransactionType.CREDIT;
    final Color accentColor = isCredit ? Colors.green : Colors.red;
    final IconData icon =
    isCredit ? Icons.add_circle_rounded : Icons.remove_circle_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: accentColor.withAlpha(45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withAlpha(18),
                ),
                child: Icon(
                  icon,
                  color: accentColor,
                  size: 24,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonViews().customText(
                      textContent: isCredit
                          ? S.of(context).creditTransaction
                          : S.of(context).debitTransaction,
                      fontSize: 16.5.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                    ),
                    SizedBox(height: 0.4.h),
                    CommonViews().customText(
                      textContent: _translateDetails(item.details),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      textColor: Colors.black54,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 0.8.h,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    CommonViews().customText(
                      textContent: '${isCredit ? '+' : '-'}${item.amount}',
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.w800,
                      textColor: accentColor,
                    ),
                    SizedBox(width: 1.w),
                    Image.asset(
                      "assets/images/coin.png",
                      width: 18,
                      height: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 1.6.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 3.w,
              vertical: 1.2.h,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                _infoRow(
                  title: S.of(context).transactionType,
                  value: isCredit
                      ? S.of(context).credit
                      : S.of(context).debit,
                ),
                SizedBox(height: 1.h),
                _infoRow(
                  title: S.of(context).date,
                  value: _formatDate(item.createdAt),
                ),
                if (item.orderId != null) ...[
                  SizedBox(height: 1.h),
                  _infoRow(
                    title: S.of(context).orderId,
                    value: item.orderId.toString(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Expanded(
          child: CommonViews().customText(
            textContent: title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            textColor: Colors.black54,
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: CommonViews().customText(
            textContent: value,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            textColor: Colors.black87,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  String _translateDetails(TransactionDetails details) {
    switch (details) {
      case TransactionDetails.CHARGE_USER_BALANCE:
        return S.of(context).chargeUserBalance;
      case TransactionDetails.ASSET_IS_BOUGHT:
        return S.of(context).assetBought;
      case TransactionDetails.ASSET_IS_SOLD:
        return S.of(context).assetSold;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} - ${_formatTime(date)}';
  }

  String _formatTime(DateTime date) {
    final int hour = date.hour > 12
        ? date.hour - 12
        : date.hour == 0
        ? 12
        : date.hour;

    final String minute = date.minute.toString().padLeft(2, '0');
    final String period =
    date.hour >= 12 ? S.of(context).pm : S.of(context).am;

    return '$hour:$minute $period';
  }
}