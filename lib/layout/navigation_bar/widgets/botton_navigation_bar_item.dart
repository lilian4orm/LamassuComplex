import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lamassu/shared/style/colors.dart';

// ignore: must_be_immutable
class ButtonNavBarItem extends StatefulWidget {
  ButtonNavBarItem({
    super.key,
    required this.index,
    required this.SelectedIndex,
    required this.svgIconPath,
    required this.svgSelectedIconPath,
    required this.title,
    this.onTap,
  });

  int index;
  int SelectedIndex;
  String svgIconPath;
  String svgSelectedIconPath;
  final VoidCallback? onTap;
  String title;

  @override
  State<ButtonNavBarItem> createState() => _ButtonNavBarItemState();
}

class _ButtonNavBarItemState extends State<ButtonNavBarItem> {
  @override
  Widget build(BuildContext context) {
    // final navBarProvider = Provider.of<NavBarProvider>(context);

    return SizedBox(
      // height: 24,
      width: MediaQuery.of(context).size.width / 5,
      child: GestureDetector(
          child: SvgPicture.asset(
            widget.index == widget.SelectedIndex
                ? widget.svgIconPath
                : widget.svgSelectedIconPath,
            color: widget.index == widget.SelectedIndex
                ? ColorName.NuturalColor1
                : ColorName.NuturalColor3,
            height: widget.index == widget.SelectedIndex
                ? MediaQuery.of(context).size.height * 0.035
                : MediaQuery.of(context).size.height * 0.03,
          ),
          onTap: widget.onTap),
    );
  }
}
