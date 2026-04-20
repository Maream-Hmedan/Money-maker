import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class SpecialOffersScreen extends StatefulWidget {
  const SpecialOffersScreen({super.key});

  @override
  State<SpecialOffersScreen> createState() => _SpecialOffersScreenState();
}

class _SpecialOffersScreenState extends State<SpecialOffersScreen> {
  final List<OfferItem> offers = [
    OfferItem(
      title: '10% OFF on Towers',
      description: 'Get 10% discount on selected tower assets for a limited time.',
      conditions: 'Valid on selected towers only. Cannot be combined with other offers.',
      includedAssets: ['SKYSCRAPER', 'LUXURY TOWER', 'CITY VIEW TOWER'],
      expiryDate: DateTime(2026, 3, 30),
      promoCode: null,
      isAutomatic: true,
      imagePath: building,
      discountLabel: '-10%',
    ),
    OfferItem(
      title: '15% OFF on Yachts',
      description: 'Exclusive offer on premium yachts.',
      conditions: 'Enter promo code during checkout to activate the discount.',
      includedAssets: ['YACHT', 'ROYAL YACHT'],
      expiryDate: DateTime(2026, 4, 5),
      promoCode: 'YACHT15',
      isAutomatic: false,
      imagePath: yacht,
      discountLabel: '-15%',
    ),
    OfferItem(
      title: '20% OFF on Hotels',
      description: 'Save more on selected hotel investments.',
      conditions: 'Offer valid until stock lasts.',
      includedAssets: ['HOTEL', 'BEACH HOTEL', 'CITY HOTEL'],
      expiryDate: DateTime(2026, 4, 10),
      promoCode: 'HOTEL20',
      isAutomatic: false,
      imagePath: hotel,
      discountLabel: '-20%',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: Column(
        children: [
          CommonViews().customText(
            textContent: 'SPECIAL OFFERS',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),
          SizedBox(height: 2.h),
          Expanded(
            child: offers.isEmpty
                ? Center(
              child: CommonViews().customText(
                textContent: 'No special offers available right now',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                textColor: AppColors.whiteColor,
              ),
            )
                : ListView.builder(
              itemCount: offers.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final offer = offers[index];
                return _offerCard(offer);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _offerCard(OfferItem offer) {
    return Stack(
      children: [
        Card(
          color: AppColors.whiteColor,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(width: 2, color: AppColors.buttonColor),
          ),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 14.h,
                      width: 30.w,
                      child: Image.asset(
                        offer.imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonViews().customText(
                            textContent: offer.title,
                            textColor: AppColors.darkBrandColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                          ),
                          SizedBox(height: 1.h),
                          CommonViews().customText(
                            textContent: offer.description,
                            textColor: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.5.h),

                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonViews().customText(
                    textContent: 'Included Assets',
                    textColor: AppColors.darkBrandColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 1.h),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: offer.includedAssets.map((asset) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                      decoration: BoxDecoration(
                        color: AppColors.buttonColor.withAlpha(31),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: AppColors.buttonColor,
                          width: 1,
                        ),
                      ),
                      child: CommonViews().customText(
                        textContent: asset,
                        textColor: AppColors.darkBrandColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 1.5.h),

                Row(
                  children: [
                    Icon(Icons.access_time, size: 18, color: AppColors.buttonColor),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: CommonViews().customText(
                        textContent: 'Expires on: ${formatDate(offer.expiryDate)}',
                        textColor: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.5.sp,
                      ),
                    ),
                  ],
                ),

                if (offer.promoCode != null) ...[
                  SizedBox(height: 1.2.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.confirmation_number_outlined,
                            color: AppColors.buttonColor),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: CommonViews().customText(
                            textContent: 'Code: ${offer.promoCode}',
                            textColor: AppColors.darkBrandColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.5.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: 2.h),

                Row(
                  children: [
                    Expanded(
                      child: CommonViews().customButton(
                        child: CommonViews().customText(
                          textContent: 'BUY NOW',
                          textColor: AppColors.darkBrandColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                        color: AppColors.buttonColor,
                        border: 50,
                        elevation: 6,
                        shadowColor: Colors.black,
                        onTap: () {
                          // navigate to purchase page
                        },
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: actionButton(offer),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),

        Positioned(
          top: 10,
          right: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                topRight: Radius.circular(18),
              ),
            ),
            child: CommonViews().customText(
              textContent: offer.discountLabel,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              textColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  Widget actionButton(OfferItem offer) {
    final isActivate = offer.isAutomatic;

    return GestureDetector(
      onTap: () {
        if (isActivate) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${offer.title} activated successfully')),
          );
        } else {
          Clipboard.setData(ClipboardData(text: offer.promoCode ?? ''));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Code copied: ${offer.promoCode}')),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.4.h),
        decoration: BoxDecoration(
          color: isActivate
              ? Colors.green.withAlpha(26)
              : Colors.orange.withAlpha(26),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isActivate ? Colors.green : Colors.orange,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActivate ? Icons.flash_on : Icons.copy,
              color: isActivate ? Colors.green : Colors.orange,
              size: 18,
            ),
            SizedBox(width: 2.w),
            CommonViews().customText(
              textContent: isActivate ? 'Activate Offer' : 'Copy Code',
              textColor: isActivate ? Colors.green : Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 13.5.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class OfferItem {
  final String title;
  final String description;
  final String conditions;
  final List<String> includedAssets;
  final DateTime expiryDate;
  final String? promoCode;
  final bool isAutomatic;
  final String imagePath;
  final String discountLabel;

  OfferItem({
    required this.title,
    required this.description,
    required this.conditions,
    required this.includedAssets,
    required this.expiryDate,
    required this.promoCode,
    required this.isAutomatic,
    required this.imagePath,
    required this.discountLabel,
  });
}

// class SpecialOffersScreen extends StatefulWidget {
//   const SpecialOffersScreen({super.key});
//
//   @override
//   State<SpecialOffersScreen> createState() => _SpecialOffersScreenState();
// }
//
// class _SpecialOffersScreenState extends State<SpecialOffersScreen> {
//   final List<Item> allItems = [
//     Item(name: "SKYSCRAPER", price: "820,800", imagePath: building, category: "Tower", offer: '-20%'),
//     Item(name: "YACHT", price: "950,600", imagePath: yacht, category: "Yacht", offer: '-15%'),
//     Item(name: "HOTEL", price: "560,200", imagePath: hotel, category: "Hotel", offer: '-10%'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return  CommonBackground(
//       showAppBar: true,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CommonViews().customText(
//             textContent: 'SPECIAL OFFERS',
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w700,
//             textColor: AppColors.buttonColor,
//           ),
//           SizedBox(height: 2.h,),
//           Expanded(
//             child: ListView.builder(
//               itemCount: allItems.length,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemBuilder: (context, index) {
//                 final item = allItems[index];
//                 return Stack(
//                   children: [
//                     Card(
//                       color: AppColors.whiteColor,
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         side: BorderSide(width: 2, color: AppColors.buttonColor),
//                       ),
//                       elevation: 6,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               height: 15.h,
//                               width: 35.w,
//                               child: Image.asset(item.imagePath, fit: BoxFit.contain),
//                             ),
//                             SizedBox(width: 10.w),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CommonViews().customText(
//                                     textContent: item.name,
//                                     textColor: AppColors.darkBrandColor,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   SizedBox(height: 1.h),
//                                   CommonViews().customButton(
//                                     child: CommonViews().customText(
//                                       textContent: 'BUY',
//                                       textColor: AppColors.darkBrandColor,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16.sp,
//                                     ),
//                                     color: AppColors.buttonColor,
//                                     border: 50,
//                                     width: 25.w,
//                                     elevation: 6,
//                                     shadowColor: Colors.black,
//                                     onTap: () {},
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // Positioned offer tag
//                     Positioned(
//                       top: 10,
//                       right: 0,
//                       child: Container(
//                         padding:  EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.75.h),
//                         decoration: BoxDecoration(
//                           color: Colors.deepPurple,
//                           borderRadius: const BorderRadius.only(
//                             bottomLeft: Radius.circular(16),
//                             topRight: Radius.circular(18),
//                           ),
//                         ),
//                         child: CommonViews().customText(
//                           textContent: item.offer,
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           textColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Item {
//   final String name;
//   final String price;
//   final String imagePath;
//   final String category;
//   final String offer;
//
//   Item({
//     required this.name,
//     required this.price,
//     required this.imagePath,
//     required this.category,
//     required this.offer,
//   });
// }
