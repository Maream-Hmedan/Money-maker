import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/special_offers/controller/special_offers_controller.dart';
import 'package:money_maker/screens/special_offers/model/special_offers_response.dart';
import 'package:money_maker/widgets/app_cached_image.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
class SpecialOffersScreen extends StatefulWidget {
  const SpecialOffersScreen({super.key});

  @override
  State<SpecialOffersScreen> createState() => _SpecialOffersScreenState();
}

class _SpecialOffersScreenState extends State<SpecialOffersScreen> {
  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<SpecialOffersController>()) {
      Get.put(SpecialOffersController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: GetBuilder<SpecialOffersController>(
        builder: (controller) {
          return Column(
            children: [
              CommonViews().customText(
                textContent: S.of(context).specialOffers,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                textColor: AppColors.buttonColor,
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: _buildBody(controller),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(SpecialOffersController controller) {
    if (controller.apiStatus == ApiStatus.loading) {
      return _buildShimmerList();
    }

    if (controller.apiStatus == ApiStatus.error) {
      return RefreshIndicator(
        onRefresh: () async {
          await controller.getSpecialOffers();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: CommonViews().customText(
                  textContent: S.of(context).unableToLoadSpecialOffersRightNow,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.darkBrandColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (controller.apiStatus == ApiStatus.empty) {
      return RefreshIndicator(
        onRefresh: () async {
          await controller.getSpecialOffers();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: CommonViews().customText(
                  textContent: S.of(context).noSpecialOffersAreAvailableRightNow,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.darkBrandColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return  RefreshIndicator(
      onRefresh: () async {
        await controller.getSpecialOffers();
      },
      child: ListView.builder(
        itemCount: controller.offers.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final offer = controller.offers[index];
          return _offerCard(offer, controller);
        },
      ),
    );
  }
  Widget _offerCard(OfferItem offer, SpecialOffersController controller) {
    final String description = offer.description.trim().isNotEmpty
        ? offer.description
        : S.of(context).enjoyThisLimitedtimeSpecialOfferOnSelectedAssets;

    final String discountLabel = _getDiscountLabel(offer);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            const Color(0xfff8f4ff),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.buttonColor.withAlpha(120),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonColor.withAlpha(25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(20),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: AppCachedImage(
                        url: offer.image,
                        width: 30.w,
                        height: 14.h,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(18),
                        placeholder: Container(
                          width: 30.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: AppColors.darkBrandColor,
                            strokeWidth: 2,
                          ),
                        ),
                        errorWidget: Container(
                          width: 30.w,
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey.shade500,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonViews().customText(
                            textContent: splitTitle(offer.title),
                            textColor: AppColors.darkBrandColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 17.sp,
                          ),
                          SizedBox(height: 0.8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.5.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withAlpha(20),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CommonViews().customText(
                              textContent:  S.of(context).typeLabel(offer.type),
                              textColor: Colors.deepPurple,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          CommonViews().customText(
                            textContent: description,
                            textColor: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.5.sp,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 1.8.h),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                    vertical: 1.2.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor.withAlpha(18),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: AppColors.buttonColor.withAlpha(70),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 18,
                        color: AppColors.buttonColor,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: CommonViews().customText(
                          textContent:
                          '${S.of(context).expiresOn} ${formatDate(offer.endDate)}',
                          textColor: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 1.8.h),

                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CommonViews().customText(
                            textContent: offer.price.toStringAsFixed(2),
                            textColor: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                            textDecoration: TextDecoration.lineThrough,
                          ),
                          SizedBox(width: 1.5.w),
                          Image.asset(
                            "assets/images/coin.png",
                            width: 16,
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.5.w,
                          vertical: 1.1.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xffFFD54F),
                              Color(0xffFFB300),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withAlpha(70),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonViews().customText(
                              textContent: offer.offerPrice.toStringAsFixed(2),
                              textColor: Colors.brown.shade900,
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                            ),
                            SizedBox(width: 2.w),
                            Image.asset(
                              "assets/images/coin.png",
                              width: 22,
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                SizedBox(
                  width: double.infinity,
                  child: CommonViews().customButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.whiteColor,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        CommonViews().customText(
                          textContent: S.of(context).buyNow,
                          textColor: AppColors.whiteColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.5.sp,
                        ),
                      ],
                    ),
                    color: AppColors.buttonColor,
                    border: 50,
                    elevation: 8,
                    shadowColor: Colors.black.withAlpha(40),
                    onTap: () {
                      controller.buyOffers(
                        offerId: offer.id.toString(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: AppLocale().isArabic() ? null : 0,
            left: AppLocale().isArabic() ? 0 : null,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 3.5.w,
                vertical: 0.9.h,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff7C4DFF),
                    Color(0xff512DA8),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topRight: AppLocale().isArabic()
                      ? Radius.zero
                      : const Radius.circular(24),
                  topLeft: AppLocale().isArabic()
                      ? const Radius.circular(24)
                      : Radius.zero,
                  bottomLeft: AppLocale().isArabic()
                      ? Radius.zero
                      : const Radius.circular(18),
                  bottomRight: AppLocale().isArabic()
                      ? const Radius.circular(18)
                      : Radius.zero,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 1.w),
                  CommonViews().customText(
                    textContent: discountLabel,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.bold,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 14.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 2.h,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            SizedBox(height: 1.2.h),
                            Container(
                              height: 1.8.h,
                              width: double.infinity,
                              color: Colors.white,
                            ),
                            SizedBox(height: 0.8.h),
                            Container(
                              height: 1.8.h,
                              width: 60.w,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    height: 2.h,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    height: 5.5.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getDiscountLabel(OfferItem offer) {
    if (offer.discountPercent.trim().isNotEmpty &&
        offer.discountPercent != '0') {
      final percent = offer.discountPercent.split('.').first;
      return '-$percent%';
    }

    if (offer.discountAmount != null) {
      return '-${offer.discountAmount}';
    }

    return 'OFFER';
  }

  String splitTitle(String text) {
    final words = text.trim().split(RegExp(r'\s+'));

    if (words.length <= 2) {
      return text;
    }

    String firstLine = words.take(2).join(' ');
    String secondLine = words.skip(2).join(' ');

    return '$firstLine\n$secondLine';
  }
}


