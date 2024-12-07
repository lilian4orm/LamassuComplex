import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../gen/assets.gen.dart';
import '../../../models/houses_model.dart';
import '../../../shared/components/image_saver.dart';
import '../../../shared/components/make_breaks.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../favorite/cubit/cubit.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'booked_house.dart';
import 'home_body.dart';

class HouseDetails extends StatefulWidget {
  HouseDetails({Key? key, required this.houses}) : super(key: key);
  final Data houses;

  @override
  State<HouseDetails> createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> {
  bool isHouseSaved = false;
  bool isHouselike = false;
  late String houseId;
  int currentIndex = 0;
  String? sells;
  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    houseId = widget.houses.sId!;
    checkSavedState().then((bool value) {
      setState(() {
        isHouselike = value;
      });
    });
  }

  Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sells = prefs.getString('sells_emp');
    });
  }

  Future<bool> checkSavedState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? housesIds = prefs.getStringList('houses_ids');
    return housesIds?.contains(houseId) ?? false;
  }

  Future<void> saveHousesId(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> housesIds = prefs.getStringList('houses_ids') ?? [];

    if (housesIds.contains(houseId)) {
      housesIds.remove(houseId);
    } else {
      housesIds.add(houseId);
    }

    setState(() {
      isHouseSaved = housesIds.contains(houseId);
      isHouselike = !isHouselike;
    });

    await prefs.setStringList('houses_ids', housesIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                buildHeader(context),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: buildDetailsSection(context),
                ),
                buildBlocProvider(),
                SizedBox(
                  height: 110,
                )
              ],
            ),
          ),
          if (sells == null)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (widget.houses.isAvailable == true) {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: BookedHouse(
                        houseId: widget.houses.sId!,
                      ),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  }
                },
                child: Text(
                  widget.houses.isAvailable == true
                      ? AppLocalizations.of(context)!.book_now
                      : AppLocalizations.of(context)!.not_available,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: widget.houses.isAvailable == true
                            ? ColorName.secondaryLight
                            : ColorName.errorColor5,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: widget.houses.isAvailable == true
                        ? ColorName.bottomColor
                        : Color(0xffEDFAFF)),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> printSavedHouseIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? housesIds = prefs.getStringList('houses_ids');

    if (housesIds != null) {
      // Update state to indicate that a house is saved
      setState(() {
        isHouseSaved = true;
      });
    } else {
      print("No saved house IDs found.");
    }
  }

  BlocProvider<HomeCubit> buildBlocProvider() {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeCubit()..getHouses('', '${widget.houses.existingType}'),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (
          context,
          state,
        ) {},
        builder: (
          context,
          state,
        ) {
          if (state is HomeGetHousesLoadingState) {
            return ShimmerbuildCarousel(context);
          }
          if (widget.houses.existingType == "بيع")
            return buildSaleOffersSection(context, false);
          else
            return buildRentalOffersSection(context, false);
        },
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Stack(
      children: [
        buildImage(context),
        buildBackButton(context),
      ],
    );
  }

  Widget buildImage(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FullScreenImage(imageUrls: widget.houses.imgs),
        ));
      },
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.6,
            child: PageView.builder(
              itemCount: widget.houses.imgs!.length,
              controller: PageController(),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return buildImagePage(widget.houses.imgs![index]);
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.houses.imgs!.length,
              (index) => buildIndicator(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 12,
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: index == currentIndex ? ColorName.brandPrimary : Colors.grey,
      ),
    );
  }

  Widget buildImagePage(String imageUrl) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.6,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(0),
          child: CachedNetworkImage(
            imageUrl: imageStorg + imageUrl,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Assets.images.logo.image(),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 39),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: ColorName.secondaryLight,
              child: Icon(Icons.arrow_back_rounded),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                await saveHousesId(context);
                await printSavedHouseIds();
                await context
                    .read<FavoriteCubit>()
                    .removeFromFavorites(saveHousesId.toString());
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: isHouselike
                    ? ColorName.brandPrimary
                    : ColorName.secondaryLight,
                child: Assets.svgs.bookmark.svg(
                  height: 16,
                  width: 16,
                  color: isHouselike
                      ? ColorName.secondaryLight
                      : ColorName.brandPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitleAndSpace(),
        const SizedBox(
          height: 12,
        ),
        buildBuildingSpace(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "${widget.houses.description!}",
            style: const TextStyle(
              color: ColorName.NuturalColor4,
              fontSize: Sizes.fontDefault,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          AppLocalizations.of(context)!.house_details,
          style: const TextStyle(
            color: ColorName.NuturalColor6,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          spacing: 20.0, // gap between adjacent chips
          runSpacing: 8.0, // gap between lines
          children: <Widget>[
            ColumnHouseDetails(
                title: '${widget.houses.space!} م',
                icone: Assets.svgs.vector
                    .svg(height: 24, color: ColorName.brandPrimary)),
            ColumnHouseDetails(
                title: '${widget.houses.livingRooms!} معيشة',
                icone: Assets.svgs.armchair
                    .svg(height: 24, color: ColorName.brandPrimary)),
            ColumnHouseDetails(
                title: '${widget.houses.bedRooms!} نوم',
                icone: Assets.svgs.bed
                    .svg(height: 24, color: ColorName.brandPrimary)),
            ColumnHouseDetails(
                title: '${widget.houses.bathRooms!} حمام',
                icone: Assets.svgs.bath
                    .svg(height: 24, color: ColorName.brandPrimary)),
          ],
        )
      ],
    );
  }

  Widget buildTitleAndSpace() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              "${widget.houses.name!}",
              style: const TextStyle(
                color: ColorName.NuturalColor6,
                fontSize: Sizes.fontLarge,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "${widget.houses.space!} متر",
              style: const TextStyle(
                color: ColorName.NuturalColor6,
                fontSize: Sizes.fontLarge,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        buildTotalSpace(),
      ],
    );
  }

  Widget buildTotalSpace() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.houses.isAvailable == true
            ? widget.houses.existingType == "بيع"
                ? ColorName.successColor1
                : ColorName.SecandaryYallw1
            : ColorName.errorColor1,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Text(
          widget.houses.isAvailable == true
              ? "${widget.houses.existingType}"
              : "محجوز",
          style: TextStyle(
            color: widget.houses.isAvailable == true
                ? widget.houses.existingType == "بيع"
                    ? ColorName.successColor6
                    : ColorName.SecandaryYallw4
                : ColorName.errorColor6,
            fontSize: Sizes.fontSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildBuildingSpace() {
    return Text(
      "${addCommasToNumber(widget.houses.price!)} د.ع",
      style: const TextStyle(
        color: ColorName.brandSecondary,
        fontSize: Sizes.fontLarge,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget ColumnHouseDetails({required String title, required Widget icone}) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorName.NuturalColor1),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        icone,
        SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: const TextStyle(
              color: ColorName.brandPrimary,
              fontSize: Sizes.fontSmall,
              fontWeight: FontWeight.w500),
        ),
      ]),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final List<String>? imageUrls;
  final int initialIndex;

  const FullScreenImage({Key? key, this.imageUrls, this.initialIndex = 0})
      : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool loading = false;

  Future<void> _saveImage() async {
    setState(() {
      loading = true;
    });

    try {
      await ImageSaver.saveImageToGallery(
          imageStorg + widget.imageUrls![0], context);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: loading ? CircularProgressIndicator() : Icon(Icons.download),
            onPressed: loading ? null : _saveImage,
          ),
        ],
      ),
      body: PageView.builder(
        itemCount: widget.imageUrls!.length,
        controller: PageController(initialPage: widget.initialIndex),
        itemBuilder: (context, index) {
          return buildImagePage(widget.imageUrls![index], context);
        },
      ),
    );
  }

  Widget buildImagePage(String imageUrl, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InteractiveViewer(
            panEnabled: false,
            boundaryMargin: EdgeInsets.all(double.infinity),
            minScale: 0.5,
            maxScale: 2.0,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(0),
              child: CachedNetworkImage(
                imageUrl: imageStorg + imageUrl,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
