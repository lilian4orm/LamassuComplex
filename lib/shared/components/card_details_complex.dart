import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamassu/models/form_model/form_name.dart';
import 'package:lamassu/shared/style/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../gen/assets.gen.dart';
import '../../modules/about_complex/cubit/cubit.dart';
import '../../modules/about_complex/widget/house_name.dart';
import '../end_point/end_point.dart';
import '../style/sizes.dart';
import 'image_saver.dart';

class DetailsComplexScreen extends StatefulWidget {
  const DetailsComplexScreen({
    Key? key,
    required this.form,
  }) : super(key: key);
  final ResultsFormName form;

  @override
  State<DetailsComplexScreen> createState() => _DetailsComplexScreenState();
}

class _DetailsComplexScreenState extends State<DetailsComplexScreen> {
  int currentIndex = 0;
  late SharedPreferences prefs;
  String? embloy;

  void getInsta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    embloy = prefs.getString('sells_emp');
  }

  @override
  void initState() {
    getInsta();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.form.sId != null) {
      context.read<CenterCubit>()..getHouseName(id: widget.form.sId);
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(context),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildDetailsSection(context),
            ),
            embloy == null
                ? SizedBox()
                : widget.form.sId != null
                    ? FutureBuilder(
                        future: Future.delayed(Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            return HouseNameScreen(form: widget.form);
                          }
                        },
                      )
                    : SizedBox(),
          ],
        ),
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
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FullScreenImage(
                  imageUrls: widget.form.images!, initialIndex: currentIndex),
            ));
          },
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.6,
            child: PageView.builder(
              itemCount: widget.form.images!.length,
              controller: PageController(initialPage: currentIndex),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index; // Update currentIndex when swiping
                });
              },
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: imageStorg + widget.form.images![index],
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      Assets.images.logo.image(),
                );
              },
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.form.images!.length,
            (index) => buildIndicator(index),
          ),
        ),
      ],
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

  Widget buildBackButton(BuildContext context) {
    return Positioned(
      top: 32,
      right: 32,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const CircleAvatar(
          radius: 20,
          backgroundColor: ColorName.secondaryLight,
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
    );
  }

  Widget buildDetailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20), // Add some spacing
        buildTitleAndSpace(),
      ],
    );
  }

  Widget buildTitleAndSpace() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.form.name != null && widget.form.name!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.form.name}",
                  style: const TextStyle(
                      color: ColorName.brandPrimary,
                      fontSize: Sizes.fontLarge,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorName.successColor1,
                  ),
                  child: Text(
                    "${widget.form.buildingType!}",
                    style: const TextStyle(
                        color: ColorName.successColor6,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        if (widget.form.streetNumber != null)
          buildDataRow("الشارع :", "${widget.form.streetNumber}"),
        if (widget.form.blockNumber != null &&
            widget.form.blockNumber!.isNotEmpty)
          buildDataRow("رقم البلوك :", "${widget.form.blockNumber}"),
        if (widget.form.apartmentFloors != null &&
            widget.form.apartmentFloors!.isNotEmpty)
          buildDataRow(
              "عدد الطوابق :", "${widget.form.apartmentFloors!.length}"),
        if (widget.form.apartmentBuilding != null &&
            widget.form.apartmentBuilding!.isNotEmpty)
          buildDataRow("البنايات :", "${widget.form.apartmentBuilding}"),
      ],
    );
  }

  Widget buildDataRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorName.NuturalColor1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: ColorName.NuturalColor3,
                    fontSize: Sizes.fontSmall,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10),
              Text(
                value,
                style: const TextStyle(
                    color: ColorName.NuturalColor3,
                    fontSize: Sizes.fontSmall,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
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

// class FullScreenImagefirst extends StatefulWidget {
//   final String? imageUrl;
//
//   const FullScreenImagefirst({Key? key, this.imageUrl}) : super(key: key);
//
//   @override
//   State<FullScreenImagefirst> createState() => _FullScreenImagefirstState();
// }
//
// class _FullScreenImagefirstState extends State<FullScreenImagefirst> {
//   bool loading = false;
//
//   Future<void> _saveImage() async {
//     setState(() {
//       loading = true;
//     });
//
//     try {
//       await ImageSaver.saveImageToGallery(widget.imageUrl!, context);
//     } finally {
//       setState(() {
//         loading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: loading ? CircularProgressIndicator() : Icon(Icons.download),
//             onPressed: loading ? null : _saveImage,
//           ),
//         ],
//       ),
//       body: Center(
//         child: InteractiveViewer(
//           panEnabled: false,
//           boundaryMargin: EdgeInsets.all(double.infinity),
//           minScale: 0.5,
//           maxScale: 2.0,
//           child: CachedNetworkImage(
//             imageUrl: widget.imageUrl!,
//             placeholder: (context, url) => const Center(
//               child: CircularProgressIndicator(),
//             ),
//             errorWidget: (context, url, error) => Icon(Icons.error),
//             fit: BoxFit.contain,
//           ),
//         ),
//       ),
//     );
//   }
// }
