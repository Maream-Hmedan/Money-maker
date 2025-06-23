import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/wigets/background_widget.dart';
import 'package:money_maker/wigets/common_views.dart';
import 'package:sizer/sizer.dart';

class SpecialOffersScreen extends StatefulWidget {
  const SpecialOffersScreen({super.key});

  @override
  State<SpecialOffersScreen> createState() => _SpecialOffersScreenState();
}

class _SpecialOffersScreenState extends State<SpecialOffersScreen> {
  final List<Item> allItems = [
    Item(name: "SKYSCRAPER", price: "820,800", imagePath: building, category: "Tower"),
    Item(name: "YACHT", price: "950,600", imagePath: yacht, category: "Yacht"),
    Item(name: "HOTEL", price: "560,200", imagePath: hotel, category: "Hotel"),
  ];

  @override
  Widget build(BuildContext context) {
    return  CommonBackground(
      showAppBar: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonViews().customText(
            textContent: 'SPECIAL OFFERS',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),
          SizedBox(height: 2.h,),
          Expanded(
            child: ListView.builder(
              itemCount: allItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final item = allItems[index];
                return Card(
                  color: AppColors.whiteColor,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(width: 2, color: AppColors.buttonColor),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 15.h,
                          width: 35.w,
                          child: Image.asset(item.imagePath, fit: BoxFit.contain),
                        ),
                        SizedBox(width: 10.w,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonViews().customText(
                                textContent: item.name,
                                textColor: AppColors.darkBrandColor,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 1.h),
                              CommonViews().customButton(
                                child: CommonViews().customText(
                                  textContent: 'BUY',
                                  textColor: AppColors.darkBrandColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                ),
                                color: AppColors.buttonColor,
                                border: 50,
                                width: 25.w,
                                elevation: 6,
                                shadowColor: Colors.black,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
