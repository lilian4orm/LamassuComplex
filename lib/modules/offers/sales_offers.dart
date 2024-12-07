import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../models/houses_model.dart';
import '../../shared/components/offers_card.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/state.dart';
import '../home/widget/home_body.dart';
import '../home/widget/house_details.dart';

class SalesOffersScreen extends StatefulWidget {
  const SalesOffersScreen({super.key, required this.title});
  final String title;

  @override
  _SalesOffersScreenState createState() => _SalesOffersScreenState();
}

class _SalesOffersScreenState extends State<SalesOffersScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<HomeCubit>().getHouses("", widget.title);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<HomeCubit>().loadMore("", widget.title);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<Data>? housesList;
    switch (widget.title) {
      case 'بيع':
        housesList = context.read<HomeCubit>().houses2;
        break;
      case 'ايجار':
        housesList = context.read<HomeCubit>().houses3;
        break;
      default:
        housesList = context.read<HomeCubit>().houses;
        break;
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title == "ايجار" ? "عروض الايجار" : "عروض البيع",
            style: const TextStyle(
              color: ColorName.NuturalColor5,
              fontSize: Sizes.fontLarge,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeGetHousesLoadingState && housesList!.isEmpty) {
              return ShimmerbuildCarousel(context);
            } else if (housesList != null) {
              return Padding(
                padding: const EdgeInsets.only(top: 12, right: 16, left: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: housesList.length +
                        (context.read<HomeCubit>().hasMore ? 1 : 0),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == housesList!.length) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: HouseDetails(
                              houses: housesList![index],
                            ),
                            withNavBar: false,
                            pageTransitionAnimation:
                                PageTransitionAnimation.slideUp,
                          );
                        },
                        child: saleOffersCard2(
                          context: context,
                          houseData: housesList[index],
                          title: widget.title,
                          type: true,
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
