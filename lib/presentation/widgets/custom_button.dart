import 'package:flutter/material.dart';
import 'package:guatappe/config/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.width,
    required this.buttonText,
    this.onTap,
  }) : super(key: key);
  final double width;
  final String buttonText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 8.0,
        borderRadius: BorderRadius.circular(6.0),
        color: AppTheme.colorApp,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 40.0,
            width: MediaQuery.of(context).size.width * width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    buttonText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
