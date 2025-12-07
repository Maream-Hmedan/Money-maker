import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/home/widget/portfolio_value/portfolio_value_controller.dart';
import 'package:money_maker/screens/market_place/view/market_place_screen.dart';
import 'package:money_maker/screens/portfolio/portfolio_screen.dart';
import 'package:money_maker/screens/special_offers/special_offers_screen.dart';
import 'package:money_maker/screens/top/top_screen.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PortfolioValueController _portfolioValue = Get.put(PortfolioValueController());

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              appLogo,
              width: AppSize.logoWidthCommon,
              height: AppSize.logoHeightCommon,
              fit: BoxFit.cover,
            ),
            CommonViews().customContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonViews().customText(
                    textContent: 'Balance',
                    fontWeight: FontWeight.w500,
                    fontSize: 19.sp,
                  ),
                  CommonViews().customText(
                    textContent: '\$12,450',
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                ],
              ),
              colorBorder: Color(0xFFFFCC80),
              color: AppColors.buttonColor,
              padding: EdgeInsets.all(8),
              height: 9.h,
              width: 90.w,
            ),
            SizedBox(height: 1.h),
            GetBuilder<PortfolioValueController>(
              builder: (_) {
                if (_portfolioValue.isLoading) {
                  return CommonViews().customContainer(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300] ?? Colors.grey,
                      highlightColor: Colors.grey[100] ?? Colors.white,
                      child: Container(
                        width: 90.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(1.w),
                      ),
                    ),
                    colorBorder: AppColors.borderTextFieldColor,
                    color: AppColors.whiteColor,
                    height: 8.h,
                    width: 90.w,
                  );
                }
                else if (_portfolioValue.isError) {
                  return CommonViews().customContainer(
                    child: Center(
                      child: CommonViews().customText(
                        textContent: S.of(context).errorLoadingPortfolioValue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        textColor: Colors.red,
                      ),
                    ),
                    colorBorder: AppColors.borderTextFieldColor,
                    color: AppColors.whiteColor,
                    padding: EdgeInsets.all(8),
                    height: 8.h,
                    width: 90.w,
                  );
                } else {
                  // isSuccess
                  return CommonViews().customContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonViews().customText(
                          textContent: S.of(context).portfolio,
                          fontWeight: FontWeight.w500,
                          fontSize: 19.sp,
                        ),
                        CommonViews().customText(
                          textContent: '\$${_portfolioValue.portfolioValue.toStringAsFixed(2)}',
                          fontWeight: FontWeight.w700,
                          fontSize: 20.sp,
                        ),
                      ],
                    ),
                    colorBorder: AppColors.borderTextFieldColor,
                    color: AppColors.whiteColor,
                    padding: EdgeInsets.all(8),
                    height: 8.h,
                    width: 90.w,
                  );
                }
              },
            ),
            SizedBox(height: 1.5.h),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 1.h,
                crossAxisSpacing: 1.h,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _menuItem(Icons.store_mall_directory, "MARKET",() {
                    AppNavigator.of(context).push(MarketplaceScreen());
                  },),
                  _menuItem(Icons.apartment, "PORTFOLIO",() {
                    AppNavigator.of(context).push(PortfolioScreen());
                  },),
                  _menuItem(Icons.card_giftcard, "OFFERS",() {
                    AppNavigator.of(context).push(SpecialOffersScreen());
                  },),
                  _menuItem(Icons.emoji_events, "LEADERBOARD",() {
                    AppNavigator.of(context).push(TopPlayersPage());
                  },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderTextFieldColor, width: 3),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30.sp,
              color: AppColors.buttonColor, // Gold/yellow
            ),
            SizedBox(height: 1.h),
            CommonViews().customText(
              textContent: label,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
