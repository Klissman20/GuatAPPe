import 'package:flutter/material.dart';
import 'package:guatappe/infrastructure/models/marker_model.dart';

class DetailsScreen extends StatelessWidget {
  static const String name = 'details_screen';
  final MarkerModel marker;
  final bool visibility;
  final Function(bool value)? onChange;

  DetailsScreen(
      {super.key,
      required this.marker,
      required this.visibility,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    DraggableScrollableController _dragController =
        DraggableScrollableController();
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification notification) {
        if (visibility && notification.extent >= 0.2)
          onChange!(false);
        else if (!visibility && notification.extent < 0.2) onChange!(true);
        return false;
      },
      child: DraggableScrollableSheet(
          controller: _dragController,
          initialChildSize: visibility ? 0.8 : 0.075,
          minChildSize: 0.075,
          maxChildSize: 0.8,
          snap: true,
          expand: true,
          builder: (context, scrollController) {
            return Container(
                color: Colors.white,
                child: CustomScrollView(controller: scrollController, slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    titleSpacing: 3,
                    floating: true,
                    forceElevated: true,
                    elevation: 5,
                    pinned: true,
                    snap: true,
                    title: GestureDetector(
                      onTap: () {
                        _dragController.animateTo(0.8,
                            duration: Duration(milliseconds: 900),
                            curve: Curves.easeInOut);
                      },
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              margin: const EdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.5),
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                            Text(
                              "${marker.name} $visibility",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      child: marker.image?[0] ?? Image.asset('name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        marker.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ]))
                ]));
          }),
    );
  }
}
