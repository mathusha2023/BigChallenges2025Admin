import 'package:flutter/material.dart';

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  final String image;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          splashColor: Colors.transparent,
          leading: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor,
            ),
            child: Image(image: AssetImage(image), width: 25, height: 25),
          ),
          title: Text(title),
          trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey),
          onTap: onTap,
        ),
        Divider(color: Theme.of(context).cardColor),
      ],
    );
  }
}
