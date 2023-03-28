import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/app_bar_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              title: Text(
                "New & Hot",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              actions: [
                Icon(
                  Icons.cast,
                  color: Colors.white,
                  size: 30,
                ),
                kWidth,
                Container(
                  width: 30,
                  height: 30,
                  color: Colors.blue,
                ),
                kWidth,
              ],
              bottom:  TabBar(
                unselectedLabelColor: kWhiteColor,
                labelColor: kBlackColor,
                isScrollable: true,
                labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  color:kWhiteColor,
                  borderRadius: kRadius30,
                   ),
                
                tabs: [
                Tab(
                  text: "🍿Coming Soon",
                ),
                Tab(
                  text: "👀 Everyone's watching",
                )
              ]),
            )),
        body: TabBarView(children: [
          _buildTabBarView(),
          _buildTabBarView

        ]),
      ),
    );
  }
  _buildTabBarView(){
    return 
  }
  }

