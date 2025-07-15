import 'package:flutter/material.dart';

class DoctorIconWidget extends StatelessWidget {
  const DoctorIconWidget({
    super.key,
    required this.width,
    required this.height,
    required this.image,
  });

  final double width, height;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.primary,
      ),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Image(image: AssetImage(image)),
      ),
    );
  }
}
