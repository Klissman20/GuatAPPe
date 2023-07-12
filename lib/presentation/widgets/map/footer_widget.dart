import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/domain/entities/marker_entity.dart';
import 'package:guatappe/presentation/screens/screens.dart';
import 'package:guatappe/presentation/widgets/custom_button.dart';
import 'package:guatappe/presentation/widgets/not_near_dialog.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class Footer extends StatefulWidget {
  final bool isPanelClosed;
  final Future<void> Function(MarkerEntity) getPolyline;
  final MarkerEntity? selectedMarker;
  final PanelController panelController;
  const Footer(
      {super.key,
      required this.isPanelClosed,
      required this.getPolyline,
      required this.selectedMarker,
      required this.panelController});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          (widget.selectedMarker != null)
              ? AnimatedContainer(
                  curve: Curves.easeInOutExpo,
                  duration: Duration(milliseconds: 200),
                  width: widget.isPanelClosed
                      ? MediaQuery.of(context).size.width / 2
                      : 0,
                  child: CustomButton(
                      width: 0.4,
                      buttonText: "Cómo llegar",
                      onTap: () async {
                        await widget.getPolyline(widget.selectedMarker!);
                      }),
                )
              : SizedBox(),
          (widget.selectedMarker != null)
              ? AnimatedContainer(
                  curve: Curves.easeInOutExpo,
                  duration: Duration(milliseconds: 200),
                  width: widget.isPanelClosed
                      ? 0
                      : MediaQuery.of(context).size.width,
                  child: CustomButton(
                    width: 0.6,
                    buttonText: 'Activar AR',
                    onTap: () {
                      //TODO: show dialog or Unity logic
                      context.pushNamed(ARScreen.name);
                      // showGeneralDialog(
                      //     context: context,
                      //     barrierDismissible: true,
                      //     barrierLabel: '',
                      //     pageBuilder: (context, a1, a2) {
                      //       return Container();
                      //     },
                      //     transitionBuilder: (ctx, a1, a2, child) {
                      //       return Transform.scale(
                      //         scale: Curves.easeInOut.transform(a1.value),
                      //         child: NotNearDialog(
                      //             marker: widget.selectedMarker!,
                      //             onPressed: () async {
                      //               Navigator.of(context).pop();
                      //               widget.panelController.close();
                      //               await widget
                      //                   .getPolyline(widget.selectedMarker!);
                      //             }),
                      //       );
                      //     });
                    },
                  ),
                )
              : SizedBox(),
          (widget.selectedMarker != null)
              ? AnimatedContainer(
                  curve: Curves.easeInOutExpo,
                  duration: Duration(milliseconds: 200),
                  width: widget.isPanelClosed
                      ? MediaQuery.of(context).size.width / 2
                      : 0,
                  child: CustomButton(
                    width: 0.4,
                    buttonText: 'Ver más',
                    onTap: () {
                      widget.panelController.open();
                    },
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
