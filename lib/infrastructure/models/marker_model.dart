import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final String lorem =
    '''
Est in sunt adipisicing elit ipsum cillum et ea ullamco voluptate qui 
    incididunt aute commodo. Deserunt excepteur commodo magna et id consequat 
    sit nostrud. Officia ut cillum veniam est est quis aliquip adipisicing exercitation in.
    Lorem ex qui pariatur eiusmod. Deserunt fugiat magna incididunt fugiat tempor deserunt ipsum 
    fugiat consectetur culpa culpa. Ut pariatur non deserunt tempor enim nisi adipisicing quis quis 
    in velit laborum ex. Id voluptate reprehenderit enim fugiat incididunt tempor dolor. Aliquip eiusmod 
    ex tempor voluptate duis aliquip dolore minim. Id sunt sit qui aliqua magna aliquip.
    Ea nisi dolore qui duis adipisicing laboris velit quis pariatur quis ullamco dolor sit sint. Commodo 
    enim aute non dolor reprehenderit exercitation veniam pariatur. Est dolore ut non duis ipsum minim. Deserunt 
    minim cillum cillum culpa voluptate exercitation culpa irure eiusmod.
Est in sunt adipisicing elit ipsum cillum et ea ullamco voluptate qui 
    incididunt aute commodo. Deserunt excepteur commodo magna et id consequat 
    sit nostrud. Officia ut cillum veniam est est quis aliquip adipisicing exercitation in.
    Lorem ex qui pariatur eiusmod. Deserunt fugiat magna incididunt fugiat tempor deserunt ipsum 
    fugiat consectetur culpa culpa. Ut pariatur non deserunt tempor enim nisi adipisicing quis quis 
    in velit laborum ex. Id voluptate reprehenderit enim fugiat incididunt tempor dolor. Aliquip eiusmod 
    ex tempor voluptate duis aliquip dolore minim. Id sunt sit qui aliqua magna aliquip.
    Ea nisi dolore qui duis adipisicing laboris velit quis pariatur quis ullamco dolor sit sint. Commodo 
    enim aute non dolor reprehenderit exercitation veniam pariatur. Est dolore ut non duis ipsum minim. Deserunt 
    minim cillum cillum culpa voluptate exercitation culpa irure eiusmod.
Est in sunt adipisicing elit ipsum cillum et ea ullamco voluptate qui 
    incididunt aute commodo. Deserunt excepteur commodo magna et id consequat 
    sit nostrud. Officia ut cillum veniam est est quis aliquip adipisicing exercitation in.
    Lorem ex qui pariatur eiusmod. Deserunt fugiat magna incididunt fugiat tempor deserunt ipsum 
    fugiat consectetur culpa culpa. Ut pariatur non deserunt tempor enim nisi adipisicing quis quis 
    in velit laborum ex. Id voluptate reprehenderit enim fugiat incididunt tempor dolor. Aliquip eiusmod 
    ex tempor voluptate duis aliquip dolore minim. Id sunt sit qui aliqua magna aliquip.
    Ea nisi dolore qui duis adipisicing laboris velit quis pariatur quis ullamco dolor sit sint. Commodo 
    enim aute non dolor reprehenderit exercitation veniam pariatur. Est dolore ut non duis ipsum minim. Deserunt 
    minim cillum cillum culpa voluptate exercitation culpa irure eiusmod.
    ''';

final Image image =
    Image.asset("assets/images/plazoleta.png", fit: BoxFit.cover);

List<MarkerModel> markers = [
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/piedra.png", fit: BoxFit.cover),
    name: 'La Piedra',
    position: const LatLng(6.2207260149012455, -75.17947304698288),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Comfama',
    position: const LatLng(6.229598621338858, -75.1787076388338),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Bicentenario',
    position: const LatLng(6.23265236289733, -75.16662940513794),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Plazoleta del Zócalero',
    position: const LatLng(6.235386582227664, -75.16274920989979),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Comando',
    position: const LatLng(6.235236977647446, -75.1623255947003),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/cordero.png", fit: BoxFit.cover),
    name: 'Cordero',
    position: const LatLng(6.2350918057533615, -75.16190866815133),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Terminal de Transporte',
    position: const LatLng(6.234777081816057, -75.16134013193083),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/malecom.png", fit: BoxFit.cover),
    name: 'Malecón',
    position: const LatLng(6.235541727677295, -75.16168794231076),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Memoria de puertas, ventanas y bocallaves',
    position: const LatLng(6.235086264840695, -75.16137580478286),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Casa del Arriero',
    position: const LatLng(6.234312583116759, -75.15966299669682),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Calle del Recuerdo',
    position: const LatLng(6.23343118128229, -75.16078372149775),
  ),
  MarkerModel(
    description: lorem,
    image: Image.asset("assets/images/calle.png", fit: BoxFit.cover),
    name: 'Calle Jiménez',
    position: const LatLng(6.2327577833006, -75.16103285510259),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Callejón Julia Pastusa',
    position: const LatLng(6.2325869733987895, -75.16154961107048),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Mural Enriquetica - Bernardo Arcila',
    position: const LatLng(6.233056309831474, -75.16168663649425),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Zócalo Banda de los Zuluaga',
    position: const LatLng(6.23329097788889, -75.16162422887523),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Parque Principal',
    position: const LatLng(6.234259319683774, -75.16189149626756),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Iglesia y Casa Cural',
    position: const LatLng(6.234133893898507, -75.16138409520177),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Mural de los 200 años',
    position: const LatLng(6.234175702496582, -75.1611738086747),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Alcaldía',
    position: const LatLng(6.23447240858383, -75.16138952194993),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Casa Isidora Urrea',
    position: const LatLng(6.234556025724918, -75.16122264940549),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Hospital la Inmaculada',
    position: const LatLng(6.233093330814248, -75.15692414269232),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Letras Guatapé',
    position: const LatLng(6.234454448410652, -75.15721275695284),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Capilla hermanas de Santa Ana',
    position: const LatLng(6.232221605334246, -75.15707683829378),
  ),
  MarkerModel(
    description: lorem,
    image: image,
    name: 'Alto Verde',
    position: const LatLng(6.231356424733816, -75.15328502323882),
  )
];

LatLng initialMapCenter = const LatLng(6.233, -75.158);

class MarkerModel {
  String name;
  String description;
  Image image;
  LatLng position;

  MarkerModel(
      {required this.name,
      required this.description,
      required this.position,
      required this.image});
}
