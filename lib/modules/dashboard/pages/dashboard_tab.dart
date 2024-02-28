import 'package:kapil_add_to_app_flutter/constants/spacing_constants.dart';
import 'package:kapil_add_to_app_flutter/injection_container.dart';
import 'package:kapil_add_to_app_flutter/modules/dashboard/blocs/dashboard_bloc.dart';
import 'package:kapil_add_to_app_flutter/modules/leads/pages/leads_listing_page.dart';
import 'package:kapil_add_to_app_flutter/modules/product/pages/product_listing_page.dart';
import 'package:kapil_add_to_app_flutter/strings/app_strings.dart';
import 'package:kapil_add_to_app_flutter/theme/assets/app_colors.dart';
import 'package:kapil_add_to_app_flutter/theme/text_style_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  late final List<Widget> _bottomNavBarPages = [];
  int _currentIndex = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _bloc = sl.get<DashboardBloc>();

  @override
  void initState() {
    super.initState();
    _bottomNavBarPages.addAll([
      const ProductListingPage(),
      const LeadsListingPage(),
    ]);

    _bloc.setDashboardState();
  }

  void _onNavbarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          //TODO(kaxp): Change the UI for DashboardSdkInitalisationFailed state
          if (state is DashboardSdkInitalisationFailed) {
            return Container(
              child: const Center(
                child: Text('SDK Init Failed'),
              ),
            );
          } else {
            return IndexedStack(
              index: _currentIndex,
              children: _bottomNavBarPages,
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              blurRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onNavbarTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.white,
          elevation: kSpacingMedium,
          selectedLabelStyle: TextStyleFactory.styleNormal10(),
          unselectedLabelStyle: TextStyleFactory.styleNormal10(),
          unselectedItemColor: AppColors.buttonPrimaryDisabledColor,
          backgroundColor: AppColors.black,
          items: [
            BottomNavigationBarItem(
              label: AppStrings.home,
              icon: const Icon(Icons.home_filled),
              activeIcon: const Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
              label: AppStrings.leads,
              icon: const Icon(Icons.message),
              activeIcon: const Icon(Icons.message),
            ),
          ],
        ),
      ),
    );
  }
}
