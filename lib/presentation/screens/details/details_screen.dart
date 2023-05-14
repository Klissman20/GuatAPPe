import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guatappe/infrastructure/models/marker_model.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  static const String name = 'details_screen';
  MarkerModel marker;
  DetailsScreen({super.key, required this.marker});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.marker.name}'),
        leading: BackButton(
          color: Colors.deepOrange,
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              width: double.infinity,
              child: widget.marker.image),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${widget.marker.description}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${widget.marker.description}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${widget.marker.description}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${widget.marker.description}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${widget.marker.description}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${widget.marker.description}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              '${widget.marker.description}',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      )),

      /* bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepOrange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.location_on_rounded),
              label: "Como llegar"),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.add_a_photo),
              label: "Activar AR")
        ],
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ), */
    );
  }
}
