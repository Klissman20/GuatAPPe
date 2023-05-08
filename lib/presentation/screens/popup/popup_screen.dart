import 'package:flutter/material.dart';

class PopupScreen extends StatelessWidget {
  const PopupScreen({super.key});

  static const String name = 'popup_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Image.asset('assets/images/plazoleta.png'),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.start,
              'Plazoleta del Zócalo',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'En las escalinatas coloridas de ésta plazoleta podemos encontrar una representación pictórica de la flora, la fauna y las tradiciones de los habitantes a lo largo de su historia. Es habitual encontrar alguna banda de música tocando y animando el ambiente.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                  style: TextStyle(fontSize: 16),
                  'Además, alrededor de la plaza encontrarás innumerables tiendas para llevarte algún recuerdo de Guatapé.'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                child: const Text('Como llegar'),
                onPressed: () {},
              ),
              FilledButton(
                child: const Text('Activar AR'),
                onPressed: () {},
              )
            ],
          )
        ]),
      ),
    );
  }
}
