import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/controller/build_company_controller.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/model/my_company_info_response.dart';
import 'package:money_maker/screens/login/view/login_screen.dart';
import 'package:money_maker/screens/settings/contact_us/controller/contact_us_controller.dart';
import 'package:money_maker/widgets/app_cached_image.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class MyCompanyScreen extends StatefulWidget {
  const MyCompanyScreen({super.key});

  @override
  State<MyCompanyScreen> createState() => _MyCompanyScreenState();
}

class _MyCompanyScreenState extends State<MyCompanyScreen> {
  late final CompanyController _companyController;
  final controller =
      Get.isRegistered<ContactUsController>()
          ? Get.find<ContactUsController>()
          : Get.put(ContactUsController());

  @override
  void initState() {
    super.initState();
    _companyController = Get.put(CompanyController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _companyController.getMyCompanyInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: false,
      child: GetBuilder<CompanyController>(
        builder: (controller) {
          if (controller.companyInfoStatus == ApiStatus.guest) {
            return _buildGuestView(context);
          }
          if (controller.companyInfoStatus == ApiStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.darkBrandColor),
            );
          }

          if (controller.companyInfoStatus == ApiStatus.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: Colors.redAccent,
                      size: 32.sp,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      controller.errorMessage.isNotEmpty
                          ? controller.errorMessage
                          : S.of(context).somethingWentWrong,
                      textAlign: TextAlign.center,
                      style: Styles().midText,
                    ),
                    SizedBox(height: 2.h),
                    GestureDetector(
                      onTap: controller.getMyCompanyInfo,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          S.of(context).tryAgain,
                          style: Styles().buttonText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.companyInfoStatus == ApiStatus.empty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.business_center_outlined,
                      color: Colors.white,
                      size: 34.sp,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      S.of(context).noCompanyFoundYet,
                      textAlign: TextAlign.center,
                      style: Styles().bigText,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      S
                          .of(context)
                          .yourCompanyProfileWillAppearHereOnceItIsCreated,
                      textAlign: TextAlign.center,
                      style: Styles().smallText.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          final company = controller.myCompanyResponseResult.first;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildHeader(),
                  SizedBox(height: 2.5.h),
                  _buildCompanyProfileCard(company),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 0.5.h),
        CommonViews().customText(
          textContent: S.of(context).myCompany,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          textColor: AppColors.buttonColor,
        ),
        SizedBox(height: 0.7.h),
        Text(
          S.of(context).yourCompanyProfileInOnePlace,
          textAlign: TextAlign.center,
          style: Styles().smallText,
        ),
      ],
    );
  }

  Widget _buildCompanyProfileCard(MyCompanyResponseResult company) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 8.h),
          padding: EdgeInsets.fromLTRB(18, 10.h, 18, 2.2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                AppColors.borderTextFieldColor.withAlpha(235),
                AppColors.darkBrandColor.withAlpha(235),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white.withAlpha(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(45),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                company.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles().bigText.copyWith(
                  color: Colors.white,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 1.h),
              _buildStatusBadge(company.status),
              if (company.status.toLowerCase() == 'pending')
                _buildPendingMessage(),
              SizedBox(height: 1.2.h),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonColor.withAlpha(220),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Text(
                  '${S.of(context).categoryDot} ${_companyController.getCategoryNameById(company.categoryId)}',
                  style: Styles().smallText.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              _infoTile(
                icon: Icons.person_outline_rounded,
                title: S.of(context).founder,
                value:
                    company.founderName?.isNotEmpty == true
                        ? company.founderName!
                        : S.of(context).notProvided,
              ),
              SizedBox(height: 1.6.h),
              _infoTile(
                icon: Icons.description_outlined,
                title: S.of(context).description,
                value: company.description,
              ),
              SizedBox(height: 1.6.h),
              _infoTile(
                icon: Icons.calendar_today_outlined,
                title: S.of(context).createdAt,
                value: company.createdAt.toString().split('.').first,
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [AppColors.buttonColor, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.buttonColor.withAlpha(130),
                  blurRadius: 25,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Container(
              height: 16.h,
              width: 16.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(20),
              ),
              clipBehavior: Clip.antiAlias,
              child:
                  company.logo.isEmpty
                      ? Icon(
                        Icons.business_rounded,
                        size: 40.sp,
                        color: AppColors.buttonColor,
                      )
                      : AppCachedImage(
                        // url: "http://moneymaker-app.com/storage/${company.logo}",
                        url: company.logo,
                        width: 16.h,
                        height: 16.h,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(100),
                        errorWidget: Center(
                          child: Icon(
                            Icons.business_rounded,
                            size: 40.sp,
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(18),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withAlpha(30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.buttonColor.withAlpha(210),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.black, size: 20.sp),
          ),
          SizedBox(width: 3.5.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  style: Styles().smallText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 0.6.h),
                Text(
                  value,
                  style: Styles().smallText.copyWith(
                    color: Colors.white70,
                    height: 1.4,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isActive = status.toLowerCase() == 'active';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.withAlpha(180) : AppColors.buttonColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withAlpha(40)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.access_time,
            color: Colors.white,
            size: 16.sp,
          ),
          SizedBox(width: 6),
          Text(
            isActive ? S.of(context).active : S.of(context).pending,
            style: Styles().smallText.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPendingMessage() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 1.5.h),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.orange.withAlpha(40),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.orange.withAlpha(120)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange, size: 20.sp),
          SizedBox(width: 3.w),
          GetBuilder<ContactUsController>(
            builder: (controller) {
              return Expanded(
                child: Text(
                  S
                      .of(context)
                      .unlockRequirementText(
                        controller.contactUs?.conditionValue ?? 0,
                      ),
                  style: Styles().smallText.copyWith(
                    color: Colors.orange.shade200,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGuestView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 4.h),
            Image.asset(
              appLogo,
              width: AppSize.logoWidthCommon,
              height: 15.5.h,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 4.h),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              decoration: BoxDecoration(
                color: AppColors.darkBrandColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFFFCC80)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock, color: Colors.orange, size: 32.sp),
                  SizedBox(height: 2.h),
                  Text(
                    S.of(context).companyAccessLocked,
                    style: Styles().mainText.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 1.h),

                  Text(
                    S.of(context).logInOrSignUpToCreateAndManageYour,
                    style: Styles().smallText.copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 2.5.h),

                  GestureDetector(
                    onTap: () {
                      AppNavigator.of(
                        context,
                        rootNavigator: true,
                      ).pushAndRemoveUntil(LoginScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFA726),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        S.of(context).getStarted,
                        style: Styles().buttonText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
