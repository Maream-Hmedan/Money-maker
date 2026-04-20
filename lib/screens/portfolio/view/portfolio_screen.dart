// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/home/widget/portfolio_value/portfolio_value_controller.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/screens/market_place/view/market_place_screen.dart';
import 'package:money_maker/screens/portfolio/controller/portfolio_controller.dart';
import 'package:money_maker/screens/portfolio/model/portfolio_response.dart';
import 'package:money_maker/widgets/app_cached_image.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:money_maker/widgets/text_field_widget.dart';

import 'package:sizer/sizer.dart';

class PortfolioScreen extends StatelessWidget {
  final bool showAppBar;

  PortfolioScreen({super.key, required this.showAppBar});

  final PortfolioController controller = Get.put(PortfolioController());
  final PortfolioValueController portfolioValueController =
      Get.find<PortfolioValueController>();

  void _showSellDialog(BuildContext context, Portfolio item) {
    final qtyController = TextEditingController(text: '1');
    final priceController = TextEditingController(
      text: item.price.toStringAsFixed(2),
    );

    final qtyFocus = FocusNode();
    final priceFocus = FocusNode();

    qtyFocus.addListener(() {
      if (!qtyFocus.hasFocus) {
        final qty = int.tryParse(qtyController.text) ?? 0;
        if (qty < 1) {
          qtyController.text = '1';
        }
      }
    });

    priceFocus.addListener(() {
      if (!priceFocus.hasFocus) {
        final price = double.tryParse(priceController.text) ?? 0;
        if (price < 1) {
          priceController.text = '1';
        }
      }
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkBrandColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          actionsPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFFB703).withAlpha(35),
                ),
                child: const Icon(Icons.sell_rounded, color: Color(0xFFFFCC80)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CommonViews().customText(
                  textContent: S.of(context).listForSale(item.name),
                  textColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white.withAlpha(12),
                  border: Border.all(color: Colors.white.withAlpha(26)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.inventory_2_rounded,
                      color: const Color(0xFFFFCC80),
                      size: 18.sp,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: CommonViews().customText(
                        textContent: S
                            .of(context)
                            .availableCopiesToList(item.restCopyCount),
                        textColor: Colors.white70,
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              TextFieldWidget(
                controller: qtyController,
                focusNode: qtyFocus,
                keyboardType: TextInputType.number,
                label: S.of(context).quantity,
                borderColor: Colors.white.withAlpha(102),
                textColor: Colors.white,
                hintColor: Colors.white70,
                radius: 12,
                inputAction: TextInputAction.next,
              ),
              SizedBox(height: 2.h),
              TextFieldWidget(
                controller: priceController,
                focusNode: priceFocus,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                label: S.of(context).sellingPrice,
                borderColor: Colors.white.withAlpha(102),
                textColor: Colors.white,
                hintColor: Colors.white70,
                radius: 12,
                inputAction: TextInputAction.done,
              ),
              SizedBox(height: 1.5.h),
              CommonViews().customText(
                textContent:
                    S.of(context).youCanListFewerCopiesAndChooseAnySellingPrice,
                textColor: Colors.white.withAlpha(191),
                fontSize: 14.sp,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => AppNavigator.of(context).pop(),
              child: CommonViews().customText(
                textContent: S.of(context).cancel,
                textColor: Colors.white70,
                fontSize: 15.sp,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFB703),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final qty = int.tryParse(qtyController.text) ?? 0;
                final price = double.tryParse(priceController.text) ?? 0;

                if (qty < 1 || qty > item.restCopyCount) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title:
                        qty < 1
                            ? S.of(context).invalidQuantity
                            : S.of(context).quantityExceedsOwnership,
                    desc:
                        qty < 1
                            ? S.of(context).quantityMustBeAtLeast1
                            : S
                                .of(context)
                                .quantityExceedsOwnershipN(
                                  item.restCopyCount.toString(),
                                ),
                    btnOkOnPress: () {},
                           btnOkText: S
              .of(Get.context!)
              .ok,
                    btnOkColor: Colors.red,
                  ).show();
                  return;
                }

                if (price < 1) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title: S.of(context).invalidPrice,
                    desc: S.of(context).priceMustBeAtLeast1,
                    btnOkOnPress: () {},
                           btnOkText: S
              .of(Get.context!)
              .ok,
                    btnOkColor: Colors.red,

                  ).show();
                  return;
                }

                AppNavigator.of(context).pop();

                controller.sellPortfolio(
                  assetId: item.id.toString(),
                  copyCount: qty.toString(),
                  price: price,
                );
              },
              child: CommonViews().customText(
                textContent: S.of(context).confirm,
                textColor: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showCancelSaleDialog(BuildContext context, Portfolio item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkBrandColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
          contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withAlpha(35),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.remove_shopping_cart_rounded,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CommonViews().customText(
                  textContent: S.of(context).cancelSale,
                  textColor: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(10),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonViews().customText(
                      textContent: S
                          .of(context)
                          .unitsListedInMarket(item.saleCopyCount),
                      textColor: Colors.white,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 1.h),
                    CommonViews().customText(
                      textContent:
                          S
                              .of(context)
                              .youCanCancelThisSaleBeforeAnotherPlayerBuysIt,
                      textColor: Colors.white70,
                      fontSize: 14.sp,
                    ),
                    SizedBox(height: .8.h),
                    CommonViews().customText(
                      textContent:
                          S
                              .of(context)
                              .onceCancelledThisAssetWillReturnToYourPortfolio,
                      textColor: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),

          /// 🔥 BUTTONS
          actions: [
            Row(
              children: [
                /// OK BUTTON
                Expanded(
                  child: TextButton(
                    onPressed: () => AppNavigator.of(context).pop(),
                    child: CommonViews().customText(
                      textContent: S.of(context).ok,
                      textColor: Colors.white70,
                      fontSize: 15.sp,
                    ),
                  ),
                ),

                SizedBox(width: 3.w),

                /// GO TO MARKETPLACE BUTTON
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      AppNavigator.of(context).pop();

                      AppNavigator.of(
                        context,
                        rootNavigator: true,
                      ).pushReplacement(
                        MarketPlaceScreen(initialIsMineFilter: true),
                      );
                    },
                    child: CommonViews().customText(
                      textContent: S.of(context).goToMarketplace,
                      textColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMiniChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(35),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withAlpha(160)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18.sp),
          SizedBox(width: 1.w),
          CommonViews().customText(
            textContent: label,
            textColor: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onTap,
    required Color color,
    required Color borderColor,
    double? width,
    double height = 42,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(60),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 17.sp),
              const SizedBox(width: 6),
            ],
            CommonViews().customText(
              textContent: text,
              textColor: Colors.white,
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w800,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetCard(BuildContext context, Portfolio p, NumberFormat fmt) {
    final totalAssetValue = p.price * p.totalCopyCount;
    final hasActiveSale = p.saleCopyCount > 0;
    final canSellMore = p.restCopyCount > 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withAlpha(8),
        border: Border.all(
          color:
              hasActiveSale
                  ? const Color(0xFFFFCC80).withAlpha(180)
                  : Colors.white.withAlpha(25),
          width: 1.2,
        ),
        boxShadow:
            hasActiveSale
                ? [
                  BoxShadow(
                    color: const Color(0xFFFFB703).withAlpha(24),
                    blurRadius: 18,
                    spreadRadius: 1,
                    offset: const Offset(0, 6),
                  ),
                ]
                : [],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCachedImage(
                url: p.image,
                height: 9.h,
                width: 19.w,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(14),
                errorWidget: Container(
                  height: 9.h,
                  width: 19.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.white54,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonViews().customText(
                      textContent: p.name,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.whiteColor,
                      fontSize: 17.sp,
                    ),
                    SizedBox(height: 0.45.h),
                    CommonViews().customText(
                      textContent: S.of(context).typeLabel(p.type),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5.sp,
                      textColor: Colors.white70,
                    ),
                    SizedBox(height: 0.45.h),
                    CommonViews().customText(
                      textContent: S.of(context).ownedCopies(p.totalCopyCount),
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp,
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 0.35.h),
                    CommonViews().customText(
                      textContent: S
                          .of(context)
                          .availableToSell(p.restCopyCount),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.2.sp,
                      textColor: Colors.white70,
                    ),
                    SizedBox(height: 0.35.h),
                    CommonViews().customText(
                      textContent: S.of(context).unitPrice(fmt.format(p.price)),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5.sp,
                      textColor: AppColors.whiteColor,
                    ),
                    SizedBox(height: 0.35.h),
                    CommonViews().customText(
                      textContent: S
                          .of(context)
                          .totalPrice(fmt.format(totalAssetValue)),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5.sp,
                      textColor: const Color(0xFFFFCC80),
                    ),
                    SizedBox(height: 0.35.h),
                    CommonViews().customText(
                      textContent: '▲ ${fmt.format(p.priceGrowthRate)}%',
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      textColor: Colors.greenAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (hasActiveSale) ...[
            SizedBox(height: 1.4.h),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF7AA8), Color(0xFFFFB703)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF7AA8).withAlpha(70),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer_rounded,
                    color: AppColors.whiteColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 2.4.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonViews().customText(
                          textContent: S
                              .of(context)
                              .copiesOnSale(p.saleCopyCount),
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: 0.2.h),
                        CommonViews().customText(
                          textContent:
                              S.of(context).youCanCancelTheSaleAtAnyTime,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.4.h),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildMiniChip(
                  icon: Icons.storefront_rounded,
                  label: S.of(context).onSaleLabel(p.saleCopyCount),
                  color: const Color(0xFFFF7AA8),
                ),
                _buildMiniChip(
                  icon: Icons.inventory_2_rounded,
                  label: S.of(context).availableLabel(p.restCopyCount),
                  color: const Color(0xFFFFB703),
                ),
              ],
            ),
          ],

          SizedBox(height: 1.6.h),
          Row(
            children: [
              if (canSellMore)
                Expanded(
                  child: _buildActionButton(
                    text:
                        hasActiveSale
                            ? S.of(context).sellMore
                            : S.of(context).sell,
                    icon: Icons.sell_rounded,
                    color: const Color(0xFFFFB703),
                    borderColor: const Color(0xFFFFCC80),
                    onTap: () => _showSellDialog(context, p),
                  ),
                ),
              if (canSellMore && hasActiveSale) SizedBox(width: 3.w),
              if (hasActiveSale)
                Expanded(
                  child: _buildActionButton(
                    text: S.of(context).cancelSale,
                    icon: Icons.remove_shopping_cart_rounded,
                    color: Colors.redAccent,
                    borderColor: Colors.orangeAccent,
                    onTap: () => _showCancelSaleDialog(context, p),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,##0.00');

    return CommonBackground(
      showAppBar: showAppBar,
      child: GetBuilder<PortfolioController>(
        builder: (controller) {
          return  RefreshIndicator(
            onRefresh: () async {
              await controller.getPortfolio();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      appLogo,
                      width: AppSize.logoWidthCommon,
                      height: 15.5.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 2.h),
                    (controller.apiStatus == ApiStatus.guest)?SizedBox.shrink():
                    Container(
                      width: 90.w,
                      padding: EdgeInsets.symmetric(
                        vertical: 2.h,
                        horizontal: 5.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.darkBrandColor,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color(0xFFFFCC80),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFB703).withAlpha(24),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CommonViews().customText(
                            textContent: S.of(context).portfolioValue,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.white70,
                            fontSize: 16.sp,
                          ),
                          SizedBox(height: 0.8.h),
                          GetBuilder<PortfolioValueController>(
                            builder: (valueController) {
                              return CommonViews().customText(
                                textContent:
                                    '\$${fmt.format(valueController.portfolioValue)}',
                                fontWeight: FontWeight.bold,
                                textColor: Colors.white,
                                fontSize: 22.sp,
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 2.h),
                    if (controller.apiStatus == ApiStatus.loading)
                      Container(
                        width: 90.w,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.darkBrandColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.buttonColor,
                          ),
                        ),
                      )
                    else if (controller.apiStatus == ApiStatus.guest)
                      Container(
                        width: 90.w,
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 5.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.darkBrandColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock, color: Colors.orange, size: 30.sp),
                            SizedBox(height: 2.h),
                            CommonViews().customText(
                              textContent: S.of(context).membersOnly,
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                            SizedBox(height: 1.h),
                            CommonViews().customText(
                              textContent:
                                  S.of(context).logInOrSignUpToAccessYourPortfolioAnd,
                              textColor: Colors.white70,
                              fontSize: 15.sp,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 2.h),
                            CommonViews().customContainer(
                              child: Center(
                                child: CommonViews().customText(
                                  textContent: S.of(context).getStarted,
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              color: const Color(0xFFFFA726),
                              radius: 12,
                              onTap: () {
                                AppNavigator.of(context).pushAndRemoveUntil(LoginScreen());
                              },
                              width: 40.w,
                              colorBorder: const Color(0xFFFFCC80),
                            ),
                          ],
                        ),
                      )
                    else if (controller.apiStatus == ApiStatus.error)
                      Container(
                        width: 90.w,
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 5.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.darkBrandColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          children: [
                            CommonViews().customText(
                              textContent: controller.errorMessage,
                              textColor: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 2.h),
                            CommonViews().customContainer(
                              child: Center(
                                child: CommonViews().customText(
                                  textContent: S.of(context).retry,
                                  textColor: AppColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              color: const Color(0xFFFFB703),
                              radius: 12,
                              onTap: controller.getPortfolio,
                              width: 35.w,
                              colorBorder: const Color(0xFFFFCC80),
                            ),
                          ],
                        ),
                      )
                    else if (controller.apiStatus == ApiStatus.empty)
                      Container(
                        width: 90.w,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.darkBrandColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: CommonViews().customText(
                            textContent: S.of(context).noPortfolioDataFound,
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: AppColors.darkBrandColor,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 2.5.h,
                                horizontal: 5.w,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFB703),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                                border: Border.all(
                                  color: const Color(0xFFFFCC80),
                                  width: 3,
                                ),
                              ),
                              child: CommonViews().customText(
                                textContent: S.of(context).portfolio,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.white,
                                fontSize: 19.sp,
                              ),
                            ),
                            ...controller.portfolioList.map(
                              (p) => _buildAssetCard(context, p, fmt),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
