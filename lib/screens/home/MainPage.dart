import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spoonshare/screens/dashboard/dashboard_home.dart';
import 'package:spoonshare/screens/donate/donate_page.dart';
import 'package:spoonshare/screens/home/home_page.dart';
import 'package:spoonshare/screens/recycle/recycle.dart';
import 'package:spoonshare/screens/profile/user_profile.dart';

class MainPage extends StatefulWidget {
  final String name;
  final String role;

  const MainPage({Key? key, required this.name, required this.role})
      : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          body: TabBarView(
              controller: _tabController,
              children: [
                HomePage(name: widget.name, role: widget.role),
                DashboardHomePage(role: widget.role),
                const DonatePage(),
                const RecycleScreen(),
                UserProfileScreen(name: widget.name, role: widget.role),
              ],
            ),
          bottomNavigationBar: Container(
            height: ScreenUtil().setHeight(50),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F3).withOpacity(0.5),
              border: Border.all(color: const Color(0xFFF0F2F3)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setWidth(10)),
                topRight: Radius.circular(ScreenUtil().setWidth(10)),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.black54,
              tabs: [
                _buildNavItem(Icons.home, 'Home'),
                _buildNavItem(Icons.dashboard, 'Dashboard'),
                _buildNavItem(Icons.add_circle, 'Donate Food'),
                _buildNavItem(Icons.recycling, 'Recycle'),
                _buildNavItem(Icons.person, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Tab _buildNavItem(IconData icon, String label) {
    return Tab(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: ScreenUtil().setHeight(26)),
          Text(
            label,
            style: const TextStyle(
              fontSize: 7,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
