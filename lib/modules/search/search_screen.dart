import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shimmer/shimmer.dart';
import '../../gen/assets.gen.dart';
import '../../models/houses_model.dart';
import '../../shared/components/custom_textformfield.dart';
import '../../shared/components/offers_card.dart';
import '../../shared/components/place_holder_widget.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/state.dart';
import '../home/widget/house_details.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool _hasSearched = false;

  void _performSearch() {
    if (searchController.text.trim().isEmpty) {
      return;
    }
    setState(() {
      _hasSearched = true;
    });
    context.read<HomeCubit>().getHouses(searchController.text, '');
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.search,
            style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      keyboardType: TextInputType.text,
                      margin: const EdgeInsets.only(
                        top: Sizes.space32,
                        bottom: Sizes.space12,
                      ),
                      controller: searchController,
                      hintText: 'ما الذي تبحث عنه؟',
                      svgPath: Assets.svgs.minimalisticMagnifer.path,
                      onFieldSubmitted: (value) {
                        _performSearch();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 18, right: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorName.bottomColor,
                      ),
                      child: IconButton(
                        icon: Text(
                          "بحث",
                          style: const TextStyle(
                            color: ColorName.secondaryLight,
                            fontSize: Sizes.fontLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: _performSearch,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocConsumer<HomeCubit, HomeStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (!_hasSearched) {
                    return PlaceHolderWidget(
                      context: context,
                      title: AppLocalizations.of(context)!.apartment_search,
                      image: Assets.illustrations.allhouse.svg(),
                    );
                  } else if (state is HomeGetHousesLoadingState) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: 100.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is HomeGetHousesSuccessState) {
                    if (state.houses.isNotEmpty) {
                      List<Data> filteredHouses = state.houses
                          .where((house) => house.name!
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .toList();
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height /
                                      1.711,
                                  child: ListView.builder(
                                    itemCount: filteredHouses.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          PersistentNavBarNavigator
                                              .pushNewScreen(
                                            context,
                                            screen: HouseDetails(
                                              houses: filteredHouses[index],
                                            ),
                                            withNavBar: false,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation.slideUp,
                                          );
                                        },
                                        child: saleOffersCard2(
                                          context: context,
                                          houseData: filteredHouses[index],
                                          title: 'بيع',
                                          type: false,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return PlaceHolderWidget(
                        context: context,
                        title: "لايوجد محتوى",
                        image: Assets.illustrations.house.svg(),
                      );
                    }
                  } else if (state is HomeGetHousesErrorState) {
                    return PlaceHolderWidget(
                      context: context,
                      title: AppLocalizations.of(context)!.error_occurred,
                      image: Assets.illustrations.allhouse.svg(),
                    );
                  } else {
                    return PlaceHolderWidget(
                      context: context,
                      title: AppLocalizations.of(context)!.apartment_search,
                      image: Assets.illustrations.allhouse.svg(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
