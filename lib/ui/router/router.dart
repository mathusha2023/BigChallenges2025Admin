import 'package:bc_admin/ui/pages/add_doctor_page.dart';
import 'package:bc_admin/ui/pages/doctor_info_page.dart';
import 'package:bc_admin/ui/pages/doctors_list_page.dart';
import 'package:bc_admin/ui/pages/home_page.dart';
import 'package:bc_admin/ui/pages/profile_page.dart';
import 'package:bc_admin/ui/router/extra_data_model.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      path: "/doctors_list",
      builder: (context, state) => const DoctorsListPage(),
      routes: [
        GoRoute(
          path: "/doctors/:id",
          builder: (context, state) {
            final extraData = state.extra as ExtraDataModel;
            return DoctorInfoPage(doctor: extraData.doctor!);
          },
        ),
        GoRoute(
          path: "/add_doctor",
          builder: (context, state) => const AddDoctorPage(),
        ),
        GoRoute(
          path: "/profile",
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);
