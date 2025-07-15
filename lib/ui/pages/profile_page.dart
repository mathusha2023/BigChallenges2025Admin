import 'package:bc_admin/ui/widgets/my_app_bar.dart';
import 'package:bc_admin/ui/widgets/profile_tile_widget.dart';
import 'package:bc_admin/ui/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Профиль"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Theme.of(context).cardColor,
                child: Image(
                  image: AssetImage("assets/images/profile_icon.png"),
                ),
              ),
              Text(
                "Администратор",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              ProfileTileWidget(
                image: "assets/images/logout_icon.png",
                title: "Выход",
                onTap: () async {
                  if (context.mounted) {
                    showErrorSnackBar(context, "Ошибка выхода из аккаунта!");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
