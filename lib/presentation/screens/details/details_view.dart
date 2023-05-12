import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatefulWidget {
  static const String name = 'details_screen';

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plazoleta del Zocalo"),
        leading: BackButton(
          color: Colors.deepOrange,
          onPressed: () {
            context.goNamed('map_screen');
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.asset("assets/images/plazoleta.png"),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Labore nisi quis aute laborum veniaPariatur occaecat ut esse do quis Lorem. Ullamco exercitation voluptate irure tempor ea non adipisicing officia. Occaecat consectetur et nulla id. Ut et reprehenderit reprehenderit esse velit ea do commodo minim tempor tempor. Nulla reprehenderit laboris consequat aliqua do id eiusmod sit ex. Ex cupidatat quis fugiat ipsum eu reprehenderit dolore enim dolore commodo ullamco nulla officia proident. Est commodo ad dolore voluptate ad amet sit veniam. Cillum non veniam occaecat enim esse culpa eu anim sit et veniam ut adipisicing. Esse sunt sint eu quis cupidatat. Exercitation laborum sit sit officia cillum amet nostrud deserunt irure in. Cupidatat cupidatat sunt labore duis amet ad proident elit. Lorem esse dolore proident ex id incididunt nisi commodo duis cillum deserunt fugiat. Exercitation laborum in enim consectetur cillum deserunt cillum consequat laboris. Do duis voluptate elit reprehenderit proident reprehenderit occaecat aliqua aliqua culpa sunt ut. Ea reprehenderit id ex ex anim do ad ad cupidatat cillum. Consequat sunt et reprehenderit laborum adipisicing in mollit esse non aute non quis. Exercitation elit enim excepteur id Lorem aute sint tempor. In deserunt id ex non occaecat proident amet ut quis proident. Excepteur consequat aliqua labore velit proident aute. Excepteur laborum Lorem anim consequat sit eiusmod sint veniam ullamco nulla fugiat. Esse Lorem amet reprehenderit minim adipisicing dolor. Culpa non sint tempor ad nisi laboris nisi elit. Consectetur veniam est cillum velit excepteur esse nulla.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
