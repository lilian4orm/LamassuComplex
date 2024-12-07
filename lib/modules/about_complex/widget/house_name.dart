import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lamassu/modules/about_complex/widget/room_screen.dart';

import '../../../gen/assets.gen.dart';
import '../../../models/form_model/form_houses_and_rooms.dart';
import '../../../models/form_model/form_name.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class HouseNameScreen extends StatefulWidget {
  const HouseNameScreen({required this.form});
  final ResultsFormName form;


  @override
  State<HouseNameScreen> createState() => _HouseNameScreenState();
}


class _HouseNameScreenState extends State<HouseNameScreen>   with AutomaticKeepAliveClientMixin {
  @override

  bool get wantKeepAlive => true;
  @override
  void initState() {
    context.read<CenterCubit>()..getHouseName(id: widget.form.sId);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
   // super.build(context);
    if(widget.form.sId != null) {
      context.read<CenterCubit>()
        ..getHouseName(id: widget.form.sId);
    }

    return BlocBuilder<CenterCubit, CenterStates>(

      builder: (context, state) {
        var cubit = CenterCubit.get(context).HouseName!;

        if (state is HouseNameLoadingState || cubit.results!.isEmpty || cubit.results == null) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HouseNameSuccessState) {
          int reservedCount = 0;
          int boughtCount = 0;
          int availablebought = 0;
          int availableCount = 0;

          for (var house in cubit.results!) {
            if (house.status == "غير محجوز") {
              reservedCount++;
            }
            if (house.status == "حجز مبدئي") {
              boughtCount++;
            }
            if (house.status == "محجوز") {
              availablebought++;
            }
            if (house.status == "تم البيع") {
              availableCount++;
            }
          }
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildCounter(context, reservedCount, "غير محجوز",
                              ColorName.successColor6),
                          buildCounter(context, boughtCount, "حجز مبدئي",
                              ColorName.NuturalColor4),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildCounter(context, availablebought, "محجوز",
                              ColorName.SecandaryYallw4),
                          buildCounter(context, availableCount, "تم البيع",
                              ColorName.errorColor5),
                        ],
                      )
                    ],
                  ),
                ),
                Wrap(
                  children: [
                    for (var detailsList in cubit.results ?? <ResultsHouseAndRoomform>[])
                      InkWell(
                        onTap: (){
                         Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RoomScreen(formRoom: detailsList,)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),

                                color: ColorName.NuturalColor1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                        Assets.svgs.comparage.path,
                                        color: detailsList.status == "غير محجوز"
                                            ? ColorName.successColor6
                                            : detailsList.status == "محجوز"
                                                ? ColorName.SecandaryYallw4
                                                : detailsList.status ==
                                                        "حجز مبدئي"
                                                    ? ColorName.NuturalColor4
                                                    : detailsList.status ==
                                                            "تم البيع"
                                                        ? ColorName.errorColor5
                                                        : ColorName
                                                            .secondaryLight)),
                                Text(
                                  detailsList.name ?? '',
                                  style: const TextStyle(
                                    color: ColorName.NuturalColor4,
                                    fontSize: Sizes.fontDefault,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        } else
          return Text("123456");
      },
    );
  }

  Widget buildCounter(
      BuildContext context, int reservedCount, title, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.3,
        height: MediaQuery.of(context).size.width * .1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorName.NuturalColor1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: Sizes.fontSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${reservedCount}",
                style: TextStyle(
                  color: color,
                  fontSize: Sizes.fontSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
