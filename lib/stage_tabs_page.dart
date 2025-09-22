import 'package:flutter/material.dart';
import 'stage_list_page.dart';
import 'waypoint_list_page.dart';
import 'pace_list_page.dart';

class StageTabsPage extends StatelessWidget {
  const StageTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Stages"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Stages"),
              Tab(text: "Waypoints"),
              Tab(text: "Pace Notes"),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            StageListPage(),
            WaypointListPage(),
            PaceListPage(),
          ],
        ),
      ),
    );
  }
}
