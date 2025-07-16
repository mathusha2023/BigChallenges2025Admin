import 'package:bc_admin/data/doctor_list_model.dart';
import 'package:bc_admin/ui/widgets/accept_delete_dialog.dart';
import 'package:bc_admin/ui/widgets/launch_url_text_widget.dart';
import 'package:bc_admin/ui/widgets/my_app_bar.dart';
import 'package:bc_admin/ui/widgets/my_container.dart';
import 'package:bc_admin/ui/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorInfoPage extends StatelessWidget {
  const DoctorInfoPage({super.key, required this.doctor});

  final DoctorListModel doctor;

  void _deleteDoctor(BuildContext context) async {
    var needDelete = await _showDeleteDialog(context);
    if (needDelete && context.mounted) {
      showSuccessSnackBar(context, "Врач удален!");
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: MyAppBar(title: "Информация о враче"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyContainer(
                  alignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: theme.colorScheme.primary,
                      child: Image(
                        image: AssetImage("assets/images/doctor_icon.png"),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      doctor.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.primaryColor,
                        // height: 1.0,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      doctor.post,
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.0),
                    ),
                    Text(
                      "${doctor.gender == 0 ? "Муж" : "Жен"}. ${doctor.age} лет",
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.0),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                MyContainer(
                  alignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Данные",
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.grey,
                        fontSize: 22,
                      ),
                    ),
                    Text(doctor.hospital, style: theme.textTheme.titleSmall),
                    Text(doctor.address, style: theme.textTheme.titleSmall),
                  ],
                ),

                SizedBox(height: 20),
                MyContainer(
                  alignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Контакты",
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.grey,
                        fontSize: 22,
                      ),
                    ),
                    LaunchUrlTextWidget(
                      url: Uri(scheme: "tel", path: doctor.phone),
                      text: doctor.phone,
                      errorMessage: "Ошибка открытия телефона!",
                    ),
                    LaunchUrlTextWidget(
                      url: Uri(scheme: "mailto", path: doctor.email),
                      text: doctor.email,
                      errorMessage: "Ошибка открытия почты!",
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        theme.colorScheme.primary,
                      ),
                    ),
                    onPressed: () => _deleteDoctor(context),
                    child: Text(
                      "Удалить врача",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showDeleteDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) =>
              AcceptDeleteDialog(text: "Вы уверены, что хотите удалить врача?"),
        ) ??
        false;
  }
}
