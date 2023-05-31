import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class Panel extends StatelessWidget {
  final bool isPanelClosed;
  final MarkerEntity selectedMarker;
  final ScrollController scrollController;
  final PanelController panelController;
  const Panel(
      {super.key,
      required this.selectedMarker,
      required this.scrollController,
      required this.isPanelClosed,
      required this.panelController});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        child: Container(
          margin: EdgeInsets.only(top: 15),
          child: SingleChildScrollView(
              physics: PanelScrollPhysics(controller: panelController),
              controller: scrollController,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 35),
                    CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enlargeFactor: 0.35,
                        height: 260,
                        autoPlayInterval: Duration(seconds: 4),
                        viewportFraction: 1,
                        autoPlay: !isPanelClosed,
                      ),
                      items: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: selectedMarker.image?[0],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Image.asset('assets/images/cordero.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Image.asset('assets/images/calle.png',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        selectedMarker.description,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ])),
        ));
  }
}
