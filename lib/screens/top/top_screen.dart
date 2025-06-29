import 'package:flutter/material.dart';
import 'package:money_maker/controllers/app_colors.dart';
import 'package:money_maker/controllers/app_images.dart';
import 'package:money_maker/widgets/background_widget.dart';
import 'package:money_maker/widgets/common_views.dart';
import 'package:sizer/sizer.dart';

class TopPlayersPage extends StatefulWidget {

   const TopPlayersPage({super.key});

  @override
  State<TopPlayersPage> createState() => _TopPlayersPageState();
}

class _TopPlayersPageState extends State<TopPlayersPage> {
  final players = [
    {'rank': 1, 'name': 'Omar', 'points': 15890, 'color': Colors.amber, 'isTop': true,'photo':boyProfile},
    {'rank': 2, 'name': 'Rania', 'points': 14250, 'color': Colors.purple,'photo':girlProfile},
    {'rank': 3, 'name': 'Ahmed', 'points': 13760, 'color': Colors.purple,'photo':boyProfile},
    {'rank': 4, 'name': 'Ahmed', 'points': 12950, 'color': Colors.orange,'photo':boyProfile},
    {'rank': 5, 'name': 'Maria', 'points': 12800, 'color': Colors.deepPurple,'photo':girlProfile},
    {'rank': 6, 'name': 'Sami', 'points': 12600, 'color': Colors.deepPurple,'photo':boyProfile},
    {'rank': 7, 'name': 'Layla', 'points': 12550, 'color': Colors.deepPurple,'photo':girlProfile},
  ];

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CommonViews().customText(
              textContent:"TOP PLAYERS",
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
                selectedBorderColor:AppColors.borderTextFieldColor,
                fillColor: Colors.transparent,
                selectedColor: Colors.black,
                color: Colors.black,
                isSelected: [true, true, true],
                onPressed: (_) {},
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: CommonViews().customText(
                      textContent: "This Week",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: CommonViews().customText(
                      textContent: "This Month",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child:  CommonViews().customText(
                      textContent: "All Time",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _topPlayer(players[1]),
                _topPlayer(players[0], isCenter: true),
                _topPlayer(players[2]),
              ],
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: ListView.builder(
                itemCount: players.length - 3,
                itemBuilder: (context, i) {
                  final player = players[i + 3];
                  final bool isTopRow = player['rank'] == 4;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isTopRow ? AppColors.buttonColor : Colors.transparent,
                      border: Border.all(
                        color: isTopRow ? Color(0xFFFFCC80) : AppColors.borderTextFieldColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CommonViews().customText(
                          textContent:   '${player['rank']}',
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w700,
                          textColor: isTopRow ? Colors.indigo : Colors.black,
                        ),
                        SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: isTopRow ? Colors.amber : AppColors.borderTextFieldColor,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: ClipOval(
                              child: Image.asset(
                                player['photo'] as String? ?? '',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child:
                          CommonViews().customText(
                            textContent: player['name'] as String? ?? '',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            textColor:isTopRow ?Colors.white: Colors.black,
                          ),
                        ),
                        CommonViews().customText(
                          textContent:  (player['points'] as num).toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.'),
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          textColor:isTopRow ?Colors.white: Colors.black,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topPlayer(Map player, {bool isCenter = false}) {
    final bool isTop = player['isTop'] == true;
    final int rank = player['rank'];

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
                      textContent:  '$rank',
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.buttonColor,
                    ),

                  ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isTop ? AppColors.buttonColor : Colors.transparent,
                      border: Border.all(
                        color: isTop ? Color(0xFFFFCC80) : AppColors.borderTextFieldColor,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: isCenter ? 50 : 30,
                      backgroundColor: isTop ? AppColors.buttonColor : Colors.transparent,
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
                            padding: EdgeInsets.only(top: 3),
                            child: SizedBox(
                              height: isCenter ? 9.h : 5.h,
                              width: isCenter ? 20.w : 12.w,
                              child: Image.asset(
                                player['photo'],
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
            textContent: player['name'],
            fontSize:  isCenter ? 19.sp : 18.sp,
            fontWeight: FontWeight.w700,
            textColor: AppColors.buttonColor,
          ),
          CommonViews().customText(
            textContent: '${player['points'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')} pts',
            fontSize: isCenter ? 18.sp : 16.sp,
            fontWeight: FontWeight.w700,
            textColor: Colors.black,
          ),
        ],
      ),
    );
  }

}
