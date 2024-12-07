import 'package:flutter/material.dart';

class ColumnPadded extends Column {
  ColumnPadded({
    super.key,
    double gap = 16,
    required EdgeInsetsGeometry padding,
    required List<Widget> children,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
  }) : super(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              Padding(
                padding: padding,
                child: children[i],
              ),
              if (i != children.length - 1) SizedBox.square(dimension: gap),
            ]
          ],
        );
}

class RowPadded extends Row {
  RowPadded({
    super.key,
    double gap = 8,
    required List<Widget> children,
    super.crossAxisAlignment,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.textBaseline,
    super.textDirection,
    super.verticalDirection,
  }) : super(
          children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1) SizedBox.square(dimension: gap),
            ]
          ],
        );
}
