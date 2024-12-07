import 'package:flutter/material.dart';
import 'package:lamassu/modules/profile/widget/shipping_history/maintaince_log.dart';
import 'package:lamassu/modules/profile/widget/shipping_history/shipping_log.dart';
import 'package:lamassu/shared/style/colors.dart';

class LogServiceScreen extends StatelessWidget {
  const LogServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'سجل طلبات الصيانة والشحن',
            style: TextStyle(
              color: ColorName.NuturalColor6,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: ColorName.successColor6,
            unselectedLabelColor: ColorName.NuturalColor3,
            tabs: [
              Tab(text: 'طلبات الصيانة'),
              Tab(text: 'طلبات الشحن'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ServiceLogScreen(),
            Shippingogcreen(),
          ],
        ),
      ),
    );
  }
}
