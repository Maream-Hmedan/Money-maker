import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/current_session.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/screens/market/view/purchase_request_confirmation/purchase_request_confirmation_screen.dart';
import 'package:money_maker/screens/market_place/controller/market_place_controller.dart';
import 'package:money_maker/screens/market_place/model/market_place_response.dart';
import 'package:money_maker/widgets/app_cached_image.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MarketPlaceScreen extends StatefulWidget {
  final bool initialIsMineFilter;

  const MarketPlaceScreen({super.key, this.initialIsMineFilter = false});

  @override
  State<MarketPlaceScreen> createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    Get.put(
      MarketPlaceController(initialIsMineFilter: widget.initialIsMineFilter),
    );
    final isGuest = CurrentSession().getUser() == null;
    return  CommonBackground(
      showAppBar: true,
      child: Column(
        children: [
          CommonViews().customText(
            textContent: S.of(context).marketPlace,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),
          SizedBox(height: 1.h),
          CommonViews().customText(
            textContent:
                S
                    .of(context)
                    .discoverRareAssetsFromOtherPlayersSendAPurchaseRequest,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
            textColor: Colors.grey.shade500,
          ),
          SizedBox(height: 1.h),
          if (!isGuest)...[
            GetBuilder<MarketPlaceController>(
              builder: (ctrl) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child:
                  Row(
                    children: [
                      Expanded(
                        child: _MarketFilterButton(
                          text: S.of(context).exploreAssets,
                          isActive: !ctrl.isMineFilter,
                          onTap: () => ctrl.toggleFilter(false),
                        ),
                      ),
    
                      SizedBox(width: 3.w),
                      Expanded(
                        child: _MarketFilterButton(
                          text: S.of(context).myAssets,
                          isActive: ctrl.isMineFilter,
                          onTap: () => ctrl.toggleFilter(true),
                        ),
                      ),
    
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 1.h),
          ],
          Expanded(
            child: GetBuilder<MarketPlaceController>(
              builder: (ctrl) {
                if (ctrl.isLoading) return _buildLoadingView();

                if (ctrl.isError) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      if (ctrl.isMineFilter) {
                        await ctrl.fetchMineMarketPlaceData();
                      } else {
                        await ctrl.fetchMarketPlaceData();
                      }
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Center(
                          child: CommonViews().customText(
                            textContent: S.of(context).errorLoadingData,
                            textColor: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                if (ctrl.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      if (ctrl.isMineFilter) {
                        await ctrl.fetchMineMarketPlaceData();
                      } else {
                        await ctrl.fetchMarketPlaceData();
                      }
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Center(
                          child: CommonViews().customText(
                            textContent: ctrl.isMineFilter
                                ? S.of(context).youDontHaveAnyAssetsListedForSaleInThe
                                : S.of(context).noMarketItemsFound,
                            textColor: AppColors.darkBrandColor,
                            fontSize: 16.sp,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }
    
                return RefreshIndicator(
                  onRefresh: () async {
                    final ctrl = Get.find<MarketPlaceController>();

                    if (ctrl.isMineFilter) {
                      await ctrl.fetchMineMarketPlaceData();
                    } else {
                      await ctrl.fetchMarketPlaceData();
                    }
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: ctrl.items.length,
                    itemBuilder: (context, index) {
                      final item = ctrl.items[index];
                      return TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 350 + (index * 90)),
                        tween: Tween(begin: 0.92, end: 1),
                        curve: Curves.easeOutBack,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value.clamp(0.0, 1.0),
                            child: Transform.translate(
                              offset: Offset(0, (1 - value) * 24),
                              child: Transform.scale(scale: value, child: child),
                            ),
                          );
                        },
                        child: _buildGlowGameCard(context, item),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (Get.isRegistered<MarketPlaceController>()) {
      Get.delete<MarketPlaceController>();
    }
    super.dispose();
  }

  Widget _buildGlowGameCard(BuildContext context, MarketItem item) {
    final isMine = item.isMine;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            AppColors.darkBrandColor.withAlpha(191),
            AppColors.borderTextFieldColor.withAlpha(128),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color:
              isMine
                  ? Colors.orangeAccent.withAlpha(120)
                  : Colors.white.withAlpha(30),
          width: 1.1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(64),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          if (isMine)
            BoxShadow(
              color: Colors.orangeAccent.withAlpha(35),
              blurRadius: 18,
              spreadRadius: 1,
            ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCachedImage(
              url: item.image,
              height: 20.h,
              width: double.infinity,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(16),
            ),
            SizedBox(height: 1.h),
            Text(
              item.assetName.isEmpty ? "No Name" : item.assetName,
              style: TextStyle(
                fontSize: 18.5.sp,
                fontFamily: 'Futura',
                fontWeight: FontWeight.bold,
                foreground:
                    Paint()
                      ..shader = LinearGradient(
                        colors: [Colors.yellow, Colors.orangeAccent],
                      ).createShader(Rect.fromLTWH(0, 0, 200, 0)),
              ),
            ),
            SizedBox(height: 0.8.h),
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CommonViews().customText(
                    textContent: item.type,
                    textColor: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                if (item.ownerName != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person, size: 17.sp, color: Colors.white70),
                        SizedBox(width: 1.w),
                        CommonViews().customText(
                          textContent: item.ownerName!,
                          textColor: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(width: 1.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: CommonViews().customText(
                            textContent: S.of(context).owner,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black87,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CommonViews().customText(
                    textContent: S.of(context).availableLabel(item.copyCount),
                    textColor: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.2.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Colors.amberAccent,
                            size: 18.sp,
                          ),
                          SizedBox(width: 4),
                          CommonViews().customText(
                            textContent: "\$${item.price.toStringAsFixed(2)}",
                            textColor: Colors.amberAccent,
                            fontSize: 15.5.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.priceGrowthRate > 0
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color:
                                item.priceGrowthRate > 0
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                            size: 18.sp,
                          ),
                          const SizedBox(width: 2),
                          CommonViews().customText(
                            textContent:
                                "${item.priceGrowthRate.toStringAsFixed(1)}%",
                            textColor:
                                item.priceGrowthRate > 0
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                            fontSize: 15.5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 3.w),
                _AnimatedMarketActionButton(
                  isMine: isMine,
                  onTap: () {
                    if (CurrentSession().getUser() == null) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.bottomSlide,
                        dismissOnTouchOutside: true,
                        title: S.of(context).startYourInvestmentJourney,
                        desc:
                            S.of(context).logInOrSignUpToUnlockYourBalanceBuild,
                        btnOkText: S.of(context).getStarted,
                        btnOkColor: Colors.orange,
                        btnOkOnPress: () {
                          AppNavigator.of(
                            context,
                          ).pushAndRemoveUntil(LoginScreen());
                        },
                      ).show();

                      return;
                    }
                    if (isMine) {
                      _showCancelSaleDialog(context, item);
                    } else {
                      _showBuyDialog(context, item);
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 1.h),
            CommonViews().customText(
              textContent:
                  item.publishDate != null
                      ? S
                          .of(context)
                          .listedOn(
                            DateFormat('dd/MM/yyyy').format(item.publishDate!),
                          )
                      : S.of(context).recentlyListed,
              textColor: Colors.white70,
              fontSize: 15.5.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _showBuyDialog(BuildContext context, MarketItem item) {
    int quantity = 1;
    String? errorText;

    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(150),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            final total = item.price * quantity;

            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.darkBrandColor,
                      AppColors.borderTextFieldColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(80),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S.of(context).purchaseAsset,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      S.of(context).selectQuantityToPurchase,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15.5.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(20),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.inventory_2, color: AppColors.buttonColor),
                          SizedBox(width: 2.w),
                          Text(
                            '${S.of(context).available} ${item.copyCount}',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(15),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                  errorText = null;
                                });
                              }
                            },
                            child: _circleButton(Icons.remove),
                          ),
                          Text(
                            quantity.toString(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (quantity < item.copyCount) {
                                setState(() {
                                  quantity++;
                                  errorText = null;
                                });
                              } else {
                                setState(() {
                                  errorText = S
                                      .of(context)
                                      .maxAvailable(item.copyCount);
                                });
                              }
                            },
                            child: _circleButton(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    if (errorText != null) ...[
                      SizedBox(height: 1.h),
                      Text(
                        errorText!,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                    SizedBox(height: 2.h),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor.withAlpha(40),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${S.of(context).total} \$${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: AppColors.buttonColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => AppNavigator.of(context).pop(),
                            child: Text(
                              S.of(context).cancel,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              if (quantity < 1) return;
                              AppNavigator.of(context).pop();
                              AppNavigator.of(context).push(
                                PurchaseRequestConfirmationScreen(
                                  item: item,
                                  quantity: quantity,
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).continuePress,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCancelSaleDialog(BuildContext context, MarketItem item) {
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
                  color: Colors.redAccent.withAlpha(35),
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
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.redAccent.withAlpha(28),
                      Colors.orange.withAlpha(20),
                    ],
                  ),
                  border: Border.all(color: Colors.orangeAccent.withAlpha(120)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_offer_rounded,
                      color: Color(0xFFFFCC80),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CommonViews().customText(
                        textContent:
                            S
                                .of(context)
                                .thisListingIsCurrentlyActiveInTheMarketplace,
                        textColor: Colors.white,
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.8.h),
              CommonViews().customText(
                textContent: S.of(context).doYouWantToCancelTheSaleForThisAsset,
                textColor: Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 14.5.sp,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => AppNavigator.of(context).pop(),
              child: CommonViews().customText(
                textContent: S.of(context).keepSale,
                textColor: Colors.white70,
                fontSize: 15.sp,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                AppNavigator.of(context).pop();

                Get.find<MarketPlaceController>().cancelSaleAssets(
                  saleOfferId: item.id.toString(),
                );
              },
              child: CommonViews().customText(
                textContent: S.of(context).confirmCancel,
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

  Widget _circleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.buttonColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonColor.withAlpha(120),
            blurRadius: 10,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.black),
    );
  }

  Widget _buildLoadingView() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: 4,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Container(
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }
}

class _MarketFilterButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _MarketFilterButton({
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient:
            isActive
                ? LinearGradient(
                  colors: [AppColors.buttonColor, Colors.orangeAccent],
                )
                : null,
        color: isActive ? null : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? AppColors.buttonColor : Colors.grey.shade300,
          width: 1.2,
        ),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: AppColors.buttonColor.withAlpha(64),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          else
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey.shade700,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
                child: Text(text),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedMarketActionButton extends StatefulWidget {
  final bool isMine;
  final VoidCallback onTap;

  const _AnimatedMarketActionButton({
    required this.isMine,
    required this.onTap,
  });

  @override
  State<_AnimatedMarketActionButton> createState() =>
      _AnimatedMarketActionButtonState();
}

class _AnimatedMarketActionButtonState
    extends State<_AnimatedMarketActionButton> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final isMine = widget.isMine;

    return AnimatedScale(
      scale: _isProcessing ? 0.96 : 1,
      duration: const Duration(milliseconds: 180),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeInOut,
        child: ElevatedButton.icon(
          onPressed:
              _isProcessing
                  ? null
                  : () async {
                    setState(() => _isProcessing = true);
                    await Future.delayed(const Duration(milliseconds: 600));
                    if (mounted) {
                      setState(() => _isProcessing = false);
                    }
                    widget.onTap();
                  },
          icon:
              _isProcessing
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                  : Icon(
                    isMine
                        ? Icons.remove_shopping_cart_rounded
                        : Icons.shopping_cart_rounded,
                  ),
          label: Text(
            _isProcessing
                ? S.of(context).processing
                : (isMine ? S.of(context).cancelSale : S.of(context).buy),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isMine ? Colors.redAccent : AppColors.buttonColor,
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white,
            disabledBackgroundColor: (isMine
                    ? Colors.redAccent
                    : AppColors.buttonColor)
                .withAlpha(180),
            elevation: _isProcessing ? 0 : 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          ),
        ),
      ),
    );
  }
}
