import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/app_size.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/screens/build_company/widgets/start_game_screen.dart';
import 'package:money_maker/widgets/text_field_widget.dart';
import 'package:sizer/sizer.dart';

class BuildCompanyScreen extends StatefulWidget {
  const BuildCompanyScreen({super.key});

  @override
  State<BuildCompanyScreen> createState() => _BuildCompanyScreenState();
}

class _BuildCompanyScreenState extends State<BuildCompanyScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _key = GlobalKey();
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

  String selectedCategory = '';

  File? logoFile;

  final List<String> categories = [
    'Tech',
    'Finance',
    'Gaming',
    'AI',
    'E-commerce',
    'Education',
  ];

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
                    Image.asset(
                      appLogo,
                      width: AppSize.logoWidthSignUpLogIn,
                      height: AppSize.logoHeightSignUpLogIn,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'BUILD YOUR COMPANY',
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
                                      'Add Logo',
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
                      label: 'Company Name',
                      hint: 'Enter company name',
                      onSubmitted: (v) => _founderFocus.requestFocus(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          errorCompanyNameMessage.value =
                              'Please give your company a name that shines!';
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
                      label: 'Founder Name',
                      hint: 'Your name',
                      onSubmitted: (v) => _descFocus.requestFocus(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          errorFounderNameMessage.value =
                              'Your company needs a founder — fill in your name!';
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
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Category',
                        style: Styles().midText.copyWith(color: Colors.white70),
                      ),
                    ),
                    SizedBox(height: AppSize.heightBetweenTextField),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children:
                          categories.map((cat) {
                            final isSelected = cat == selectedCategory;

                            return GestureDetector(
                              onTap: () {
                                setState(() => selectedCategory = cat);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 250),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color:
                                      isSelected
                                          ? primary
                                          : Colors.white.withAlpha(25),
                                  boxShadow:
                                      isSelected
                                          ? [
                                            BoxShadow(
                                              color: glow.withAlpha(140),
                                              blurRadius: 14,
                                            ),
                                          ]
                                          : [],
                                ),
                                child: Text(
                                  cat,
                                  style: Styles().smallText.copyWith(
                                    color: Colors.white,
                                  ),
                                  // style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }).toList(),
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
                      label: 'Short Description',
                      hint:
                          'Describe what makes your company unique and powerful...',
                      maxLines: 4,
                      onSubmitted:
                          (v) => FocusManager.instance.primaryFocus?.unfocus(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          errorDescMessage.value =
                              'Tell us what makes your company unique and exciting!';
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
                            onTap: () {
                              _cleanError();
                              bool isValid = true;
                              if (!_key.currentState!.validate()) {
                                isValid = false;
                              }
                              if (selectedCategory.isEmpty) {
                                errorCategoryMessage.value =
                                    'Pick a category to show what your company is all about!';
                                isValid = false;
                              }

                              if (logoFile == null) {
                                errorLogoMessage.value =
                                    'Please add your company logo!';
                                isValid = false;
                              }
                              if (isValid) {
                                AppNavigator.of(context).push(
                                  CompanyOverviewScreen(
                                    logoFile: logoFile,
                                    companyName: _companyNameController.text,
                                    founderName: _founderNameController.text,
                                    category: selectedCategory,
                                    description: _descController.text,
                                  ),
                                );
                              }
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
                                'Launch Company 🚀',
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
}
