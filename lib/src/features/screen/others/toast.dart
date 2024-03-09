import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:oraah_app/src/Enums/custom_notification.dart';

// enum NotificationType { success, error, info }

class CustomToast extends StatelessWidget {
  final String message;
  final CustomNotificationType type;

  const CustomToast({super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showNotification(context);
    });

    // Return an empty Container as this widget does not display anything itself
    return Container();
  }

  void _showNotification(BuildContext context) {
    switch (type) {
      case CustomNotificationType.success:
        ElegantNotification.success(
          description: _buildMessage(),
          height: 60,
          animation: AnimationType.fromRight,
          showProgressIndicator: false,
          displayCloseButton: false,
        ).show(context);
        break;
      case CustomNotificationType.error:
        ElegantNotification.error(
          description: _buildMessage(),
        ).show(context);
        break;
      case CustomNotificationType.info:
        ElegantNotification.info(
          description: _buildMessage(),
        ).show(context);
        break;
      // default:
      //   ElegantNotification.info(
      //     description: _buildMessage(),
      //   ).show(context);
    }
  }

  AutoSizeText _buildMessage() {
    return AutoSizeText(
      message,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    );
  }
}
