import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/market_place/controller/market_controller.dart';
import 'package:money_maker/screens/market_place/view/purchase_request_confirmation/purchase_request_confirmation_screen.dart';
import 'package:money_maker/widgets/app_cached_image.dart';
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

  @override
  void dispose() {
    controller.resetAllFilters();
    super.dispose();
  }

  Widget _buildSortLabel(BuildContext context, MarketController ctrl) {
    if (ctrl.selectedSortBy == null || ctrl.selectedOrder == null) {
      return CommonViews().customText(
        textContent: S.of(context).sort,
        textColor: Colors.black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      );
    }

    final sortByText =
    ctrl.selectedSortBy == 'price'
        ? S.of(context).price
        : S.of(context).growthRate;

    final isAsc = ctrl.selectedOrder == 'asc';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonViews().customText(
          textContent: sortByText,
          textColor: Colors.black,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),

        SizedBox(width: 1.w),

        Icon(
          isAsc ? Icons.arrow_upward : Icons.arrow_downward,
          color: AppColors.buttonColor,
          size: 18.sp,
        ),
      ],
    );
  }

  List<String> getAvailableTypes() {
    return controller.items
        .map((e) => e.type)
        .where((type) => type.isNotEmpty)
        .toSet()
        .toList();
  }
  String _getFilterLabel(MarketController ctrl) {
    if (ctrl.selectedType == null || ctrl.selectedType == 'all') {
      return S.of(context).filter;
    }
    return ctrl.selectedType!;
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: Column(
        children: [
          /// TITLE
          CommonViews().customText(
            textContent: S.of(context).marketPlace,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),

          SizedBox(height: 2.h),

          GetBuilder<MarketController>(
            builder: (ctrl) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          _showSortSheet(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.buttonColor),
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.whiteColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child:_buildSortLabel(context, ctrl),
                              ),
                              Icon(Icons.swap_vert, color: AppColors.buttonColor),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 3.w),

                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          _showFilterSheet(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.buttonColor),
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.whiteColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CommonViews().customText(
                                  textContent: _getFilterLabel(ctrl),
                                  textColor: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(Icons.filter_list, color: AppColors.buttonColor),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 2.h),

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

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: AppColors.buttonColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            AppCachedImage(
                              url: item.image,
                              height: 11.h,
                              width: 18.w,
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.circular(12),
                              errorWidget: Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            ),

                            SizedBox(width: 3.w),

                            /// DETAILS
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// NAME
                                  CommonViews().customText(
                                    textContent:
                                    item.name.isEmpty
                                        ? 'Empty Name'
                                        : item.name,
                                    textColor: AppColors.darkBrandColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.sp,
                                  ),
                                  CommonViews().customText(
                                    textContent:
                                    S.of(context).typeLabel(item.type),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    textColor: Colors.grey,
                                  ),
                                  SizedBox(height: 1.h),
                                  /// PRICE + GROWTH
                                  Row(
                                    children: [
                                      CommonViews().customText(
                                        textContent: '\$${item.price}',
                                        textColor: AppColors.darkBrandColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp,
                                      ),
                                      SizedBox(width: 3.w),
                                      Icon(
                                        item.priceGrowthRate > 0
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                                        color:
                                        item.priceGrowthRate > 0
                                            ? Colors.green
                                            : Colors.red,
                                        size: 17.sp,
                                      ),
                                      SizedBox(width: 1.w),
                                      CommonViews().customText(
                                        textContent:
                                        '${item.priceGrowthRate.toStringAsFixed(1)}%',
                                        textColor:
                                        item.priceGrowthRate > 0
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.sp,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /// BUY BUTTON
                            CommonViews().customButton(
                              child: CommonViews().customText(
                                textContent: S.of(context).buy,
                                textColor: AppColors.darkBrandColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              color: AppColors.buttonColor,
                              border: 50,
                              elevation: 4,
                              shadowColor: Colors.black,
                              width: 22.w,
                              onTap: () {
                                _showBuyDialog(context, item);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
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

  void _showSortSheet(BuildContext context) {
    String selectedSortBy = 'price';
    String selectedOrder = 'desc';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 14.w,
                      height: 0.6.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  CommonViews().customText(
                    textContent: S.of(context).sortOptions,
                    textColor: AppColors.darkBrandColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),

                  SizedBox(height: 2.h),

                  CommonViews().customText(
                    textContent: S.of(context).sortBy,
                    textColor: AppColors.darkBrandColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.5.sp,
                  ),

                  SizedBox(height: 1.h),

                  Row(
                    children: [
                      Expanded(
                        child: _sortChoiceItem(
                          title: S.of(context).price,
                          isSelected: selectedSortBy == 'price',
                          onTap: () {
                            setModalState(() {
                              selectedSortBy = 'price';
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: _sortChoiceItem(
                          title: S.of(context).growthRate,
                          isSelected: selectedSortBy == 'price_growth_rate',
                          onTap: () {
                            setModalState(() {
                              selectedSortBy = 'price_growth_rate';
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  CommonViews().customText(
                    textContent: S.of(context).order,
                    textColor: AppColors.darkBrandColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.5.sp,
                  ),

                  SizedBox(height: 1.h),

                  Row(
                    children: [
                      Expanded(
                        child: _sortChoiceItem(
                          title: S.of(context).ascending,
                          isSelected: selectedOrder == 'asc',
                          onTap: () {
                            setModalState(() {
                              selectedOrder = 'asc';
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: _sortChoiceItem(
                          title: S.of(context).descending,
                          isSelected: selectedOrder == 'desc',
                          onTap: () {
                            setModalState(() {
                              selectedOrder = 'desc';
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 3.h),

                  Row(
                    children: [
                      Expanded(
                        child: CommonViews().customButton(
                          child: CommonViews().customText(
                            textContent: S.of(context).cancel,
                            textColor: AppColors.darkBrandColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.5.sp,
                          ),
                          color: Colors.grey.shade200,
                          border: 40,
                          elevation: 0,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: CommonViews().customButton(
                          child: CommonViews().customText(
                            textContent: S.of(context).apply,
                            textColor: AppColors.darkBrandColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp,
                          ),
                          color: AppColors.buttonColor,
                          border: 40,
                          elevation: 0,
                          onTap: () {
                            controller.sortItems(
                              sortBy: selectedSortBy,
                              order: selectedOrder,
                            );
                            AppNavigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.5.h),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _sortChoiceItem({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.6.h, horizontal: 3.w),
        decoration: BoxDecoration(
          color:
          isSelected
              ? AppColors.buttonColor.withAlpha(38)
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.buttonColor : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Center(
          child: CommonViews().customText(
            textContent: title,
            textColor: AppColors.darkBrandColor,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 14.5.sp,
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    final availableTypes = [S.of(context).all, ...getAvailableTypes()];
    String selectedType = controller.selectedType ?? 'all';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 14.w,
                      height: 0.6.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  CommonViews().customText(
                    textContent: S.of(context).filter,
                    textColor: AppColors.darkBrandColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),

                  SizedBox(height: 2.h),

                  CommonViews().customText(
                    textContent: S.of(context).assetType,
                    textColor: AppColors.darkBrandColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.5.sp,
                  ),

                  SizedBox(height: 1.h),

                  Wrap(
                    spacing: 3.w,
                    runSpacing: 1.4.h,
                    children: availableTypes.map((type) {
                      final isSelected = selectedType == type;

                      return InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          setModalState(() {
                            selectedType = type;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.4.h,
                            horizontal: 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.buttonColor.withAlpha(38)
                                : AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.buttonColor
                                  : Colors.grey.shade300,
                              width: 1.5,
                            ),
                          ),
                          child: CommonViews().customText(
                            textContent: type == 'all' ? S.of(context).all : type,
                            textColor: AppColors.darkBrandColor,
                            fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                            fontSize: 14.5.sp,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 3.h),

                  Row(
                    children: [
                      Expanded(
                        child: CommonViews().customButton(
                          child: CommonViews().customText(
                            textContent: S.of(context).cancel,
                            textColor: AppColors.darkBrandColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.5.sp,
                          ),
                          color: Colors.grey.shade200,
                          border: 40,
                          elevation: 0,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: CommonViews().customButton(
                          child: CommonViews().customText(
                            textContent: S.of(context).apply,
                            textColor: AppColors.darkBrandColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5.sp,
                          ),
                          color: AppColors.buttonColor,
                          border: 40,
                          elevation: 0,
                          onTap: () {
                            if (selectedType == 'all') {
                              controller.resetAllFilters();
                            } else {
                              controller.filterItems(type: selectedType);
                            }
                            AppNavigator.of(context).pop();
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.5.h),
                ],
              ),
            );
          },
        );
      },
    );
  }
  void _showBuyDialog(BuildContext context, item) {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.question,
      animType: AnimType.scale,

      title: S.of(context).confirmPurchase,
      desc: S.of(context).buyConfirmationMessage,
      btnCancel: CommonViews().customButton(
        onTap: () {
        AppNavigator.of(context).pop();
        },
        color: Colors.grey.shade200,
        border: 40,
        elevation: 0,
        child: CommonViews().customText(
          textContent: S.of(context).cancel,
          textColor: AppColors.darkBrandColor,
          fontWeight: FontWeight.w600,
          fontSize: 15.5.sp,
        ),
      ),

      btnOk: CommonViews().customButton(
        onTap: () {
          AppNavigator.of(context).pop();
          AppNavigator.of(context).push(PurchaseRequestConfirmationScreen(item: item));
        },
        color: AppColors.buttonColor,
        border: 40,
        elevation: 0,
        child: CommonViews().customText(
          textContent: S.of(context).confirm,
          textColor: AppColors.darkBrandColor,
          fontWeight: FontWeight.w700,
          fontSize: 15.5.sp,
        ),
      ),

    ).show();
  }
}
