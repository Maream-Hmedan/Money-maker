import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/screens/market_place/market_place_screen.dart';
import 'package:money_maker/screens/portfolio/portfolio_screen.dart';
import 'package:money_maker/screens/special_offers/special_offers_screen.dart';
import 'package:money_maker/screens/top/top_screen.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            CommonViews().customContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonViews().customText(
                    textContent: 'Portfolio',
                    fontWeight: FontWeight.w500,
                    fontSize: 19.sp,
                  ),
                  CommonViews().customText(
                    textContent: '\$28,700',
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
