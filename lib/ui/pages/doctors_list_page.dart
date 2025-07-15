import 'package:bc_admin/data/doctor_list_model.dart';
import 'package:bc_admin/ui/widgets/doctor_list_tile_widget.dart';
import 'package:bc_admin/ui/widgets/my_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorsListPage extends StatefulWidget {
  const DoctorsListPage({super.key});

  @override
  State<DoctorsListPage> createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  static Future? _future;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _showHeader = true;
  double _lastScrollOffset = 0;
  List<DoctorListModel> _doctors = [];
  String _search = "";

  final FocusNode _searchFocusNode = FocusNode(); // Добавляем FocusNode

  void fetch() async {
    _future = Future.delayed(
      Duration(seconds: 2),
      () => List.generate(
        15,
        (int index) =>
            DoctorListModel("${index + 1}", "Иванов Иван Иванович", 47, 0),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetch();

    _scrollController.addListener(() {
      final currentOffset = _scrollController.offset;
      if (currentOffset > _lastScrollOffset + 10 && currentOffset > 30) {
        if (_showHeader) setState(() => _showHeader = false);
      } else if (currentOffset < _lastScrollOffset - 10 ||
          currentOffset <= 30) {
        if (!_showHeader) setState(() => _showHeader = true);
      }
      _lastScrollOffset = currentOffset;

      // Добавляем проверку при достижении верха списка
      if (_scrollController.offset <= 0 && !_showHeader) {
        setState(() => _showHeader = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.dispose(); // Не забываем освободить ресурсы
    _searchController.dispose();
    super.dispose();
  }

  void _searchDoctor(value) {
    setState(() {
      _search = value;
    });
  }

  List<DoctorListModel> get _filteredDoctors {
    return _doctors
        .where(
          (element) =>
              element.name.toLowerCase().contains(_search.trim().toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Анимированный заголовок
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: _showHeader ? 45 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _showHeader ? 1 : 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: _searchController,
                            onChanged: _searchDoctor,
                            style: theme.textTheme.bodyMedium,
                            decoration: InputDecoration(
                              prefixIcon: _search.isEmpty
                                  ? Icon(Icons.search, size: 20)
                                  : GestureDetector(
                                      onTap: () {
                                        _searchController.clear();
                                        _searchDoctor("");
                                      },
                                      child: Icon(Icons.close, size: 20),
                                    ),
                              hintText: "Поиск докторов",
                              hintStyle: theme.inputDecorationTheme.hintStyle
                                  ?.copyWith(
                                    color: theme.colorScheme.secondary,
                                  ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.go("/doctors_list/profile");
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Theme.of(context).cardColor,
                            child: Image(
                              image: AssetImage(
                                "assets/images/profile_icon.png",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(height: _showHeader ? 10 : 0),
                ),

                // Список пациентов
                Expanded(
                  child: FutureBuilder(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _doctors = snapshot.data!;

                        List filtered = _filteredDoctors;

                        if (filtered.isEmpty) {
                          return Center(
                            child: Text(
                              "Нет врачей",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            DoctorListModel d = filtered[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: DoctorListTileWidget(doctor: d),
                            );
                          },
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: MyFloatingButton(
          onPressed: () {
            context.go("/doctors_list/add_doctor");
          },
        ),
      ),
    );
  }
}
