import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../gen/assets.gen.dart';
import '../../shared/components/offers_card.dart';
import '../../shared/components/place_holder_widget.dart';
import '../../shared/style/colors.dart';
import '../../shared/style/sizes.dart';
import '../home/widget/house_details.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    FavoriteCubit.get(context).getFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.history_page,
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteStates>(
        builder: (context, state) {
          if (state is FavoriteGetFavoriteLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoriteGetFavoriteSuccessState) {
            final favoriteModel = FavoriteCubit.get(context).favoriteModel;

            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                context.read<FavoriteCubit>()..getFavorite();
              },
              child: Padding(
                padding:
                    EdgeInsets.only(top: 12, right: 16, left: 16, bottom: 50),
                child: SizedBox(
                  width: double.infinity,
                  child: favoriteModel == null || favoriteModel.isEmpty
                      ? Center(
                          child: PlaceHolderWidget(
                            context: context,
                            title: AppLocalizations.of(context)!
                                .no_content_has_been_saved_yet,
                            image: Assets.illustrations.favor.svg(),
                          ),
                        )
                      : ListView.builder(
                          itemCount: favoriteModel.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: HouseDetails(
                                    houses: favoriteModel[index],
                                  ),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.slideUp,
                                );
                              },
                              child: saleOffersCard2(
                                context: context,
                                houseData: favoriteModel[index],
                                title: 'بيع',
                                type: false,
                              ),
                            );
                          },
                        ),
                ),
              ),
            );
          } else if (state is FavoriteGetFavoriteErrorState) {
            return PlaceHolderWidget(
              context: context,
              title:
                  AppLocalizations.of(context)!.no_content_has_been_saved_yet,
              image: Assets.illustrations.favor.svg(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
