import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/widgets/custom_button_widget.dart';
import 'package:netflix_clone/presentation/widgets/video_widgets.dart';

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({
    super.key,
    
  });

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 450,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const[
              Text("FEB",
              style: TextStyle(
                fontSize: 16,
                color: kGreyColor,
                
              ),
              ),
              Text("11",
               style: TextStyle(
                fontSize: 30,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
               ),)
            ],
          ),
        ),
        VideoWidget(),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("TALL GIRL 2",
            style: TextStyle(
              fontSize: 35,
            fontWeight: FontWeight.bold,
            letterSpacing: -5,

            ),
            ),
            const Spacer(),
            Row(
              children: const [
                CustomButtonWidget(
                  icon: Icons.alarm_on,
                   title: 'Remind me',
                   iconSize: 20,
                   textSize: 12,
                   ),
                   kWidth,
                   CustomButtonWidget(
                  icon: Icons.info,
                   title: 'Info',
                   iconSize: 20,
                   textSize: 12,
                   ),
                   kWidth,
                   ],
            )

              ],
            ),
            kHeight,
            const Text("Coming on Friday"),
            kHeight,
            const Text("Tall Girl 2",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
            kHeight,
            const Text("Landing the lead in the school musical is a dream come for Jodi, until the pressure sends her confidence - and her relaionship- into a tailspin.",
            style: TextStyle(color: kGreyColor),)
          ],
        );
  }
}

