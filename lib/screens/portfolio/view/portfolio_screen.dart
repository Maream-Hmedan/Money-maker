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
  final bool showAppBar;

  PortfolioScreen({super.key, required this.showAppBar});

  final _items = [
    _PortfolioItem(
      image: buildingWithOutBG,
      label: 'Skyscraper',
      quantity: 2,
      price: 1_200_000,
      change: 5_000,
    ),
    _PortfolioItem(
      image: yachtWithOutBG,
      label: 'Yacht',
      quantity: 1,
      price: 800_000,
      change: 4_000,
    ),
    _PortfolioItem(
      image: hotelWithOutBG,
      label: 'Hotel',
      quantity: 3,
      price: 500_000,
      change: 3_000,
    ),
    _PortfolioItem(
      image: homeWithOutBG,
      label: 'House',
      quantity: 4,
      price: 250_000,
      change: 2_000,
    ),
  ];

  int get totalPortfolioValue {
    return _items.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _showSellDialog(BuildContext context, _PortfolioItem item) {
    final qtyController = TextEditingController(text: '1');
    final priceController = TextEditingController(text: item.price.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.darkBrandColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'List ${item.label} for Sale',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFFFB703)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Selling Price',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFFFB703)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 1.5.h),
              Text(
                'You can list fewer copies and choose any selling price.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white70),
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
                // هنا لاحقًا تضيفي منطق الإدراج في الـ Marketplace
                Navigator.pop(context);
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fmt = NumberFormat('#,###,###');

    return CommonBackground(
      showAppBar: showAppBar,
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

              /// Portfolio Total Value
              Container(
                width: 85.w,
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                decoration: BoxDecoration(
                  color: AppColors.darkBrandColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFFCC80), width: 2),
                ),
                child: Column(
                  children: [
                    CommonViews().customText(
                      textContent: 'Portfolio Value',
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white70,
                      fontSize: 15.sp,
                    ),
                    SizedBox(height: 0.8.h),
                    CommonViews().customText(
                      textContent: '\$${fmt.format(totalPortfolioValue)}',
                      fontWeight: FontWeight.bold,
                      textColor: Colors.white,
                      fontSize: 22.sp,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),

              /// Portfolio List
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
                        textContent: 'Portfolio',
                        fontWeight: FontWeight.bold,
                        textColor: Colors.white,
                        fontSize: 19.sp,
                      ),
                    ),
                    ...List.generate(_items.length, (i) {
                      final p = _items[i];
                      final last = i == _items.length - 1;
                      final totalAssetValue = p.price * p.quantity;

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.57.h,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                      SizedBox(height: 0.4.h),
                                      CommonViews().customText(
                                        textContent:
                                            'Owned: ${p.quantity} copies',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        textColor: Colors.white70,
                                      ),
                                      SizedBox(height: 0.3.h),
                                      CommonViews().customText(
                                        textContent:
                                            'Unit Price: \$${fmt.format(p.price)}',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                        textColor: AppColors.whiteColor,
                                      ),
                                      SizedBox(height: 0.3.h),
                                      CommonViews().customText(
                                        textContent:
                                            'Total: \$${fmt.format(totalAssetValue)}',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
                                        textColor: const Color(0xFFFFCC80),
                                      ),
                                      SizedBox(height: 0.3.h),
                                      CommonViews().customText(
                                        textContent:
                                            '▲ ${fmt.format(p.change)}',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp,
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
                                  color: const Color(0xFFFFB703),
                                  radius: 12,
                                  onTap: () => _showSellDialog(context, p),
                                  width: 25.w,
                                  colorBorder: const Color(0xFFFFCC80),
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
  final int quantity;
  final int price;
  final int change;

  const _PortfolioItem({
    required this.image,
    required this.label,
    required this.quantity,
    required this.price,
    required this.change,
  });
}

// class PortfolioScreen extends StatelessWidget {
//   final bool  showAppBar;
//   PortfolioScreen({super.key,required this.showAppBar});
//
//   final _items = [
//     _PortfolioItem(buildingWithOutBG, 'Skyscraper', 1_200_000, 5_000),
//     _PortfolioItem(yachtWithOutBG, 'Yacht', 800_000, 4_000),
//     _PortfolioItem(hotelWithOutBG, 'Hotel', 500_000, 3_000),
//     _PortfolioItem(homeWithOutBG, 'House', 250_000, 2_000),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final fmt = NumberFormat('#,###,###');
//     return CommonBackground(
//       showAppBar: showAppBar,
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Image.asset(
//                 appLogo,
//                 width: AppSize.logoWidthCommon,
//                 height: AppSize.logoHeightCommon,
//                 fit: BoxFit.cover,
//               ),
//               Container(
//                 width: 85.w,
//                 decoration: BoxDecoration(
//                   color: AppColors.darkBrandColor,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(
//                         vertical: 2.5.h,
//                         horizontal: 5.w,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Color(0xFFFFB703),
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(24),
//                         ),
//                         border: Border.all(color: Color(0xFFFFCC80), width: 3),
//                       ),
//                       child: CommonViews().customText(
//                         textContent: 'Portfolio',
//                         fontWeight: FontWeight.bold,
//                         textColor: Colors.white,
//                         fontSize: 19.sp,
//                       ),
//                     ),
//                     ...List.generate(_items.length, (i) {
//                       final p = _items[i];
//                       final last = i == _items.length - 1;
//                       return Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 4.w,
//                               vertical: 1.57.h,
//                             ),
//                             child: Row(
//                               children: [
//                                 Image.asset(
//                                   p.image,
//                                   height: 7.h,
//                                   fit: BoxFit.contain,
//                                 ),
//                                 SizedBox(width: 4.w),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CommonViews().customText(
//                                         textContent: p.label,
//                                         fontWeight: FontWeight.bold,
//                                         textColor: AppColors.whiteColor,
//                                         fontSize: 17.sp,
//                                       ),
//                                       CommonViews().customText(
//                                         textContent: '\$${fmt.format(p.price)}',
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16.sp,
//                                         textColor: AppColors.whiteColor,
//                                       ),
//                                       CommonViews().customText(
//                                         textContent:
//                                             '▲ ${fmt.format(p.change)}',
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16.sp,
//                                         textColor: Colors.greenAccent,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 CommonViews().customContainer(
//                                   child: Center(
//                                     child: CommonViews().customText(
//                                       textContent: 'SELL',
//                                       textColor: AppColors.whiteColor,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16.sp,
//                                     ),
//                                   ),
//                                   color: Color(0xFFFFB703),
//                                   radius: 12,
//                                   onTap: () {},
//                                   width: 25.w,
//                                   colorBorder: Color(0xFFFFCC80),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           if (!last)
//                             Divider(
//                               color: Colors.white.withOpacity(0.40),
//                               thickness: 1.5,
//                             ),
//                         ],
//                       );
//                     }),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _PortfolioItem {
//   final String image;
//   final String label;
//   final int price;
//   final int change;
//
//   const _PortfolioItem(this.image, this.label, this.price, this.change);
// }
