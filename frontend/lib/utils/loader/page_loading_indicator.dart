import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PageLoadingIndicator extends StatelessWidget {
  const PageLoadingIndicator({super.key, this.color = Colors.red});

final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: color,
        size: 14,
      ),
    );
  }
}

class PageLoadingIndicatorWhite extends StatelessWidget {
  const PageLoadingIndicatorWhite({super.key});


  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitThreeBounce(
        color: Colors.white,
        size: 14,
      ),
    );
  }
}