import 'package:flutter/material.dart';
import '../../models.dart';
import 'database_service.dart';
import 'average_list_page.dart';
import 'waypoint_list_page.dart';
import 'pace_list_page.dart';

class StageTabsPage extends StatefulWidget {
  const StageTabsPage({super.key});

  @override
  State<StageTabsPage> createState() => _StageTabsPageState();
}

class _StageTabsPageState extends State<StageTabsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Stage> _stages = [];
  Stage? _selectedStage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadStages();
  }

  Future<void> _loadStages() async {
    final stages = await DatabaseService.getStages();
    setState(() {
      _stages = stages;
      if (_stages.isNotEmpty) _selectedStage = _stages.first;
    });
  }

  void _selectStage(Stage stage) {
    setState(() {
      _selectedStage = stage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stages'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Averages'),
            Tab(text: 'Waypoints'),
            Tab(text: 'Pace Notes'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Selector de Stage
          if (_stages.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<Stage>(
                value: _selectedStage,
                items: _stages
                    .map((s) => DropdownMenuItem(
                          value: s,
                          child: Text(s.nom),
                        ))
                    .toList(),
                onChanged: (s) {
                  if (s != null) _selectStage(s);
                },
              ),
            ),
          Expanded(
            child: _selectedStage == null
                ? const Center(child: Text('No hay stages disponibles'))
                : TabBarView(
                    controller: _tabController,
                    children: [
                      AverageListPage(stage: _selectedStage!),
                      WaypointListPage(stage: _selectedStage!),
                      PaceListPage(stage: _selectedStage!),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Aquí podrías abrir un diálogo para añadir un nuevo Stage
          // o un nuevo elemento según la pestaña activa.
        },
      ),
    );
  }
}
