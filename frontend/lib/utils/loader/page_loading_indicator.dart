import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PageLoadingIndicator extends StatelessWidget {
  const PageLoadingIndicator({super.key});


  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitThreeBounce(
        color: Colors.red,
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