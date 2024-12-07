import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/canter_model.dart';
import '../../../shared/components/communicate.dart';
import '../../../shared/style/colors.dart';
import '../../../shared/style/sizes.dart';

class aboutComplexity extends StatefulWidget {
  final Results complex;

  const aboutComplexity(this.complex);

  @override
  _aboutComplexityState createState() => _aboutComplexityState();
}

class _aboutComplexityState extends State<aboutComplexity> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.complex.video != null && widget.complex.video!.isNotEmpty)
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Center(
                      child: Image.asset(
                    'asset/logo.jpg',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .2,
                  ))),
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.complex.name != null &&
                      widget.complex.name!.isNotEmpty)
                    Text(
                      widget.complex.name!, // Displaying the complex name
                      style: const TextStyle(
                        color: ColorName.NuturalColor5,
                        fontSize: Sizes.fontLarge,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  if (widget.complex.address != null &&
                      widget.complex.address!.isNotEmpty)
                    Text(
                      widget.complex.address!, // Displaying the complex address
                      style: const TextStyle(
                        color: ColorName.NuturalColor4,
                        fontSize: Sizes.fontDefault,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.complex.phone != null &&
                            widget.complex.phone!.isNotEmpty)
                          InkWell(
                            onTap: () {
                              launchPhoneCall(widget.complex.phone!);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorName.SecandaryYallw4,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                "asset/svgs/phonecall.svg",
                                height: 40,
                              )),
                            ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        if (widget.complex.whatsapp != null &&
                            widget.complex.whatsapp!.isNotEmpty)
                          InkWell(
                            onTap: () {
                              launchWhatsApp(widget.complex.whatsapp!);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "asset/svgs/whatsap.svg",
                                      height: 40)),
                            ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        if (widget.complex.video != null &&
                            widget.complex.video!.isNotEmpty)
                          InkWell(
                            onTap: () {
                              openUrl(widget.complex.video!);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      "asset/svgs/youtube.svg",
                                      height: 40)),
                            ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        if (widget.complex.facebook != null &&
                            widget.complex.facebook!.isNotEmpty)
                          InkWell(
                            onTap: () {
                              openUrl(widget.complex.facebook!);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      Assets.svgs.frameb.path,
                                      height: 40)),
                            ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        if (widget.complex.instagram != null &&
                            widget.complex.instagram!.isNotEmpty)
                          InkWell(
                            onTap: () {
                              openUrl(widget.complex.instagram!);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      Assets.svgs.framea.path,
                                      height: 40)),
                            ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        if (widget.complex.snapchat != null &&
                            widget.complex.snapchat!.isNotEmpty)
                          InkWell(
                            onTap: () {
                              openUrl(widget.complex.snapchat!);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      Assets.svgs.framead.path,
                                      height: 40)),
                            ),
                          ),
                        SizedBox(
                          width: 10,
                        ),
                        if (widget.complex.tiktok != null &&
                            widget.complex.tiktok!.isNotEmpty)
                          InkWell(
                            onTap: () {
                              openUrl(widget.complex.tiktok!);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: SvgPicture.asset(
                                      Assets.svgs.frameac.path,
                                      height: 40)),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      // boxShadow: [
                      //   BoxShadow(
                      //     blurRadius: .5,
                      //     spreadRadius: .4,
                      //     color: Colors.grey,
                      //   )
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الشركة المسوقة للمجمع  :',
                          style: TextStyle(fontSize: Sizes.iconDefault),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'بوابة المستقبل - Future Gate',
                              style: TextStyle(
                                  fontSize: Sizes.fontDefault,
                                  color: ColorName.bottomColor),
                            ),
                            InkWell(
                              onTap: () {
                                openUrl(
                                    'https://www.facebook.com/future.gate.iq?mibextid=LQQJ4d');
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: SvgPicture.asset(
                                        Assets.svgs.frameb.path,
                                        height: 40)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        if (widget.complex.description != null &&
            widget.complex.description!.isNotEmpty)
          Text(
            isExpanded
                ? widget.complex.description!
                : _getTruncatedDescription(),
            style: const TextStyle(
              color: ColorName.NuturalColor3,
              fontSize: Sizes.fontDefault,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
            maxLines: isExpanded ? null : 5000,
          ),
        const SizedBox(
          height: 8,
        ),
        if (widget.complex.description != null &&
            widget.complex.description!.isNotEmpty)
          if (!_isDescriptionFullyDisplayed())
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'عرض أقل' : 'عرض المزيد',
                style: TextStyle(
                  color: ColorName.errorColor5, // Adjust color as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  bool _isDescriptionFullyDisplayed() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.complex.description!,
        style: const TextStyle(
          color: ColorName.NuturalColor3,
          fontSize: Sizes.fontDefault,
          fontWeight: FontWeight.w400,
        ),
      ),
      maxLines: 100, // Some large number to ensure text is fully displayed
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    return textPainter.didExceedMaxLines;
  }

  String _getTruncatedDescription() {
    final originalText = widget.complex.description!;
    final index = originalText.indexOf('\n');
    if (index == -1) {
      return originalText; // Return full text if no newline characters are found
    } else {
      return originalText.substring(0, index);
    }
  }
}
