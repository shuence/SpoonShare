import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spoonshare/constants/app_constants.dart';
import 'package:spoonshare/screens/admin/admin_home.dart';
import 'package:spoonshare/screens/dashboard/dashboard_page.dart';
import 'package:spoonshare/screens/donate/donate_page.dart';
import 'package:spoonshare/screens/home/home_page.dart';
import 'package:spoonshare/screens/ngo/ngo_home.dart';
import 'package:spoonshare/screens/recycle/recycle.dart';
import 'package:spoonshare/screens/profile/user_profile.dart';
import 'package:spoonshare/screens/volunteer/volunteer_home.dart';
import 'package:spoonshare/widgets/app_exit_dialog.dart';
import 'package:spoonshare/widgets/maps_widget.dart';

import 'bloc/main_bottom_nav_bloc.dart';

class MainBottomNav extends StatefulWidget {
  final String name;
  final String role;

  const MainBottomNav({Key? key, required this.name, required this.role})
      : super(key: key);

  @override
  _MainBottomNavState createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(name: widget.name, role: widget.role),
      navigateToRoleScreen(context),
      const DonatePage(),
      const RecycleScreen(),
      UserProfileScreen(name: widget.name, role: widget.role),
    ];
  }

  Widget navigateToRoleScreen(BuildContext context) {
    switch (widget.role) {
      case 'Volunteer':
        return const VolunteerHomeScreen();
      case 'NGO':
        return const NGOHomeScreen();
      case 'Admin':
        return const AdminHomeScreen();
      case 'Individual':
        return const DashboardPage();
      default:
        return const DashboardPage();
    }
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.home),
        icon: Icon(Icons.home),
        label: "Home",
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.dashboard),
        icon: Icon(Icons.dashboard),
        label: "Dashboard",
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.add_circle),
        icon: Icon(Icons.add_circle),
        label: "Donate",
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.recycling),
        icon: Icon(Icons.recycling),
        label: "Recycle",
      ),
      const BottomNavigationBarItem(
        activeIcon: Icon(Icons.person),
        icon: Icon(Icons.person),
        label: "Profile",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBottomNavBloc, MainBottomNavState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (willPop) async {
            if (willPop) return;
            if (_tabController.index == 0) {
              return await showDialog(
                  context: context,
                  builder: (context) {
                    return ExitConfirmationDialog();
                  });
            } else {
              context.read<MainBottomNavBloc>().add(ChangeTabEvent(index: 0));
              _tabController.index = 0;
            }
            return;
          },
          child: Scaffold(
            body: IndexedStack(
              index: _tabController.index,
              children: _buildScreens(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                context
                    .read<MainBottomNavBloc>()
                    .add(ChangeTabEvent(index: index));
                _tabController.index = index;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: _navBarsItems(),
              selectedItemColor: AppColors.basePrimaryColor,
              currentIndex: _tabController.index,
            ),
            floatingActionButton: _tabController.index == 0
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapsWidget()));
                    },
                    backgroundColor: AppColors.basePrimaryColor,
                    foregroundColor: AppColors.kWhiteColor,
                    child: const Icon(Icons.location_on),
                  )
                : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          ),
        );
      },
    );
  }
}
