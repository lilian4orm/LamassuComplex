import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/models/service_model.dart';
import 'package:lamassu/modules/maintenance/service_detailes.dart';
import 'package:lamassu/shared/style/colors.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard({super.key, required this.service});
  final ServiceModel service;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  NumberFormat number = NumberFormat.decimalPattern("en_us");
  final String link = "https://api.myexperience.center/storage/";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ServiceDetailesScreen(service: widget.service)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.service.name ?? '',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(widget.service.phone ?? '',
                        style: TextStyle(
                            color: ColorName.NuturalColor3, fontSize: 13)),
                    Text(widget.service.service!.name ?? ''),
                    Text(widget.service.service!.type ?? ''),
                    Text(
                      number.format(widget.service.service!.price ?? 0),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorName.bottomColor,
                            padding: EdgeInsets.symmetric(vertical: 0),
                            maximumSize: Size(100, 60)),
                        onPressed: () {},
                        child: Text(
                          'قبول',
                          style: TextStyle(
                              fontSize: 18,
                              color: ColorName.NuturalColor1,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            link + widget.service.service!.image!,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Image.network(
                  link + widget.service.service!.image!,
                  height: 200,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
