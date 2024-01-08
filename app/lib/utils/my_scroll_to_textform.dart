import 'package:flutter/material.dart';

void scrollToWidget(GlobalKey key) {
  final RenderObject? renderObject = key.currentContext?.findRenderObject();
  if (renderObject is RenderBox) {
    final ScrollableState scrollableState = Scrollable.of(key.currentContext!);
    scrollableState.position.ensureVisible(
      renderObject,
      alignment: 0.5,
      duration: const Duration(milliseconds: 300),
    );
  }
}
