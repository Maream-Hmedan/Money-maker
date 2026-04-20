import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/controllers/app_navigation.dart';
import 'package:money_maker/controllers/styles.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:money_maker/screens/settings/contact_us/controller/contact_us_controller.dart';
import 'package:sizer/sizer.dart';

class CompanyOverviewScreen extends StatefulWidget {
  const CompanyOverviewScreen({super.key});

  @override
  State<CompanyOverviewScreen> createState() => _CompanyOverviewScreenState();
}

class _CompanyOverviewScreenState extends State<CompanyOverviewScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _contentController;
  late final Animation<double> _logoScale;
  late final Animation<double> _contentOpacity;
  late final Animation<Offset> _buttonSlide;

  final ContactUsController controller = Get.put(ContactUsController());

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _logoScale = Tween<double>(
      begin: 0.96,
      end: 1.04,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: Curves.easeInOut,
      ),
    );

    _contentOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: Curves.easeOut,
      ),
    );

    _buttonSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _contentController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Positioned(
            top: 10.h,
            right: 10.w,
            child: Icon(
              Icons.auto_awesome,
              color: Colors.white.withAlpha(80),
              size: 24.sp,
            ),
          ),
          Positioned(
            bottom: 18.h,
            left: 12.w,
            child: Icon(
              Icons.auto_awesome,
              color: Colors.white.withAlpha(60),
              size: 18.sp,
            ),
          ),
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _contentOpacity,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.white.withAlpha(18),
                      border: Border.all(
                        color: Colors.white.withAlpha(35),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(35),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ScaleTransition(
                          scale: _logoScale,
                          child: Container(
                            width: 24.w,
                            height: 24.w,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withAlpha(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withAlpha(35),
                                  blurRadius: 22,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              appLogo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          S.of(context).companyCreatedSuccessfully,
                          textAlign: TextAlign.center,
                          style: Styles().bigText.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        SizedBox(height: 1.2.h),
                        Text(
                          S.of(context).getYourAssetsUnlockYourCompanyAndStartYourJourney,
                          textAlign: TextAlign.center,
                          style: Styles().midText.copyWith(
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 3.5.h),
                        SlideTransition(
                          position: _buttonSlide,
                          child: GestureDetector(
                            onTap: () {
                              AppNavigator.of(context).push(BottomNavBarScreen());
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.buttonColor,
                                    const Color(0xFFFF7AAB),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.buttonColor.withAlpha(120),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.play_circle_fill_rounded,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                  SizedBox(width: 2.w),
                                  Flexible(
                                    child: Text(
                                      S.of(context).startPlayingBuyAssets,
                                      textAlign: TextAlign.center,
                                      style: Styles().buttonText.copyWith(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class CompanyOverviewScreen extends StatelessWidget {
//   final File? logoFile;
//   final String? logoUrl;
//   final String companyName;
//   final String founderName;
//   final String category;
//   final String description;
//
//   CompanyOverviewScreen({
//     super.key,
//     this.logoFile,
//     this.logoUrl,
//     required this.companyName,
//     required this.founderName,
//     required this.category,
//     required this.description,
//   });
//
//   final ContactUsController controller = Get.put(ContactUsController());
//
//   @override
//   Widget build(BuildContext context) {
//     final Color glow = Color(0xFFFF7AAB);
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppColors.borderTextFieldColor,
//                   AppColors.darkBrandColor,
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: AppSize.heightBetweenTextField),
//                   Column(
//                     children: [
//                       Container(
//                         width: AppSize.logoWidthCompany,
//                         height: AppSize.logoHeightCompany,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: glow.withAlpha(180),
//                               blurRadius: 4.w,
//                               offset: Offset(0, 2.w),
//                             ),
//                           ],
//                         ),
//                         child: ClipOval(
//                           child:
//                           logoFile != null
//                               ? Image.file(
//                             logoFile!,
//                             fit: BoxFit.cover,
//                             width: AppSize.logoWidthCompany,
//                             height: AppSize.logoHeightCompany,
//                           )
//                               : fullLogoUrl != null
//                               ? AppCachedImage(
//                             url: fullLogoUrl,
//                             width: AppSize.logoWidthCompany,
//                             height: AppSize.logoHeightCompany,
//                             fit: BoxFit.cover,
//                             borderRadius: BorderRadius.circular(999),
//                             errorWidget: Container(
//                               color: Colors.white24,
//                               alignment: Alignment.center,
//                               child: Icon(
//                                 Icons.business,
//                                 color: Colors.white,
//                                 size: 12.w,
//                               ),
//                             ),
//                           )
//                               : Container(
//                             color: Colors.white24,
//                             alignment: Alignment.center,
//                             child: Icon(
//                               Icons.business,
//                               color: Colors.white,
//                               size: 12.w,
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Container(
//                       //   width: AppSize.logoWidthCompany,
//                       //   height: AppSize.logoHeightCompany,
//                       //   decoration: BoxDecoration(
//                       //     shape: BoxShape.circle,
//                       //     boxShadow: [
//                       //       BoxShadow(
//                       //         color: glow.withAlpha(180),
//                       //         blurRadius: 4.w,
//                       //         offset: Offset(0, 2.w),
//                       //       ),
//                       //     ],
//                       //     image: logoFile != null
//                       //         ? DecorationImage(
//                       //       image: FileImage(logoFile!),
//                       //       fit: BoxFit.cover,
//                       //     )
//                       //         : null,
//                       //     color: logoFile == null ? Colors.white24 : null,
//                       //   ),
//                       //   child: logoFile == null
//                       //       ? Icon(
//                       //     Icons.business,
//                       //     color: Colors.white,
//                       //     size: 12.w,
//                       //   )
//                       //       : null,
//                       // ),
//                       SizedBox(height: 4.w),
//
//                       // Company Name
//                       Text(
//                         companyName,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: Styles().bigText.copyWith(color: Colors.white),
//                       ),
//                       SizedBox(height: 2.w),
//                       Wrap(
//                         alignment: WrapAlignment.center,
//                         spacing: 4.w,
//                         runSpacing: 1.h,
//                         children: [
//                           Text(
//                             '${S.of(context).founder}: $founderName',
//                             style: Styles().midText.copyWith(
//                               color: Colors.white70,
//                             ),
//                           ),
//                           Text(
//                             '${S.of(context).category}: $category',
//                             style: Styles().midText.copyWith(
//                               color: Colors.white70,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 3.h),
//
//                       // Description Box
//                       Container(
//                         width: 90.w,
//                         padding: EdgeInsets.all(4.w),
//                         decoration: BoxDecoration(
//                           color: Colors.white24,
//                           borderRadius: BorderRadius.circular(4.w),
//                         ),
//                         child: Text(
//                           description,
//                           style: Styles().smallText.copyWith(
//                             color: Colors.white,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       SizedBox(height: 6.w),
//                     ],
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(24),
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.darkBrandColor,
//                           AppColors.borderTextFieldColor,
//                           const Color(0xFFFF7AAB),
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.buttonColor.withAlpha(80),
//                           blurRadius: 25,
//                           spreadRadius: 2,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                       border: Border.all(
//                         color: AppColors.buttonColor.withAlpha(120),
//                         width: 1.5,
//                       ),
//                     ),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24),
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.white.withAlpha(25),
//                             Colors.transparent,
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 14,
//                               vertical: 8,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withAlpha(35),
//                               borderRadius: BorderRadius.circular(30),
//                               border: Border.all(color: Colors.white24),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.hourglass_top_rounded,
//                                   color: Colors.white,
//                                   size: 17.sp,
//                                 ),
//                                 SizedBox(width: 2.w),
//                                 Text(
//                                   S.of(context).statusPending,
//                                   style: Styles().smallText.copyWith(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: AppSize.heightBetweenTextField),
//                           Container(
//                             width: 20.w,
//                             height: 20.w,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white.withAlpha(30),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.white.withAlpha(60),
//                                   blurRadius: 18,
//                                   spreadRadius: 2,
//                                 ),
//                               ],
//                             ),
//                             child: Icon(
//                               Icons.business_center_rounded,
//                               color: Colors.white,
//                               size: 10.w,
//                             ),
//                           ),
//                           SizedBox(height: AppSize.heightBetweenTextField),
//                           Text(
//                             S.of(context).companyCreatedSuccessfully,
//                             textAlign: TextAlign.center,
//                             style: Styles().bigText.copyWith(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//
//                           SizedBox(height: 1.h),
//                           Text(
//                             S
//                                 .of(context)
//                                 .youHaveSuccessfullyEstablishedYourCompanyButItIsStill,
//                             textAlign: TextAlign.center,
//                             style: Styles().midText.copyWith(
//                               color: Colors.white70,
//                             ),
//                           ),
//                           SizedBox(height: AppSize.heightBetweenTextField),
//
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(14),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withAlpha(25),
//                               borderRadius: BorderRadius.circular(18),
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.lock_open_rounded,
//                                       color: AppColors.buttonColor,
//                                       size: 6.w,
//                                     ),
//                                     SizedBox(width: 2.w),
//                                     Text(
//                                       S.of(context).unlockRequirement,
//                                       style: Styles().midText.copyWith(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 1.h),
//                                 GetBuilder<ContactUsController>(
//                                   builder: (controller) {
//                                     return Text(
//                                       S
//                                           .of(context)
//                                           .unlockRequirementText(
//                                         controller
//                                             .contactUs
//                                             ?.conditionValue ??
//                                             0,
//                                       ),
//                                       textAlign: TextAlign.center,
//                                       style: Styles().smallText.copyWith(
//                                         color: Colors.white,
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           SizedBox(height: AppSize.heightBetweenTextField),
//
//                           GestureDetector(
//                             onTap: () {
//                               AppNavigator.of(
//                                 context,
//                               ).push(BottomNavBarScreen());
//                             },
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 26,
//                                 vertical: 14,
//                               ),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30),
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     AppColors.buttonColor,
//                                     const Color(0xFFFF7AAB),
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: AppColors.buttonColor.withAlpha(120),
//                                     blurRadius: 15,
//                                     offset: const Offset(0, 6),
//                                   ),
//                                 ],
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   const Icon(
//                                     Icons.shopping_cart_checkout_rounded,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(width: 2.w),
//                                   Text(
//                                     S.of(context).buyAssets,
//                                     style: Styles().buttonText.copyWith(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 1.h),
//                           Text(
//                             S.of(context).unlockYourCompanyAndEnterTheGameWorld,
//                             textAlign: TextAlign.center,
//                             style: Styles().smallText.copyWith(
//                               color: Colors.white70,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String? get fullLogoUrl {
//     if (logoUrl == null || logoUrl!.trim().isEmpty) return null;
//
//     if (logoUrl!.startsWith('http')) {
//       return logoUrl;
//     }
//
//     return 'http://moneymaker-app.com/storage/$logoUrl';
//   }
//
// }