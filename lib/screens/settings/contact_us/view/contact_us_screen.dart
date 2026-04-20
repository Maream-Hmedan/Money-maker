import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/settings/contact_us/controller/contact_us_controller.dart';
import 'package:money_maker/screens/settings/contact_us/model/contact_us_response.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    super.initState();
    Get.isRegistered<ContactUsController>()
        ? Get.find<ContactUsController>()
        : Get.put(ContactUsController());
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: true,
      child: GetBuilder<ContactUsController>(
        builder: (controller) {
          return Column(
            children: [
              CommonViews().customText(
                textContent: "Contact Us",
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

  Widget _buildBody(ContactUsController controller) {
    if (controller.isLoading) {
      return _buildShimmer();
    }

    if (controller.isError) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: CommonViews().customText(
            textContent: S.of(context).unableToLoadContactInformationRightNow,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            textColor: AppColors.darkBrandColor,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (controller.isEmpty || controller.contactUs == null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: CommonViews().customText(
            textContent: S.of(context).noContactInformationIsAvailableAtTheMoment,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            textColor: AppColors.whiteColor,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final contact = controller.contactUs!;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Card(
        color: AppColors.whiteColor,
        elevation: 8,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(
            color: AppColors.buttonColor,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.buttonColor.withAlpha(20),
                  border: Border.all(
                    color: AppColors.buttonColor.withAlpha(38),
                    width: 1.2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 30.sp,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    appLogo,
                    width: 42.sp,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              CommonViews().customText(
                textContent: contact.name,
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
                textColor: AppColors.darkBrandColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.8.h),
              CommonViews().customText(
                textContent: S.of(context).wereHereToHelpYou,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                textColor: Colors.grey.shade700,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),

              _buildInfoTile(
                icon: Icons.email_outlined,
                title: S.of(context).email,
                value: contact.email,
              ),
              SizedBox(height: 1.6.h),

              _buildInfoTile(
                icon: Icons.phone_outlined,
                title: S.of(context).phone,
                value: contact.phone,
              ),
              SizedBox(height: 1.6.h),

              _buildInfoTile(
                icon: Icons.location_on_outlined,
                title: S.of(context).address,
                value: contact.address,
              ),

              if (_hasAnySocial(contact)) ...[
                SizedBox(height: 3.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CommonViews().customText(
                    textContent: "Follow Us",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.darkBrandColor,
                  ),
                ),
                SizedBox(height: 1.6.h),
                Wrap(
                  spacing: 3.w,
                  runSpacing: 1.5.h,
                  children: [
                    if (_isValid(contact.facebook))
                      _buildSocialChip(
                        icon: Icons.facebook,
                        label: "Facebook",
                        url: contact.facebook.toString(),
                      ),
                    if (_isValid(contact.instagram))
                      _buildSocialChip(
                        icon: Icons.camera_alt_outlined,
                        label: "Instagram",
                        url: contact.instagram.toString(),
                      ),
                    if (_isValid(contact.linkedin))
                      _buildSocialChip(
                        icon: Icons.work_outline,
                        label: "LinkedIn",
                        url: contact.linkedin.toString(),
                      ),
                    if (_isValid(contact.youtube))
                      _buildSocialChip(
                        icon: Icons.play_circle_outline,
                        label: "YouTube",
                        url: contact.youtube.toString(),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
      decoration: BoxDecoration(
        color: AppColors.buttonColor.withAlpha(18),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.buttonColor.withAlpha(38),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(2.8.w),
            decoration: BoxDecoration(
              color: AppColors.buttonColor.withAlpha(31),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: AppColors.buttonColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 3.5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonViews().customText(
                  textContent: title,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.darkBrandColor,
                ),
                SizedBox(height: 0.5.h),
                CommonViews().customText(
                  textContent: value,
                  fontSize: 15.5.sp,
                  fontWeight: FontWeight.w400,
                  textColor: Colors.black87,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialChip({
    required IconData icon,
    required String label,
    required String url,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        await _launchSocialUrl(url);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.3.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              AppColors.buttonColor.withAlpha(15),
            ],
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: AppColors.buttonColor.withAlpha(51),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withAlpha(15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppColors.buttonColor.withAlpha(31),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.buttonColor,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 2.2.w),
            CommonViews().customText(
              textContent: label,
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w600,
              textColor: AppColors.darkBrandColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 1200),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Card(
          color: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
            child: Column(
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 2.h),
                _shimmerLine(width: 40.w, height: 2.2.h),
                SizedBox(height: 1.h),
                _shimmerLine(width: 28.w, height: 1.6.h),
                SizedBox(height: 3.h),

                _buildModernShimmerTile(),
                SizedBox(height: 1.6.h),
                _buildModernShimmerTile(),
                SizedBox(height: 1.6.h),
                _buildModernShimmerTile(),

                SizedBox(height: 3.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _shimmerLine(width: 24.w, height: 1.8.h),
                ),
                SizedBox(height: 1.5.h),

                Wrap(
                  spacing: 3.w,
                  runSpacing: 1.5.h,
                  children: [
                    _buildShimmerChip(width: 26.w),
                    _buildShimmerChip(width: 28.w),
                    _buildShimmerChip(width: 25.w),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModernShimmerTile() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerLine(width: 18.w, height: 1.4.h),
                SizedBox(height: 1.h),
                _shimmerLine(width: double.infinity, height: 1.8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerChip({required double width}) {
    return Container(
      width: width,
      height: 5.5.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }

  Widget _shimmerLine({
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Future<void> _launchSocialUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open the link'),
          ),
        );
      }
    }
  }

  bool _isValid(dynamic value) {
     return value != null && value.toString().trim().isNotEmpty;
  }

  bool _hasAnySocial(ContactUs contact) {
    return _isValid(contact.facebook) ||
        _isValid(contact.instagram) ||
        _isValid(contact.linkedin) ||
        _isValid(contact.youtube);
  }
}