import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

Stack buildNavBar({
  required BuildContext context,
  required void Function(int) onTap,
  required int currentIndex,
}) {
 // Color getItemColor(int index) {
   // return index == currentIndex ? color : const Color(0xff646568);
  //}

  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.svgs.userRounded.svg(),
                        const SizedBox(
                          height: 5,
                        ),

                      ],
                    ),
                    onTap: () {
                      onTap(0);
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.09),
                  InkWell(
                    onTap: () {
                      onTap(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.svgs.userRounded.svg(),
                        const SizedBox(
                          height: 5,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      onTap(3);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.svgs.userRounded.svg(),
                        const SizedBox(
                          height: 5,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.09),
                  InkWell(
                    onTap: () {
                      onTap(4);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_filled,

                          size: 25,
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Transform.scale(
          scale: 1.2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  blurRadius: 9,
                  spreadRadius: 0,
                  color: const Color(0xffFF7A28).withOpacity(.5),
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: FloatingActionButton(
              backgroundColor: const Color(0xffFF7A28),
              onPressed: () {},
              elevation: 0.0,
              child:  Assets.svgs.userRounded.svg(),
            ),
          ),
        ),
      ),
    ],
  );
}