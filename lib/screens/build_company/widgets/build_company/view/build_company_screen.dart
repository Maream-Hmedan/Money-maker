import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/l10n/app_locale.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/controller/build_company_controller.dart';
import 'package:money_maker/screens/build_company/widgets/build_company/model/company_categories_response.dart';
import 'package:money_maker/widgets/text_field_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class BuildCompanyScreen extends StatefulWidget {
  const BuildCompanyScreen({super.key});

  @override
  State<BuildCompanyScreen> createState() => _BuildCompanyScreenState();
}

class _BuildCompanyScreenState extends State<BuildCompanyScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _key = GlobalKey();
  final CompanyController _companyController = Get.put(CompanyController());
  late AnimationController _btnController;
  late Animation<double> _scaleAnimation;

  final _companyNameController = TextEditingController();
  final _founderNameController = TextEditingController();
  final _descController = TextEditingController();

  final _companyFocus = FocusNode();
  final _founderFocus = FocusNode();
  final _descFocus = FocusNode();

  final errorCompanyNameMessage = RxString('');
  final errorFounderNameMessage = RxString('');
  final errorDescMessage = RxString('');
  final errorCategoryMessage = RxString('');
  final errorLogoMessage = RxString('');

  CompanyCategories? selectedCategory;

  File? logoFile;


  @override
  void initState() {
    super.initState();

    _btnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1,
    ).animate(CurvedAnimation(parent: _btnController, curve: Curves.easeInOut));
    Get.put(CompanyController());
  }

  @override
  void dispose() {
    _btnController.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        logoFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Color(0xFFFF3CAC);
    final Color glow = Color(0xFFFF7AAB);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.borderTextFieldColor,
                  AppColors.darkBrandColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                        alignment:
                            AppLocale().isArabic()
                                ? Alignment.topRight
                                : Alignment.topLeft,
                        child: _backButton(),
                      ),
                    Image.asset(
                      appLogo,
                      width: AppSize.logoWidthSignUpLogIn,
                      height: AppSize.logoHeightSignUpLogIn,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      S.of(context).buildYourCompany,
                      style: Styles().bigText.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: AppSize.heightBetweenTextField),
                    GestureDetector(
                      onTap: _pickLogo,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withAlpha(40),
                              Colors.white.withAlpha(10),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  logoFile != null
                                      ? glow.withAlpha(150)
                                      : Colors.black26,
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child:
                            logoFile == null
                                ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo,
                                      color: AppColors.whiteColor,
                                      size: 26.sp,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      S.of(context).addLogo,
                                      style: Styles().smallText.copyWith(
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                )
                                : Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        logoFile!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Positioned(
                                      top: 6,
                                      right: 6,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            logoFile = null;
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.black54,
                                          child: Icon(
                                            Icons.close,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                    Obx(() {
                      return errorLogoMessage.isNotEmpty
                          ? _errorText(errorLogoMessage.value)
                          : const SizedBox.shrink();
                    }),
                    SizedBox(height: AppSize.heightBetweenTextField),
                    TextFieldWidget(
                      controller: _companyNameController,
                      focusNode: _companyFocus,
                      keyboardType: TextInputType.text,
                      label: S.of(context).companyName,
                      hint: S.of(context).enterCompanyName,
                      onSubmitted: (v) => _founderFocus.requestFocus(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          errorCompanyNameMessage.value =
                              S
                                  .of(context)
                                  .pleaseGiveYourCompanyANameThatShines;
                          return "";
                        }
                        return null;
                      },
                      fillColor: Colors.white.withAlpha(30),
                      textColor: Colors.white,
                    ),
                    Obx(() {
                      return errorCompanyNameMessage.isNotEmpty
                          ? _errorText(errorCompanyNameMessage.value)
                          : const SizedBox.shrink();
                    }),
                    SizedBox(height: AppSize.heightBetweenTextField),

                    TextFieldWidget(
                      controller: _founderNameController,
                      focusNode: _founderFocus,
                      keyboardType: TextInputType.text,
                      label: S.of(context).founderName,
                      hint: S.of(context).yourName,
                      onSubmitted: (v) => _descFocus.requestFocus(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          errorFounderNameMessage.value =
                              S
                                  .of(context)
                                  .yourCompanyNeedsAFounderFillInYourName;
                          return "";
                        }
                        return null;
                      },
                      fillColor: Colors.white.withAlpha(30),
                      textColor: Colors.white,
                    ),
                    Obx(() {
                      return errorFounderNameMessage.isNotEmpty
                          ? _errorText(errorFounderNameMessage.value)
                          : const SizedBox.shrink();
                    }),
                    SizedBox(height: AppSize.heightBetweenTextField),

                    Align(
                      alignment:
                          AppLocale().isArabic()
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      child: Text(
                        S.of(context).category,
                        style: Styles().midText.copyWith(color: Colors.white70),
                      ),
                    ),
                    SizedBox(height: AppSize.heightBetweenTextField),
                    GetBuilder<CompanyController>(
                      builder: (controller) {
                        if (controller.categoriesStatus == ApiStatus.loading) {
                          return const CompanyCategoriesShimmer();
                        }

                        if (controller.categoriesStatus == ApiStatus.error) {
                          return Center(
                            child: Text(
                              S.of(context).unableToLoadCategoriesRightNowPleaseTryAgainLater,
                              style: Styles().smallText.copyWith(color: Colors.white),
                            ),
                          );
                        }

                        if (controller.categoriesStatus == ApiStatus.empty) {
                          return Center(
                            child: Text(
                              S.of(context).noCategoriesAvailableAtTheMoment,
                              style: Styles().smallText.copyWith(color: Colors.white),
                            ),
                          );
                        }

                        final categories = controller.companyCategories;

                        return Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            alignment: WrapAlignment.start,
                            children: categories.map((cat) {
                              final isSelected = cat == selectedCategory;

                              return GestureDetector(
                                onTap: () {
                                  setState(() => selectedCategory = cat);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: isSelected
                                        ? primary
                                        : Colors.white.withAlpha(25),
                                    boxShadow: isSelected
                                        ? [
                                      BoxShadow(
                                        color: glow.withAlpha(140),
                                        blurRadius: 14,
                                      ),
                                    ]
                                        : [],
                                  ),
                                  child: Text(
                                    cat.localizedName,
                                    style: Styles().smallText.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    Obx(() {
                      return errorCategoryMessage.isNotEmpty
                          ? _errorText(errorCategoryMessage.value)
                          : const SizedBox.shrink();
                    }),
                    SizedBox(height: AppSize.heightBetweenTextField),
                    SizedBox(height: AppSize.heightBetweenTextField),

                    /// DESCRIPTION
                    TextFieldWidget(
                      controller: _descController,
                      focusNode: _descFocus,
                      keyboardType: TextInputType.multiline,
                      label: S.of(context).shortDescription,
                      hint:
                          S
                              .of(context)
                              .describeWhatMakesYourCompanyUniqueAndPowerful,
                      maxLines: 4,
                      onSubmitted:
                          (v) => FocusManager.instance.primaryFocus?.unfocus(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          errorDescMessage.value =
                              S
                                  .of(context)
                                  .tellUsWhatMakesYourCompanyUniqueAndExciting;
                          return "";
                        }
                        return null;
                      },
                      fillColor: Colors.white.withAlpha(30),
                      textColor: Colors.white,
                    ),
                    Obx(() {
                      return errorDescMessage.isNotEmpty
                          ? _errorText(errorDescMessage.value)
                          : const SizedBox.shrink();
                    }),
                    SizedBox(height: AppSize.heightBetweenTextAndButton),

                    AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: GestureDetector(
                            onTap: () async {
                              _cleanError();
                              bool isValid = true;

                              if (!_key.currentState!.validate()) {
                                isValid = false;
                              }

                              if (selectedCategory == null) {
                                errorCategoryMessage.value =
                                    S.of(context).pickACategoryToShowWhatYourCompanyIsAll;
                                isValid = false;
                              }

                              if (logoFile == null) {
                                errorLogoMessage.value =
                                    S.of(context).pleaseAddYourCompanyLogo;
                                isValid = false;
                              }

                              if (!isValid) return;
                              await _companyController.buildCompany(
                                name: _companyNameController.text.trim(),
                                categoryId: selectedCategory!.id.toString(),
                                founderName: _founderNameController.text.trim(),
                                description: _descController.text.trim(),
                                logo: logoFile!, categoryName: selectedCategory!.localizedName,
                              );

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  colors: [primary, glow],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: glow.withAlpha(150),
                                    blurRadius: 20,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Text(
                                S.of(context).launchCompany,
                                style: Styles().buttonText,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: AppSize.heightBetweenTextField),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _cleanError() {
    errorCompanyNameMessage.value = '';
    errorFounderNameMessage.value = '';
    errorCategoryMessage.value = '';
    errorDescMessage.value = '';
    errorLogoMessage.value = '';
  }

  Padding _errorText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: Styles().errorText,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _backButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Material(
          color: Colors.white.withAlpha(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
               AppNavigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withAlpha(40)),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF7AAB).withAlpha(60),
                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
               Icons.arrow_back,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class CompanyCategoriesShimmer extends StatelessWidget {
  const CompanyCategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(6, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.white.withAlpha(25),
          highlightColor: Colors.white.withAlpha(60),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: const Text(
              'ــــــــــــ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        );
      }),
    );
  }
}
