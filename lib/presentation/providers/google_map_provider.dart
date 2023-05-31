import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/marker_entity.dart';

final markersListProvider = Provider<List<MarkerEntity>>((ref) {
  final String lorem =
      '''Nulla ullamco consectetur sunt consequat do minim excepteur proident et mollit esse incididunt commodo. Magna in sit dolor velit incididunt eu nostrud duis dolore id velit ut. Consequat exercitation commodo exercitation duis eu exercitation laboris excepteur. Do adipisicing eu mollit commodo commodo ad quis.
          Eu aute tempor aliqua sit elit nostrud ex exercitation dolore id eu sunt quis. Tempor minim laborum consequat esse occaecat exercitation magna. Amet qui officia officia eu commodo. Dolore id ut nostrud veniam eiusmod anim.
          Et occaecat consectetur cillum reprehenderit ullamco est magna quis ad id. Occaecat adipisicing deserunt pariatur quis deserunt do irure exercitation est consectetur aliqua dolor. Magna ipsum eu Lorem cillum ad cillum magna labore officia officia velit excepteur consequat. Esse dolore enim nostrud deserunt eu enim. Est sunt anim id ea occaecat quis ullamco cupidatat.
          Nostrud ipsum non non dolore. Duis est ex tempor velit ex sint irure culpa aute velit officia. Aliqua tempor adipisicing exercitation cupidatat aliquip culpa Lorem duis elit consequat id laborum anim. Excepteur ad culpa magna consectetur id. Quis labore ut deserunt fugiat labore Lorem ea. Magna esse ullamco velit veniam dolor quis ipsum irure cupidatat amet excepteur sit do amet.Proident laboris aute anim nisi mollit labore id Lorem Lorem occaecat in occaecat. Non ullamco excepteur nulla in ut mollit officia deserunt ea. Id dolore nostrud qui amet sit non deserunt deserunt fugiat eiusmod. Culpa exercitation nostrud reprehenderit dolore occaecat aute voluptate adipisicing excepteur enim officia consectetur. Excepteur nostrud laborum nulla sint incididunt cillum laboris amet elit id incididunt. Nisi ullamco qui tempor eiusmod culpa eu esse reprehenderit veniam labore non. Amet do dolore pariatur est duis ullamco sunt fugiat exercitation amet dolore dolor in.
          Duis ullamco enim enim incididunt anim aute enim laboris. Lorem cupidatat proident tempor culpa qui reprehenderit non consequat Lorem amet officia cillum reprehenderit ullamco. Enim commodo irure quis adipisicing voluptate laborum est non id. Ea eiusmod eu officia pariatur ullamco voluptate sint reprehenderit minim enim. Reprehenderit aute aute dolor est aute magna sit. Cupidatat nisi esse sint velit incididunt nisi aliquip. Eiusmod sit incididunt dolore do mollit tempor elit magna enim eu id magna.
      ''';

  final List<Image> image = [
    Image.asset("assets/images/plazoleta.png", fit: BoxFit.cover)
  ];

  final pinLocationIcon = BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(), 'assets/logo/icono_40x40.png');

  final List<MarkerEntity> markers = [
    MarkerEntity(
      id: 0,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: [Image.asset("assets/images/piedra.png", fit: BoxFit.cover)],
      name: 'La Piedra',
      position: const LatLng(6.2207260149012455, -75.17947304698288),
    ),
    MarkerEntity(
      id: 1,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Comfama',
      position: const LatLng(6.229598621338858, -75.1787076388338),
    ),
    MarkerEntity(
      id: 2,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Bicentenario',
      position: const LatLng(6.23265236289733, -75.16662940513794),
    ),
    MarkerEntity(
      id: 3,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Plazoleta del Zócalero',
      position: const LatLng(6.235386582227664, -75.16274920989979),
    ),
    MarkerEntity(
      id: 4,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Comando',
      position: const LatLng(6.235236977647446, -75.1623255947003),
    ),
    MarkerEntity(
      id: 5,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Cordero',
      position: const LatLng(6.2350918057533615, -75.16190866815133),
    ),
    MarkerEntity(
      id: 6,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Terminal de Transporte',
      position: const LatLng(6.234777081816057, -75.16134013193083),
    ),
    MarkerEntity(
      id: 7,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Malecón',
      position: const LatLng(6.235541727677295, -75.16168794231076),
    ),
    MarkerEntity(
      id: 8,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Memoria de puertas, ventanas y bocallaves',
      position: const LatLng(6.235086264840695, -75.16137580478286),
    ),
    MarkerEntity(
      id: 9,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Casa del Arriero',
      position: const LatLng(6.234312583116759, -75.15966299669682),
    ),
    MarkerEntity(
      id: 10,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Calle del Recuerdo',
      position: const LatLng(6.23343118128229, -75.16078372149775),
    ),
    MarkerEntity(
      id: 11,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Calle Jiménez',
      position: const LatLng(6.2327577833006, -75.16103285510259),
    ),
    MarkerEntity(
      id: 12,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Callejón Julia Pastusa',
      position: const LatLng(6.2325869733987895, -75.16154961107048),
    ),
    MarkerEntity(
      id: 13,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Mural Enriquetica - Bernardo Arcila',
      position: const LatLng(6.233056309831474, -75.16168663649425),
    ),
    MarkerEntity(
      id: 14,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Zócalo Banda de los Zuluaga',
      position: const LatLng(6.23329097788889, -75.16162422887523),
    ),
    MarkerEntity(
      id: 15,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Parque Principal',
      position: const LatLng(6.234259319683774, -75.16189149626756),
    ),
    MarkerEntity(
      id: 16,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Iglesia y Casa Cural',
      position: const LatLng(6.234133893898507, -75.16138409520177),
    ),
    MarkerEntity(
      id: 17,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Mural de los 200 años',
      position: const LatLng(6.234175702496582, -75.1611738086747),
    ),
    MarkerEntity(
      id: 18,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Alcaldía',
      position: const LatLng(6.23447240858383, -75.16138952194993),
    ),
    MarkerEntity(
      id: 19,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Casa Isidora Urrea',
      position: const LatLng(6.234556025724918, -75.16122264940549),
    ),
    MarkerEntity(
      id: 20,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Hospital la Inmaculada',
      position: const LatLng(6.233093330814248, -75.15692414269232),
    ),
    MarkerEntity(
      id: 21,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Letras Guatapé',
      position: const LatLng(6.234454448410652, -75.15721275695284),
    ),
    MarkerEntity(
      id: 22,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Capilla hermanas de Santa Ana',
      position: const LatLng(6.232221605334246, -75.15707683829378),
    ),
    MarkerEntity(
      id: 23,
      iconMarker: pinLocationIcon,
      description: lorem,
      image: image,
      name: 'Alto Verde',
      position: const LatLng(6.231356424733816, -75.15328502323882),
    )
  ];
  return markers;
});

final initialCenterProvider = Provider((ref) {
  final LatLng initialMapCenter = const LatLng(6.233, -75.158);
  return initialMapCenter;
});
