import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  bool isDonatePageActive = false;

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
      DonatePage(),
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
        return DashboardPage();
      default:
        return DashboardPage();
    }
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    final bool isIndividual = widget.role == 'Individual';

    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          _tabController.index == 0
              ? BottomBarIcons.home_filled
              : BottomBarIcons.home,
          width: 24,
          height: 24,
          color: _tabController.index == 0 ? AppColors.basePrimaryColor : null,
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          _tabController.index == 1
              ? isIndividual
                  ? BottomBarIcons.joined_filled
                  : BottomBarIcons.dashboard_filled
              : isIndividual
                  ? BottomBarIcons.join
                  : BottomBarIcons.dashboard,
          width: 24,
          height: 24,
          color: _tabController.index == 1 ? AppColors.basePrimaryColor : null,
        ),
        label: isIndividual ? "Join" : "Dashboard",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          _tabController.index == 2
              ? BottomBarIcons.donate_filled
              : BottomBarIcons.donate,
          width: 24,
          height: 24,
        ),
        label: "Donate",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          _tabController.index == 3
              ? BottomBarIcons.recycle_filled
              : BottomBarIcons.recycle,
          width: 24,
          height: 24,
          color: _tabController.index == 3 ? AppColors.kGreenColor : null,
        ),
        label: "Recycle",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          _tabController.index == 4
              ? BottomBarIcons.profile_filled
              : BottomBarIcons.profile,
          width: 24,
          height: 24,
          color: _tabController.index == 4 ? AppColors.basePrimaryColor : null,
        ),
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
              selectedItemColor: _tabController.index == 3
                  ? AppColors.kGreenColor
                  : AppColors.basePrimaryColor,
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
