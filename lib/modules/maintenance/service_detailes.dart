import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/models/service_model.dart';
import 'package:lamassu/shared/style/colors.dart';

class ServiceDetailesScreen extends StatefulWidget {
  const ServiceDetailesScreen({super.key, required this.service});
  final ServiceModel service;

  @override
  State<ServiceDetailesScreen> createState() => _ServiceDetailesScreenState();
}

class _ServiceDetailesScreenState extends State<ServiceDetailesScreen> {
  NumberFormat number = NumberFormat.decimalPattern("en_us");
  final String link = "https://api.myexperience.center/storage/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الصيانة'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(90),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(90),
              ),
              child: Image.network(
                link + widget.service.service!.image!,
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
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
    );
  }
}
