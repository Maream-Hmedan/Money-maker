import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/wigets/background_widget.dart';
import 'package:money_maker/wigets/common_views.dart';
import 'package:sizer/sizer.dart';

class MarketplaceScreen extends StatefulWidget {
   const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
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
              textContent: 'MARKETPLACE',
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
                      side: BorderSide(width: 2,color: AppColors.buttonColor)
                    ),
                    elevation: 6,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                    leading: SizedBox(
                      height: 12.h,
                      width: 17.w,
                      child: Image.asset(item.imagePath, fit: BoxFit.fill),
                    ),
                      title:
                      CommonViews().customText(
                        textContent:  item.name,
                        textColor: AppColors.darkBrandColor,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: Row(
                        children: [
                          Icon(Icons.arrow_upward_outlined,color: Colors.green),
                          SizedBox(width: 1.w,),
                          CommonViews().customText(
                            textContent:   '\$${item.price}',
                            textColor: AppColors.darkBrandColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      trailing:
                      CommonViews().customButton(child:   CommonViews().customText(
                        textContent: 'BUY',
                        textColor: AppColors.darkBrandColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ), color: AppColors.buttonColor, border: 50,
                          elevation: 6,
                          shadowColor: Colors.black,
                          onTap: (){},width: 25.w),

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
