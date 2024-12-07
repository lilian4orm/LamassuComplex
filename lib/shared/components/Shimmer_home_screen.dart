import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget ShimmerWidget(BuildContext context) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;

  return ListView(
    padding: const EdgeInsets.all(16.0),
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: screenHeight * 0.23, // 25% of screen height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(height: screenHeight * 0.02), // 2% of screen height
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: screenWidth * 0.2, // 20% of screen width
              height: screenWidth * 0.2, // 20% of screen width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
      SizedBox(height: screenHeight * 0.02), // 2% of screen height
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenHeight * 0.0225, // 12.5% of screen height
              width: screenHeight * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenHeight * 0.0225, // 12.5% of screen height
              width: screenHeight * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: screenHeight * 0.007), // 2% of screen
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: screenHeight * 0.145, // 12.5% of screen height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(height: screenHeight * 0.02), // 2% of screen height
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenHeight * 0.0225, // 12.5% of screen height
              width: screenHeight * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: screenHeight * 0.0225, // 12.5% of screen height
              width: screenHeight * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: screenHeight * 0.007), // 2% of screen
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: screenHeight * 0.145, // 12.5% of screen height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
