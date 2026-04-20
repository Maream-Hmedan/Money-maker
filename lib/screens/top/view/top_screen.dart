import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/generated/l10n.dart';
import 'package:money_maker/screens/top/controller/top_controller.dart';
import 'package:money_maker/screens/top/model/top_response.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class TopPlayersPage extends StatefulWidget {
  final bool showAppBar;

  const TopPlayersPage({super.key, required this.showAppBar});

  @override
  State<TopPlayersPage> createState() => _TopPlayersPageState();
}

class _TopPlayersPageState extends State<TopPlayersPage> {
  final TopLeaderBoardController controller =
  Get.put(TopLeaderBoardController());

  int selectedIndex = 0;

  String _formatProfit(String value) {
    final number = double.tryParse(value) ?? 0;

    if (number % 1 == 0) {
      return number.toInt().toString();
    }

    return number.toStringAsFixed(2);
  }

  String _profileImageByIndex(int index) {
    return index % 2 == 0 ? boyProfile :girlProfile ;
  }

  void _onTogglePressed(int index) {
    setState(() {
      selectedIndex = index;
    });

    if (index == 0) {
      controller.fetchLeaderBoard(period: 'week');
    } else if (index == 1) {
      controller.fetchLeaderBoard(period: 'month');
    } else {
      controller.fetchLeaderBoard(period: 'year');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showAppBar: widget.showAppBar,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CommonViews().customText(
              textContent: S.of(context).topPlayers,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              textColor: AppColors.buttonColor,
            ),
            SizedBox(height: 2.h),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderTextFieldColor),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(30),
                borderColor: AppColors.borderTextFieldColor,
                selectedBorderColor: AppColors.borderTextFieldColor,
                fillColor: AppColors.buttonColor.withAlpha(31),
                selectedColor: Colors.black,
                color: Colors.black,
                isSelected: [
                  selectedIndex == 0,
                  selectedIndex == 1,
                  selectedIndex == 2,
                ],
                onPressed: _onTogglePressed,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: CommonViews().customText(
                      textContent: S.of(context).thisWeek,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: CommonViews().customText(
                      textContent: S.of(context).thisMonth,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                    ),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: CommonViews().customText(
                      textContent: S.of(context).allTime,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 3.h),

            Expanded(
              child: GetBuilder<TopLeaderBoardController>(
                builder: (ctrl) {
                  if (ctrl.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.buttonColor,
                      ),
                    );
                  }

                  if (ctrl.isError) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: CommonViews().customText(
                          textContent:
                          S.of(context).somethingWentWrongWhileLoadingTheLeaderboardPleaseTryAgain,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.red,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  if (ctrl.isEmpty || ctrl.leaderboard.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: CommonViews().customText(
                          textContent:
                          S.of(context).noPlayersFoundForTheSelectedPeriod,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          textColor: Colors.black54,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  final players = ctrl.leaderboard;

                  return Column(
                    children: [
                      if (players.length >= 3)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _topPlayer(players[1], 1),
                            _topPlayer(players[0], 0, isCenter: true),
                            _topPlayer(players[2], 2),
                          ],
                        )
                      else if (players.length == 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _topPlayer(players[0], 0, isCenter: true),
                            _topPlayer(players[1], 1),
                          ],
                        )
                      else if (players.length == 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _topPlayer(players[0], 0, isCenter: true),
                            ],
                          ),

                      SizedBox(height: 2.h),

                      if (players.length > 3)
                        Expanded(
                          child: ListView.builder(
                            itemCount: players.length - 3,
                            itemBuilder: (context, i) {
                              final player = players[i + 3];
                              final bool isTopRow = player.rank == 4;

                              return Container(
                                margin:
                                const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isTopRow
                                      ? AppColors.buttonColor
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: isTopRow
                                        ? const Color(0xFFFFCC80)
                                        : AppColors.borderTextFieldColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    CommonViews().customText(
                                      textContent: '${player.rank}',
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.w700,
                                      textColor: isTopRow
                                          ? Colors.indigo
                                          : Colors.black,
                                    ),
                                    SizedBox(width: 4.w),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border: Border.all(
                                          color: isTopRow
                                              ? Colors.amber
                                              : AppColors
                                              .borderTextFieldColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.transparent,
                                        child: Padding(
                                          padding: EdgeInsets.zero,
                                          child: ClipOval(
                                            child: Image.asset(
                                              _profileImageByIndex(i + 3),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: CommonViews().customText(
                                        textContent: player.user?.name??'',
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        textColor: isTopRow
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    CommonViews().customText(
                                      textContent:
                                      _formatProfit(player.profit),
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                      textColor: isTopRow
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topPlayer(
      Leaderboard player,
      int index, {
        bool isCenter = false,
      }) {
    final bool isTop = player.rank == 1;
    final int rank = player.rank;

    return Expanded(
      flex: isCenter ? 2 : 1,
      child: Column(
        children: [
          SizedBox(
            height: isCenter ? 15.h : 13.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!isCenter)
                  Positioned(
                    top: 0,
                    child: CommonViews().customText(
                      textContent: '$rank',
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.buttonColor,
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isTop
                          ? AppColors.buttonColor
                          : Colors.transparent,
                      border: Border.all(
                        color: isTop
                            ? const Color(0xFFFFCC80)
                            : AppColors.borderTextFieldColor,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: isCenter ? 50 : 30,
                      backgroundColor: isTop
                          ? AppColors.buttonColor
                          : Colors.transparent,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          if (isCenter)
                            Positioned(
                              top: -11.5.h,
                              child: Image.asset(
                                crown,
                                height: 18.h,
                                width: 18.w,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: SizedBox(
                              height: isCenter ? 9.h : 5.h,
                              width: isCenter ? 20.w : 12.w,
                              child: Image.asset(
                                _profileImageByIndex(index),
                                fit: BoxFit.fill,
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
          SizedBox(height: 0.5.h),
          CommonViews().customText(
            textContent: player.user?.name??'',
            fontSize: isCenter ? 19.sp : 18.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),
          CommonViews().customText(
            textContent: S.of(context).points(_formatProfit(player.profit)),
            fontSize: isCenter ? 18.sp : 16.sp,
            fontWeight: FontWeight.w700,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

