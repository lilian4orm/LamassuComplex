import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/form_model/form_houses_and_rooms.dart';
import '../../../shared/components/image_saver.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';
class RoomScreen extends StatelessWidget {
  const RoomScreen({required this.formRoom});
  final ResultsHouseAndRoomform formRoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "التفاصيل",
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontDefault,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          buildContainer("الاسم :", formRoom.name),
          buildContainer("الحالة :", formRoom.status),
          buildContainer("الطابق :", formRoom.apartmentFloorNumber.toString()),
          buildContainer("المساحة الكلية :", "${formRoom.totalSpace}",),
          buildContainer("مساحة البناء :", "${formRoom.buildingSpace}"),

          buildDetailsRows(context),

        ],
      ),
    );
  }

  Widget buildContainer(String title, String? value) {
    return value != null && value.isNotEmpty
        ? Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorName.NuturalColor1,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: ColorName.NuturalColor5,
                fontSize: Sizes.fontDefault,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: ColorName.NuturalColor5,
                fontSize: Sizes.fontDefault,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    )
        : SizedBox();
  }
  Widget buildDetailsRows(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var details in formRoom.rooms ?? <Rooms>[])
            InkWell(
              onTap: () {
                if (details.image != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FullScreenImage(imageUrl: imageStorg + details.image!),
                  ));
                }
              },
              child: buildRow(details),
            ),
        ],
      ),
    );
  }

  Widget buildRow(Rooms details) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorName.NuturalColor1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              "${details.name ?? ''}:",
              style: const TextStyle(
                color: ColorName.NuturalColor6,
                fontSize: Sizes.fontSmall,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (details.image != null)
            Expanded(
              flex: 1,
              child: Container(
                height: 30,
                width: 50,
                child: Icon(Icons.image_search_outlined),
              ),
            ),
          Expanded(
            flex: 1,
            child: Text(
              "${details.space ?? ''} م ",
              style: const TextStyle(
                color: ColorName.NuturalColor6,
                fontSize: Sizes.fontSmall,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final String? imageUrl;

  const FullScreenImage({Key? key, this.imageUrl}) : super(key: key);

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool loading = false;

  Future<void> _saveImage() async {
    setState(() {
      loading = true;
    });

    try {
      await ImageSaver.saveImageToGallery(widget.imageUrl!, context);
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
      body: Center(
        child: InteractiveViewer(
          panEnabled: false,
          boundaryMargin: EdgeInsets.all(double.infinity),
          minScale: 0.5,
          maxScale: 2.0,
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl!,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
