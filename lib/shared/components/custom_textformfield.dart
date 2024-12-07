import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../style/colors.dart';
import '../style/sizes.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.svgPath,
    this.margin,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.width,
    this.maxLines = 1,
    this.maxLength,
    this.showMaxLength = false,
    this.addCommas = false,
    this.onChanged,
    this.errorText,
    this.onFieldSubmitted,
    this.readonly,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String? svgPath;
  final EdgeInsetsGeometry? margin;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final double? width;
  final int maxLines;
  final int? maxLength;
  final bool? showMaxLength;
  final bool? addCommas;
  final Function? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? errorText;
  final bool? readonly;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String? _errorText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_formatText);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_formatText);
    _focusNode.dispose();

    super.dispose();
  }

  void _formatText() {
    final arabicToEnglish = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };
    final newText = widget.controller.text.split('').map((char) {
      return arabicToEnglish[char] ?? char;
    }).join();

    String formattedText = newText;

    if (widget.addCommas ?? false) {
      formattedText = _formatWithCommas(formattedText);
    }

    if (widget.controller.text != formattedText) {
      final cursorPos = widget.controller.selection;
      widget.controller.value = widget.controller.value.copyWith(
        text: formattedText,
        selection: cursorPos,
      );
    }
  }

  String _formatWithCommas(String text) {
    // Remove non-digit characters to avoid format issues
    String cleanText = text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanText.isEmpty) return text;

    try {
      // Attempt to parse the clean text to BigInt
      final number = BigInt.parse(cleanText);

      // Format the number with commas
      final formatter = NumberFormat('#,###');
      final formattedText = formatter.format(number);

      return formattedText;
    } catch (_) {
      // If parsing fails, try to parse as int
      try {
        final number = int.parse(cleanText);

        // Format the number with commas
        final formatter = NumberFormat('#,###');
        final formattedText = formatter.format(number);

        return formattedText;
      } catch (_) {
        // If parsing as int fails, return the original text
        return text;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  controller: widget.controller,
                  readOnly: widget.readonly ?? false,
                  style: Theme.of(context).textTheme.headlineSmall,
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: widget.readonly ?? false
                        ? Colors.grey.withOpacity(.4)
                        : Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorName.NuturalColor2,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorName.NuturalColor2,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: ColorName.errorColor5,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: ColorName.NuturalColor3),
                    prefixIcon: widget.svgPath != null
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              widget.svgPath!,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                ColorName.NuturalColor3,
                                BlendMode.srcIn,
                              ),
                            ),
                          )
                        : null,
                  ),
                  onChanged: (text) {
                    if (widget.showMaxLength == true) {
                      setState(() {});
                    }
                    if (widget.addCommas == true) {
                      final newText = _formatWithCommas(text);
                      final cursorPos = newText.length;
                      widget.controller.value = TextEditingValue(
                        text: newText,
                        selection: TextSelection.collapsed(offset: cursorPos),
                      );
                    } else {
                      _formatText();
                    }
                    if (widget.onChanged != null) {
                      widget.onChanged!(text);
                    }
                  },
                  validator: (value) {
                    final error = widget.validator?.call(value);
                    setState(() {
                      _errorText = error;
                    });
                    return error != null ? '' : error;
                  },
                  onTap: () {
                    // Ensure the field gains focus when tapped
                    _focusNode.requestFocus();
                  },
                ),
                if (widget.showMaxLength ?? true)
                  Positioned(
                    left: 0,
                    bottom: -5,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.controller.text.length >
                                (widget.maxLength ?? 0)
                            ? Colors.red
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        '${widget.controller.text.length}/${widget.maxLength ?? 0}',
                        style: TextStyle(color: ColorName.SecandaryYallw2),
                      ),
                    ),
                  ),
              ],
            ),
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.space16,
                ),
                child: Text(
                  _errorText!,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: ColorName.errorColor6),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
