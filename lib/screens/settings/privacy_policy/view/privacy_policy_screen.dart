import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/settings/privacy_policy/controller/privacy_policy_controller.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';


class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<TermsAndConditionController>()) {
      Get.put(TermsAndConditionController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: GetBuilder<TermsAndConditionController>(
        builder: (controller) {
          return Column(
            children: [
              CommonViews().customText(
                textContent: S.of(context).privacyPolicy,
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

  Widget _buildBody(TermsAndConditionController controller) {
    if (controller.isLoading) {
      return _buildShimmer();
    }

    if (controller.isError) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: CommonViews().customText(
            textContent: S.of(context).unableToLoadPrivacyPolicyRightNow,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            textColor: AppColors.darkBrandColor,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (controller.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: CommonViews().customText(
            textContent: S.of(context).noPrivacyPolicyIsAvailableAtTheMoment,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            textColor: AppColors.darkBrandColor,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Card(
        color: AppColors.whiteColor,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.buttonColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonViews().customText(
                textContent: controller.titleText,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                textColor: AppColors.darkBrandColor,
              ),
              SizedBox(height: 2.h),
              CommonViews().customText(
                textContent: controller.descriptionText,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                textColor: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Card(
          color: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 2.5.h,
                  width: 50.w,
                  color: Colors.white,
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 1.8.h,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 1.8.h,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 1.8.h,
                  width: 80.w,
                  color: Colors.white,
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 1.8.h,
                  width: double.infinity,
                  color: Colors.white,
                ),
                SizedBox(height: 1.h),
                Container(
                  height: 1.8.h,
                  width: 70.w,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}