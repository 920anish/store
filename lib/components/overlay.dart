import 'package:flutter/material.dart';
import 'package:store/components/loading.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black45,
              child: Center(
                child: LoadingAnimation(),
              ),
            ),
          ),
      ],
    );
  }
}
