import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/admin_login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/ranking/presentation/pages/ranking_page.dart';
import '../../features/locations/presentation/pages/locations_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard_page.dart';
import '../../features/points/presentation/pages/points_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/admin-login',
        builder: (context, state) => const AdminLoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/ranking',
        builder: (context, state) => const RankingPage(),
      ),
      GoRoute(
        path: '/locations',
        builder: (context, state) => const LocationsPage(),
      ),
      GoRoute(
        path: '/admin-dashboard',
        builder: (context, state) => const AdminDashboardPage(),
      ),
      GoRoute(
        path: '/points',
        builder: (context, state) => const PointsPage(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryPage(),
      ),
      // Placeholder para rotas que ainda serão implementadas
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/pay',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Pagamento'))),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
});
