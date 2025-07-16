import 'package:bc_admin/data/doctor_list_model.dart';
import 'package:bc_admin/ui/widgets/accept_delete_dialog.dart';
import 'package:bc_admin/ui/widgets/launch_url_text_widget.dart';
import 'package:bc_admin/ui/widgets/my_app_bar.dart';
import 'package:bc_admin/ui/widgets/my_container.dart';
import 'package:bc_admin/ui/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorInfoPage extends StatefulWidget {
  const DoctorInfoPage({super.key, required this.doctor});

  final DoctorListModel doctor;

  @override
  State<DoctorInfoPage> createState() => _DoctorInfoPageState();
}

class _DoctorInfoPageState extends State<DoctorInfoPage> {
  bool _edit = false;
  final duration = const Duration(milliseconds: 300);

  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late String hospital = widget.doctor.hospital;
  late String address = widget.doctor.address;

  void _toggleEdit() => setState(() => _edit = !_edit);

  @override
  void initState() {
    super.initState();
    _hospitalController.text = widget.doctor.hospital;
    _addressController.text = widget.doctor.address;
  }

  @override
  void dispose() {
    _hospitalController.dispose();
    _addressController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _saveEditing() {
    setState(() {
      hospital = _hospitalController.text;
      address = _addressController.text;
      _edit = false;
    });
  }

  void _discardEditing() {
    setState(() {
      _hospitalController.text = hospital;
      _addressController.text = address;
      _edit = false;
    });
  }

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

    if (_edit) {
      Future.delayed(Duration(milliseconds: 50), () {
        if (context.mounted) {
          FocusScope.of(context).requestFocus(_focusNode);
        }
      });
    }

    return Scaffold(
      appBar: MyAppBar(title: "Информация о враче"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMainPart(),
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
                    TextFormField(
                      controller: _hospitalController,
                      style: theme.textTheme.titleSmall,
                      readOnly: !_edit,
                      maxLines: null,
                      focusNode: _focusNode,
                      autofocus: _edit,
                      decoration: const InputDecoration(
                        hintText: "Введите название больницы",
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                    TextFormField(
                      controller: _addressController,
                      style: theme.textTheme.titleSmall,
                      readOnly: !_edit,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "Введите адрес больницы",
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                AnimatedCrossFade(
                  duration: duration,
                  firstChild: MyContainer(
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
                        url: Uri(scheme: "tel", path: widget.doctor.phone),
                        text: widget.doctor.phone,
                        errorMessage: "Ошибка открытия телефона!",
                      ),
                      LaunchUrlTextWidget(
                        url: Uri(scheme: "mailto", path: widget.doctor.email),
                        text: widget.doctor.email,
                        errorMessage: "Ошибка открытия почты!",
                      ),
                    ],
                  ),
                  secondChild: Container(),
                  crossFadeState: _edit
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
                Spacer(),
                _buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainPart() {
    ThemeData theme = Theme.of(context);

    return AnimatedSize(
      duration: duration,
      child: AnimatedOpacity(
        duration: duration,
        opacity: _edit ? 0 : 1,
        child: SizedBox(
          height: _edit ? 0 : null,
          child: MyContainer(
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
                widget.doctor.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.primaryColor,
                  // height: 1.0,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                widget.doctor.post,
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.0),
              ),
              Text(
                "${widget.doctor.gender == 0 ? "Муж" : "Жен"}. ${widget.doctor.age} лет",
                style: theme.textTheme.bodyLarge?.copyWith(height: 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        AnimatedCrossFade(
          firstChild: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  theme.colorScheme.primary,
                ),
              ),
              onPressed: _toggleEdit,
              child: Text("Редактировать", style: theme.textTheme.bodyLarge),
            ),
          ),
          secondChild: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  theme.colorScheme.primary,
                ),
              ),
              onPressed: _discardEditing,
              child: Text("Отмена", style: theme.textTheme.bodyLarge),
            ),
          ),
          crossFadeState: _edit
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: duration,
        ),
        SizedBox(height: 10),
        AnimatedCrossFade(
          duration: duration,
          firstChild: SizedBox(
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
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            ),
          ),
          secondChild: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveEditing,
              child: Text("Сохранить"),
            ),
          ),
          crossFadeState: _edit
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
      ],
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
