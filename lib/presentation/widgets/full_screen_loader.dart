import 'package:flutter/material.dart';
import 'package:guatappe/config/theme/app_theme.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Loading data',
      'Getting location',
      'Placing anchors',
      'Please wait',
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.colorApp,
        child: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Loading',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
              const SizedBox(
                height: 10,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder(
                  stream: getLoadingMessages(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const Text('Loading...',
                          style: TextStyle(color: Colors.white, fontSize: 14));
                    return Text(snapshot.data!, style: TextStyle(color: Colors.white, fontSize: 14),);
                  })
            ]),
          ),
        ),
      ),
    );
  }
}
