import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/home/widget/balance_value/balance_value_controller.dart';
import 'package:money_maker/screens/top_up_balance/controller/top_up_controller.dart';
import 'package:money_maker/screens/top_up_balance/view/balance_history_screen.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class BalanceTopUpScreen extends StatefulWidget {
  const BalanceTopUpScreen({super.key});

  @override
  State<BalanceTopUpScreen> createState() => _BalanceTopUpScreenState();
}

class _BalanceTopUpScreenState extends State<BalanceTopUpScreen> {
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TopUpController _topUpController = Get.put(TopUpController());
  String selectedPaymentMethod = "apple_pay";
  final BalanceValueController balanceValueController =
      Get.find<BalanceValueController>();
  bool showTopUpSection = false;
  final fmt = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CommonViews().customText(
              textContent: S.of(context).topUpYourBalance,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              textColor: AppColors.buttonColor,
            ),
            SizedBox(height: 2.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Column(
                children: [
                  _balanceCard(),
                  SizedBox(height: 1.5.h),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.of(context).push( BalanceHistoryScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.buttonColor.withAlpha(80),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.history,
                                color: AppColors.buttonColor,
                                size:19.sp,
                              ),
                              SizedBox(width: 2.w),
                              CommonViews().customText(
                                textContent: S.of(context).balanceHistory,
                                fontSize: 15.5.sp,
                                fontWeight: FontWeight.w600,
                                textColor: Colors.black,
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.sp,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 1.5.h),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child:
                        showTopUpSection
                            ? Form(
                              key: _formKey,
                              child: Column(
                                key: const ValueKey("topup_section"),
                                children: [
                                  _amountField(),
                                  SizedBox(height: 2.5.h),
                                  _paymentMethods(),
                                ],
                              ),
                            )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkBrandColor,
            AppColors.borderTextFieldColor,
            AppColors.highlightColor,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF7AA8).withAlpha(64),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: Colors.white.withAlpha(64), width: 1.2),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white.withAlpha(46), Colors.white.withAlpha(10)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Column(
            children: [
              Container(
                width: 19.w,
                height: 19.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withAlpha(38),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withAlpha(46),
                      blurRadius: 18,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    "assets/images/coin.png",
                    height: 8.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: 1.8.h),

              CommonViews().customText(
                textContent: S.of(context).totalBalance,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                textColor: Colors.white70,
              ),

              SizedBox(height: 0.6.h),

              GetBuilder<BalanceValueController>(
                builder: (controller) {
                  return CommonViews().customText(
                    textContent: '\$${fmt.format(controller.balanceValue)}',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w800,
                    textColor: Colors.white,
                  );
                },
              ),

              SizedBox(height: 0.8.h),

              CommonViews().customText(
                textContent: S.of(context).availableToTopUpInstantly,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                textColor: Colors.white60,
              ),

              SizedBox(height: 2.2.h),

              GestureDetector(
                onTap: () {
                  setState(() {
                    showTopUpSection = !showTopUpSection;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0x66FFFFFF), Color(0x33FFFFFF)],
                    ),
                    border: Border.all(
                      color: Colors.white.withAlpha(77),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withAlpha(26),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        showTopUpSection
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.add_circle_outline_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                      SizedBox(width: 2.w),
                      CommonViews().customText(
                        textContent:
                            showTopUpSection
                                ? S.of(context).hideTopUp
                                : S.of(context).topUp,
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _amountField() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.buttonColor.withAlpha(153)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonViews().customText(
            textContent: S.of(context).enterAmount,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            textColor: Colors.black,
          ),
          SizedBox(height: 1.2.h),
          TextFormField(
            controller: amountController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            enableInteractiveSelection: false,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hint: Align(
                alignment:
                    AppLocale().isArabic()
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                child: Text(
                  S.of(context).enterAmount,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Futura',
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset("assets/images/coin.png", width: 22),
              ),
              filled: true,
              fillColor: const Color(0xFFF8F8FC),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: AppColors.buttonColor.withAlpha(102),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: AppColors.buttonColor,
                  width: 1.5,
                ),
              ),
            ),
            autovalidateMode: AutovalidateMode.disabled,
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return S.of(context).pleaseEnterAnAmount;
              }

              final value = double.tryParse(v);

              if (value == null || value <= 0) {
                return S.of(context).pleaseEnterAValidAmountGreaterThan0;
              }

              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _paymentMethods() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.buttonColor.withAlpha(153)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonViews().customText(
            textContent: S.of(context).paymentMethod,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            textColor: Colors.black,
          ),
          SizedBox(height: 1.5.h),

          _paymentCard(
            title: S.of(context).applePay,
            subtitle: S.of(context).fastAndSecurePayment,
            icon: Icons.apple,
            value: "apple_pay",
          ),

          SizedBox(height: 1.4.h),

          _paymentCard(
            title: S.of(context).visa,
            subtitle: S.of(context).payWithYourCard,
            icon: Icons.credit_card_rounded,
            value: "visa",
          ),

          SizedBox(height: 2.5.h),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5C2E91),
                  Color(0xFFFF7AA8),
                  AppColors.buttonColor,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF7AA8).withAlpha(56),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: CommonViews().customButton(
              child: CommonViews().customText(
                textContent: S.of(context).confirmTopUp,
                fontSize: 15.5.sp,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
              ),
              color: Colors.transparent,
              borderColor: Colors.transparent,
              border: 16,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  _topUpController.topUpBalance(
                    amount: amountController.text.trim(),
                    method: selectedPaymentMethod,
                    onSuccess: () {
                      setState(() {
                        showTopUpSection = false;
                        amountController.clear();
                        selectedPaymentMethod = "apple_pay";
                      });
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final bool isSelected = selectedPaymentMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isSelected
                    ? AppColors.buttonColor.withAlpha(128)
                    : AppColors.buttonColor.withAlpha(51),
            width: 1.4,
          ),
          gradient:
              isSelected
                  ? LinearGradient(
                    colors: [
                      const Color(0xFFFF7AA8).withAlpha(26),
                      const Color(0xFF5C2E91).withAlpha(15),
                    ],
                  )
                  : null,
          color: isSelected ? null : const Color(0xFFF9F9FD),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: const Color(0xFFFF7AA8).withAlpha(26),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient:
                    isSelected
                        ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF5C2E91), Color(0xFFFF7AA8)],
                        )
                        : LinearGradient(
                          colors: [Colors.grey.shade200, Colors.grey.shade100],
                        ),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonViews().customText(
                    textContent: title,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black,
                  ),
                  SizedBox(height: 0.3.h),
                  CommonViews().customText(
                    textContent: subtitle,
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.black54,
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_off_rounded,
              color: isSelected ? AppColors.buttonColor : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

}
