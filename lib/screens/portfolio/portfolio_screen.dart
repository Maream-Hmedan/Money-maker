// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';

import 'package:sizer/sizer.dart';

class PortfolioScreen extends StatelessWidget {
  PortfolioScreen({super.key});

  final _items = [
    _PortfolioItem(buildingWithOutBG, 'Skyscraper', 1_200_000, 5_000),
    _PortfolioItem(yachtWithOutBG, 'Yacht', 800_000, 4_000),
    _PortfolioItem(hotelWithOutBG, 'Hotel', 500_000, 3_000),
    _PortfolioItem(homeWithOutBG, 'House', 250_000, 2_000),
  ];

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,###,###');
    return CommonBackground(
      child: SingleChildScrollView(
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
              Container(
                width: 85.w,
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
                        color: Color(0xFFFFB703),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                        border: Border.all(color: Color(0xFFFFCC80), width: 3),
                      ),
                      child: CommonViews().customText(
                        textContent: 'Portfolio',
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                        fontSize: 19.sp,
                      ),
                    ),
                    ...List.generate(_items.length, (i) {
                      final p = _items[i];
                      final last = i == _items.length - 1;
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.57.h,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  p.image,
                                  height: 7.h,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonViews().customText(
                                        textContent: p.label,
                                        fontWeight: FontWeight.bold,
                                        textColor: AppColors.whiteColor,
                                        fontSize: 17.sp,
                                      ),
                                      CommonViews().customText(
                                        textContent: '\$${fmt.format(p.price)}',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        textColor: AppColors.whiteColor,
                                      ),
                                      CommonViews().customText(
                                        textContent:
                                            '▲ ${fmt.format(p.change)}',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        textColor: Colors.greenAccent,
                                      ),
                                    ],
                                  ),
                                ),
                                CommonViews().customContainer(
                                  child: Center(
                                    child: CommonViews().customText(
                                      textContent: 'SELL',
                                      textColor: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  color: Color(0xFFFFB703),
                                  radius: 12,
                                  onTap: () {},
                                  width: 25.w,
                                  colorBorder: Color(0xFFFFCC80),
                                ),
                              ],
                            ),
                          ),
                          if (!last)
                            Divider(
                              color: Colors.white.withOpacity(0.40),
                              thickness: 1.5,
                            ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortfolioItem {
  final String image;
  final String label;
  final int price;
  final int change;

  const _PortfolioItem(this.image, this.label, this.price, this.change);
}
