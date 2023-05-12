import 'package:flutter/material.dart';

class InfoPopup extends StatelessWidget {
  const InfoPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        Text(
          'En las escalinatas coloridas de ésta plazoleta podemos encontrar una representación pictórica de la flora, la fauna y las tradiciones de los habitantes a lo largo de su historia. Es habitual encontrar alguna banda de música tocando y animando el ambiente.',
          style: TextStyle(fontSize: 16),
        ),
        Text(
            style: TextStyle(fontSize: 16),
            'Además, alrededor de la plaza encontrarás innumerables tiendas para llevarte algún recuerdo de Guatapé.'),
        Text(
            style: TextStyle(fontSize: 16),
            'Además, alrededor de la plaza encontrarás innumerables tiendas para llevarte algún recuerdo de Guatapé.'),
        Text(
            style: TextStyle(fontSize: 16),
            'Además, alrededor de la plaza encontrarás innumerables tiendas para llevarte algún recuerdo de Guatapé.'),
      ],
    );
  }
}
