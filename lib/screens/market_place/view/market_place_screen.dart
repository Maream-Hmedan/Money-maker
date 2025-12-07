import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/market_place/controller/market_controller.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class MarketplaceScreen extends StatefulWidget {
   const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final controller = Get.put(MarketController());
  final List<Item> allItems = [
    Item(name: "Eiffel Tower", price: "820,800", imagePath: eiffelTower, category: "Tower"),
    Item(name: "Hotel", price: "560,200", imagePath: hotel, category: "Hotel"),
    Item(name: "Building", price: "350,000", imagePath: building, category: "Building"),
    Item(name: "Yacht", price: "950,600", imagePath: yacht, category: "Yacht"),
  ];

  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 2.h,),
            Expanded(
              child: GetBuilder<MarketController>(
                builder: (ctrl) {
                  if (ctrl.isLoading) {
                    return buildLoadingView();
                  }
                  if (ctrl.isError) {
                    return Center(
                      child: CommonViews().customText(
                        textContent: S.of(context).errorLoadingData,
                        textColor: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    );
                  }

                  if (ctrl.isEmpty) {
                    return Center(
                      child: CommonViews().customText(
                        textContent: S.of(context).noMarketItemsFound,
                        textColor: AppColors.darkBrandColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: ctrl.items.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final item = ctrl.items[index];
                      return Card(
                        color: AppColors.whiteColor,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            width: 2,
                            color: AppColors.buttonColor,
                          ),
                        ),
                        elevation: 6,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: SizedBox(
                            height: 12.h,
                            width: 17.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: item.image,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          title: CommonViews().customText(
                            textContent: item.name.isEmpty?'Empty Name': item.name,
                            textColor: AppColors.darkBrandColor,
                            fontWeight: FontWeight.w600,
                          ),
                          subtitle: Row(
                            children: [
                              item.priceGrowthRate>0?Icon(Icons.arrow_upward, color: Colors.green, size: 18.sp):SizedBox.shrink(),
                              SizedBox(width: 1.w),
                              CommonViews().customText(
                                textContent: '\$${item.price}',
                                textColor: AppColors.darkBrandColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          trailing: CommonViews().customButton(
                            child: CommonViews().customText(
                              textContent: S.of(context).buy,
                              textColor: AppColors.darkBrandColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                            ),
                            color: AppColors.buttonColor,
                            border: 50,
                            elevation: 6,
                            shadowColor: Colors.black,
                            onTap: () {},
                            width: 25.w,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: allItems.length,
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     itemBuilder: (context, index) {
            //       final item = allItems[index];
            //       return Card(
            //         color: AppColors.whiteColor,
            //         margin: const EdgeInsets.symmetric(vertical: 10),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //           side: BorderSide(width: 2,color: AppColors.buttonColor)
            //         ),
            //         elevation: 6,
            //         child: ListTile(
            //           contentPadding: const EdgeInsets.all(16),
            //         leading: SizedBox(
            //           height: 12.h,
            //           width: 17.w,
            //           child: Image.asset(item.imagePath, fit: BoxFit.fill),
            //         ),
            //           title:
            //           CommonViews().customText(
            //             textContent:  item.name,
            //             textColor: AppColors.darkBrandColor,
            //             fontWeight: FontWeight.w600,
            //           ),
            //           subtitle: Row(
            //             children: [
            //               Icon(Icons.arrow_upward, color: Colors.green, size: 18.sp),
            //               SizedBox(width: 1.w,),
            //               CommonViews().customText(
            //                 textContent:   '\$${item.price}',
            //                 textColor: AppColors.darkBrandColor,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ],
            //           ),
            //           trailing:
            //           CommonViews().customButton(child:   CommonViews().customText(
            //             textContent: 'BUY',
            //             textColor: AppColors.darkBrandColor,
            //             fontWeight: FontWeight.w500,
            //             fontSize: 16.sp,
            //           ), color: AppColors.buttonColor, border: 50,
            //               elevation: 6,
            //               shadowColor: Colors.black,
            //               onTap: (){},width: 25.w),
            //
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      );
  }

  ListView buildLoadingView() {
    return ListView.builder(
                    itemCount: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Card(
                          color: AppColors.whiteColor,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(width: 2, color: AppColors.buttonColor),
                          ),
                          elevation: 6,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: Container(
                              height: 12.h,
                              width: 17.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            title: Container(
                              height: 12,
                              width: 100,
                              color: Colors.grey.shade300,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: Colors.grey.shade300,
                                  ),
                                  SizedBox(width: 1.w),
                                  Container(
                                    height: 10,
                                    width: 50,
                                    color: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            ),
                            trailing: Container(
                              height: 35,
                              width: 25.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
  }
}

class Item {
  final String name;
  final String price;
  final String imagePath;
  final String category;

  Item({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
  });
}
