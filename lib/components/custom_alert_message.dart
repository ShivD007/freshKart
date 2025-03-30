import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fresh_kart/utils/global_context.dart';

class AlertMessage {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;
  static OverlayEntry _createOverlayEntry(String? message) {
    return OverlayEntry(
        builder: (context) => Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: kToolbarHeight,
                  child: Material(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: Text(
                              message!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }

  static show(String message) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _timer?.cancel();
    }

    _overlayEntry = _createOverlayEntry(message);
    showOverlay();
  }

  static showOverlay() async {
    Navigator.of(GlobalContext.context!).overlay!.insert(_overlayEntry!);

    _timer = Timer(const Duration(seconds: 3), () {
      if (_overlayEntry != null) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _timer?.cancel();
      }
    });
  }
}
