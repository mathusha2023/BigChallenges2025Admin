import 'package:bc_admin/ui/widgets/my_app_bar.dart';
import 'package:bc_admin/ui/widgets/show_snackbar.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddDoctorPage extends StatefulWidget {
  const AddDoctorPage({super.key});

  @override
  State<AddDoctorPage> createState() => _AddDoctorPageState();
}

class _AddDoctorPageState extends State<AddDoctorPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  int _selectedGender = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _hospitalController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Добавьте нового врача", style: theme.textTheme.titleLarge),
              Text(
                'Занесите данные врача в поля ввода и нажмите кнопку сохранить',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 24),

              // Поле ФИО
              Text('ФИО', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Васильев Василий Васильевич",
                ),
              ),
              const SizedBox(height: 16),

              Text('Почта', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(hintText: "vasilievvv@yandex.ru"),
              ),
              const SizedBox(height: 16),

              Text('Телефон', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(hintText: "+7 (999) 999-99-99"),
              ),
              const SizedBox(height: 16),

              Text('Наименование больницы', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              TextField(
                controller: _hospitalController,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(hintText: "Больница No1"),
              ),
              const SizedBox(height: 16),

              Text('Адрес больницы', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              TextField(
                controller: _addressController,
                style: theme.textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "г. Москва, ул. Пушкинская, д. 1",
                ),
              ),
              const SizedBox(height: 16),

              // Поле Пол
              Text('Пол', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedGender == 0 ? 'male' : 'female',
                items: [
                  DropdownMenuItem(
                    value: 'male',
                    child: Text('Мужской', style: theme.textTheme.bodyMedium),
                  ),
                  DropdownMenuItem(
                    value: 'female',
                    child: Text('Женский', style: theme.textTheme.bodyMedium),
                  ),
                ],
                onChanged: (value) {
                  if (value == "male") {
                    _selectedGender = 0;
                  }
                  if (value == "female") {
                    _selectedGender = 1;
                  }
                },
                hint: const Text('Выберите пол'),
              ),
              const SizedBox(height: 16),

              // Поле Дата рождения
              Text('Дата рождения', style: theme.textTheme.bodyLarge),
              const SizedBox(height: 8),
              TextField(
                onTap: () {
                  _openDatePicker(context);
                  // Обработка выбранной даты
                },
                controller: _dateController,
                decoration: InputDecoration(hintText: 'ДД.ММ.ГГГГ'),
                readOnly: true,
              ),
              SizedBox(height: 50),
              // Кнопка Сохранить
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    String message = '';
                    if (_nameController.text.trim().isEmpty) {
                      message = 'Введите ФИО врача';
                    } else if (_emailController.text.trim().isEmpty) {
                      message = 'Введите почту';
                    } else if (_phoneController.text.trim().isEmpty) {
                      message = 'Введите номер телефона';
                    } else if (_hospitalController.text.trim().isEmpty) {
                      message = 'Введите наименование больницы';
                    } else if (_addressController.text.trim().isEmpty) {
                      message = 'Введите адрес больницы';
                    } else if (_dateController.text.isEmpty) {
                      message = 'Выберите дату рождения врача';
                    } else if (_nameController.text.isNotEmpty &&
                        _dateController.text.isNotEmpty &&
                        _phoneController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _addressController.text.isNotEmpty &&
                        _hospitalController.text.isNotEmpty) {
                      // Отправка данных на сервер
                      context.pop();
                      return;
                    }
                    showErrorSnackBar(context, message);
                  },

                  child: Text(
                    'Сохранить',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      dismissable: true,
      pickerTitle: Text(
        'Выберите дату',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: _selectedDate ?? DateTime.now(),
      maxDateTime: DateTime.now(),
      minDateTime: DateTime(1900),
      pickerTextStyle: Theme.of(context).textTheme.displayLarge ?? TextStyle(),
      buttonContent: Text(
        "Выбрать",
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      buttonWidth: MediaQuery.of(context).size.width * 0.5,
      buttonStyle: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      onSubmit: (value) {
        setState(() {
          _selectedDate = value;
          _dateController.text =
              "${value.day.toString().padLeft(2, '0')}.${value.month.toString().padLeft(2, '0')}.${value.year.toString().padLeft(4, '0')}";
        });
      },
      // bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }
}
