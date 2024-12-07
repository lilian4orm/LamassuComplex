import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lamassu/modules/profile/widget/shipping_history/bloc/cubit.dart';
import 'package:lamassu/modules/profile/widget/shipping_history/bloc/state.dart';
import 'package:lamassu/modules/profile/widget/shipping_history/models/shipping_model.dart';
import 'package:lamassu/shared/components/place_holder_widget.dart';
import 'package:lamassu/shared/style/colors.dart';

class Shippingogcreen extends StatefulWidget {
  const Shippingogcreen({super.key});

  @override
  State<Shippingogcreen> createState() => _ShippingogcreenState();
}

class _ShippingogcreenState extends State<Shippingogcreen> {
  NumberFormat number = NumberFormat.decimalPattern('en-us');
  ScrollController _scrollController = ScrollController();
  int page = 1;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        LogShippingCubit.get(context).getShippingLog(page);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LogShippingCubit()..getShippingLog(page),
        child: BlocConsumer<LogShippingCubit, LogStates>(
          listener: (context, state) => {},
          builder: (context, state) {
            if (state is ShippingLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ShippingSuccessState) {
              if (state.logList.isEmpty) {
                return PlaceHolderWidget(
                    context: context,
                    title: 'لا توجد طلبات',
                    image: Image.asset('asset/logo.jpg'));
              }
              return ListView.builder(
                itemCount: state.logList.length,
                itemBuilder: (context, index) {
                  ShipingResponeModel log = state.logList[index];
                  return logCard(log);
                },
              );
            } else if (state is ShippingErrorState) {
              return PlaceHolderWidget(
                  context: context,
                  title: state.error,
                  image: Image.asset('asset/images/logo.png'));
            } else {
              return PlaceHolderWidget(
                  context: context,
                  title: 'هنالك خلل ما',
                  image: Image.asset('asset/images/logo.png'));
            }
          },
        ),
      ),
    );
  }

  Widget logCard(ShipingResponeModel log) {
    return Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorName.NuturalColor1,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorName.NuturalColor3.withOpacity(.5),
              blurRadius: .2,
              spreadRadius: .3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('حالة الطلب :${log.currentStatus!.type ?? ''}'),
                Text('تاريخ الطلب :${log.createdAt ?? ''}'),
              ],
            ),
            if (log.service!.name != null)
              Text('شحن  :${log.service!.name ?? ''}'),
            if (log.service!.price != null)
              Text('المبلغ :${number.format(log.service!.price ?? 0)}'),
            if (log.currentStatus!.note != null)
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'توجيهات  :${log.currentStatus!.note ?? ''}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            if (log.machineName != null)
              Text('اسم الجهاز :${log.machineName ?? ''}'),
            if (log.machineName != null) Text('الموقع :${log.roomName ?? ''}'),
            if (log.fixType != null) Text('نوع العطل :${log.fixType ?? ''}'),
            if (log.currentStatus!.employeeName != null)
              Text('اسم الموظف :${log.currentStatus!.employeeName ?? ''}'),
            if (log.currentStatus!.reasonToReject != null)
              Text('السبب :${log.currentStatus!.reasonToReject ?? ''}'),
          ],
        ));
  }
}
