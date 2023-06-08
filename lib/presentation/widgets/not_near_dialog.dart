import 'package:flutter/material.dart';
import 'package:guatappe/config/theme/app_theme.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';

class NotNearDialog extends StatelessWidget {
  final MarkerEntity marker;
  final VoidCallback? onPressed;

  const NotNearDialog({
    super.key,
    required this.marker,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        icon: Icon(Icons.info, color: AppTheme.colorApp, size: 50),
        actionsPadding: EdgeInsets.all(5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No estas cerca...'),
            Icon(Icons.sentiment_dissatisfied)
          ],
        ),
        content: Text(
          'Debes estar cerca de la ubicación ${marker.name} para vivir la experiencia AR',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 30,
                ),
                Container(width: 5),
                Text(
                  'Cómo llegar',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
            onPressed: onPressed,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppTheme.colorApp)),
          ),
        ]);
  }
}
