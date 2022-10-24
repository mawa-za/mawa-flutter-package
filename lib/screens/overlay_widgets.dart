import 'package:flutter/material.dart';

class OverlayWidgets {
  OverlayWidgets({required this.context}) {
    overlayState = Overlay.of(context)!;
  }
  final BuildContext context;
  // Declaring and Initializing OverlayState
  // and OverlayEntry objects
  OverlayState? overlayState;
  OverlayEntry? overlayEntry;

  void showOverlay(Widget widget) async {

    overlayEntry = OverlayEntry(builder: (context) {
      // You can return any widget you like here
      // to be displayed on the Overlay
      return Positioned(
        // left: MediaQuery.of(context).size.width * 0.2,
        // top: MediaQuery.of(context).size.height * 0.3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: widget,
        ),
      );
    });
    // Inserting the OverlayEntry into the Overlay
    overlayState?.insert(overlayEntry!);
  }

  void dismissOverlay() {
    overlayEntry!.remove();
  }
}
