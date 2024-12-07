import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:lamassu/modules/home/widget/sale_offers_card.dart';
import 'package:lamassu/modules/home/widget/slider_details.dart';
import 'package:lamassu/modules/home/widget/text_offer_row.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';
import '../../offers/sales_offers.dart';
import '../cubit/cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import 'buildAdvantagesItem.dart';
import 'house_details.dart';

class buildCarousel extends StatefulWidget {
  @override
  _buildCarouselState createState() => _buildCarouselState();
}

class _buildCarouselState extends State<buildCarousel> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    final houses = context.read<HomeCubit>().lastNews;

    if (houses == null || houses.isEmpty) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: carousel.CarouselSlider(
            options: carousel.CarouselOptions(
              height: screenHeight * 0.2,
              aspectRatio: 16 / 9,
              viewportFraction: 0.85,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: context.read<HomeCubit>().lastNews!.map((news) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: SliderDetailsScreen(news: news),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  ColorName.bottomColor,
                                  ColorName.bottomColor.withOpacity(.6),
                                  ColorName.NuturalColor2,
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      // gradient: LinearGradient(
                                      //   begin: Alignment.topCenter,
                                      //   end: Alignment.bottomCenter,
                                      //   colors: [
                                      //     Colors.transparent,
                                      //     Colors.black.withOpacity(0.7),
                                      //   ],
                                      // ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              news.title!,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Sizes.fontLarge,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'اضغط للمزيد',
                                              style: TextStyle(
                                                color: ColorName.NuturalColor5,
                                                fontSize: Sizes.fontSmall,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.fill,
                                      'asset/logo_bg.png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(12),
                          //   child: Image.asset(
                          //     'asset/images/coursal.jpeg',
                          //     fit: BoxFit.fill,
                          //   ),
                          // ),
                        ),
                        // Positioned(
                        //     top: 8,
                        //     right: screenWidth * 0.15,
                        //     child: Container(
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 3, horizontal: 8),
                        //       decoration: BoxDecoration(
                        //         color:
                        //             ColorName.NuturalColor3.withOpacity(.7),
                        //         borderRadius: BorderRadius.circular(5),
                        //       ),
                        //       child: Text(
                        //         news.title!,
                        //         style: TextStyle(
                        //           color: ColorName.NuturalColor5,
                        //           fontSize: Sizes.fontSmall,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ))
                        // Positioned(
                        //   top: 40,
                        //   left: 20,
                        //   child:
                        // ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              context.read<HomeCubit>().lastNews!.asMap().entries.map((entry) {
            return buildIndicator(entry.key, currentIndex);
          }).toList(),
        ),
      ],
    );
  }

  Widget buildIndicator(int index, int currentIndex) {
    return index == currentIndex
        ? Container(
            width: 12,
            height: 12,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorName.bottomColor,
            ),
          )
        : Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
          );
  }
}

Widget buildFeaturesSection(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
        child: Text(
          AppLocalizations.of(context)!.features,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontSmall,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(height: 16),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
            itemCount: context.read<HomeCubit>().advantages!.length,
            scrollDirection: Axis.horizontal,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return buildStoryItem(
                context: context,
                advantages: context.read<HomeCubit>().advantages![index],
              );
            }),
      )
      // Row(
      //   children: [
      //     ...context.read<HomeCubit>().advantages!.asMap().entries.map((entry) {
      //       return Expanded(
      //         child: buildStoryItem(
      //           context: context,
      //           advantages: entry.value,
      //         ),
      //       );
      //     }).toList(),
      //   ],
      // ),
    ],
  );
}

Widget buildSaleOffersSection(BuildContext context, bool typeScreen) {
  final houses = context.read<HomeCubit>().houses2;

  if (houses == null || !houses.any((house) => house.existingType == "بيع")) {
    return const SizedBox();
  }

  final saleHouses =
      houses.where((house) => house.existingType == "بيع").toList();

  return Column(
    children: [
      rowTextbuildOffer(
        context: context,
        text: typeScreen == true
            ? AppLocalizations.of(context)!.sale_offers
            : AppLocalizations.of(context)!.similar,
        onPress: () => typeScreen == true
            ? PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SalesOffersScreen(
                  title: 'بيع',
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              )
            : "",
        mor: typeScreen == true ? true : false,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 32, top: 12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: saleHouses.length < 5 ? saleHouses.length : 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  typeScreen == true
                      ? PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: HouseDetails(houses: saleHouses[index]),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.slideUp,
                        )
                      : Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HouseDetails(houses: saleHouses[index]),
                          ),
                        );
                },
                child: houseOffersCard(
                  context: context,
                  houseData: saleHouses[index],
                  title: 'بيع',
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}

Widget buildRentalOffersSection(BuildContext context, bool typeScreen) {
  final houses = context.read<HomeCubit>().houses3;

  if (houses == null || !houses.any((house) => house.existingType == "ايجار")) {
    return const SizedBox();
  }

  final rentalHouses =
      houses.where((house) => house.existingType == "ايجار").toList();

  return Column(
    children: [
      rowTextbuildOffer(
        context: context,
        text: typeScreen == true
            ? AppLocalizations.of(context)!.rental_offers
            : AppLocalizations.of(context)!.similar,
        onPress: () => typeScreen == true
            ? PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: SalesOffersScreen(
                  title: 'ايجار',
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              )
            : "",
        mor: typeScreen == true ? true : false,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 32, top: 12),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          width: double.infinity,
          child: ListView.builder(
            itemCount: rentalHouses.length < 5 ? rentalHouses.length : 5,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: HouseDetails(houses: rentalHouses[index]),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.slideUp,
                  );
                },
                child: houseOffersCard(
                  context: context,
                  houseData: rentalHouses[index],
                  title: 'ايجار',
                ),
              );
            },
          ),
        ),
      ),
    ],
  );
}

Widget ShimmerbuildCarousel(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    child: Container(
      height: 171.0,
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorName.NuturalColor5,
          ),
        ),
      ),
    ),
  );
}

Widget ShimmerFeaturesSection(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Row(
      children: List.generate(
        5, // Placeholder count
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorName.NuturalColor5,
          ),
        ),
      ),
    ),
  );
}
