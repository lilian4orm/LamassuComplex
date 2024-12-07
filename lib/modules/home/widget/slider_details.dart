import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/last_news_model.dart';

import '../../../shared/components/image_saver.dart';
import '../../../shared/end_point/end_point.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

class SliderDetailsScreen extends StatelessWidget {
  const SliderDetailsScreen({super.key, required this.news});

  final Results? news;

  @override
  Widget build(BuildContext context) {
    String formattedDate = news?.createdAt != null
        ? DateFormat('(aa)dd-MMM-yyyy  hh:mm', 'en')
            .format(DateTime.parse(news!.createdAt!))
        : "...";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          news!.title != null ? "${news!.title}" : "...",
          style: const TextStyle(
            color: ColorName.NuturalColor5,
            fontSize: Sizes.fontLarge,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  _openFullScreenImage(context);
                },
                child: Hero(
                  tag:
                      'imageHero', // Make sure this tag is unique for each image
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: imageStorg + news!.image!,
                      height: MediaQuery.of(context).size.height * .35,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
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
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                news!.description != null ? "${news!.description}" : "...",
                style: const TextStyle(
                  color: ColorName.NuturalColor5,
                  fontSize: Sizes.fontDefault,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                news!.createdAt != null ? "${formattedDate}" : "...",
                style: const TextStyle(
                  color: ColorName.NuturalColor5,
                  fontSize: Sizes.fontDefault,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openFullScreenImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FullScreenImage(imageUrl: imageStorg + news!.image!),
      ),
    );
  }
}

class FullScreenImage extends StatefulWidget {
  final String imageUrl;

  const FullScreenImage({required this.imageUrl});

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
      await ImageSaver.saveImageToGallery(widget.imageUrl, context);
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
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
