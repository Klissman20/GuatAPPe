import 'package:flutter/material.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class Header extends StatelessWidget {
  final MarkerEntity selectedMarker;
  const Header({super.key, required this.selectedMarker});

  @override
  Widget build(BuildContext context) {
    final BorderRadius _borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0));

    return ForceDraggableWidget(
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration:
              BoxDecoration(borderRadius: _borderRadius, color: Colors.white),
          child: Column(children: [
            Container(
              width: 55,
              margin: const EdgeInsets.only(top: 5),
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.black.withOpacity(0.5)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                selectedMarker.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.grey, blurRadius: 2.0)]),
              ),
            ),
            Divider(height: 1)
          ])),
    );
  }
}
