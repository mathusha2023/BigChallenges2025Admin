import 'package:bc_admin/ui/pages/doctors_list_page.dart';
import 'package:bc_admin/ui/pages/home_page.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: "/doctors_list",
      builder: (context, state) => const DoctorsListPage(),
    ),
  ],
);
