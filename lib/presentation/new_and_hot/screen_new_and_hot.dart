import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_clone/presentation/new_and_hot/widgets/everyones_watching_widget.dart';



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
              title: const Text(
                "New & Hot",
                style:  TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              actions: [
               const  Icon(
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
                labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),
                indicator: BoxDecoration(
                  color:kWhiteColor,
                  borderRadius: kRadius30,
                   ),
                
                tabs: const [
                Tab(
                  text: "🍿Coming Soon",
                ),
                Tab(
                  text: "👀 Everyone's watching",
                )
              ]),
            )),
        body: TabBarView(children: [
          _buildComingSoon(),
          _buildEveryonesWatching(),

        ]
        ),
      ),
    );
  }
  
   Widget _buildComingSoon() {
    
    return ListView.builder
    (itemCount: 10,
      itemBuilder: (BuildContext context, index) {
      return const ComingSoonWidget();
    }
    );
       
      
    

   }
  
  _buildEveryonesWatching() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, index) =>  const EveryonesWatchingWidget());

  }
 
  }



