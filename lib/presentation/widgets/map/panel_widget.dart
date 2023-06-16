import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class Panel extends StatelessWidget {
  final bool isPanelClosed;
  final MarkerEntity? selectedMarker;
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
                    const SizedBox(height: 30),
                    (selectedMarker != null)
                        ? (selectedMarker!.imageList!.isNotEmpty)
                            ? _SliderImages(
                                isPanelClosed: isPanelClosed,
                                selectedMarker: selectedMarker)
                            : (isPanelClosed)
                                ? SizedBox()
                                : SizedBox(
                                    height: 250,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        (selectedMarker != null)
                            ? selectedMarker!.description
                            : 'Seleccione un lugar',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ])),
        ));
  }
}

class _SliderImages extends StatelessWidget {
  const _SliderImages({
    required this.isPanelClosed,
    required this.selectedMarker,
  });

  final bool isPanelClosed;
  final MarkerEntity? selectedMarker;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
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
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: selectedMarker!.imageList?[0],
            ),
          )
        ]);
  }
}
