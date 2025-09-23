import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'controllers/settings_controller.dart';
import 'home_page.dart';
import 'stage_tabs_page.dart';
import 'pages/settings/settings_menu_page.dart';
import 'models.dart'; // tu modelo Stage, Average, RefWaypoint, PaceData

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa SettingsController y carga ajustes
  final settingsController = SettingsController();
  await settingsController.loadSettings();

  // Inicializa Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      StageSchema,
      AverageSchema,
      RefWaypointSchema,
      PaceDataSchema,
    ], // lista de schemas como argumento posicional
    directory: dir.path, // opcional, carpeta local de la app
  );
  final stagesCount = await isar.stages.count();
  if (stagesCount == 0) {
    await isar.writeTxn(() async {
      final stage1 = Stage()
        ..nom = "Stage 1"
        ..distancia = 12000
        ..horaSortida = DateTime.now();

      final stage2 = Stage()
        ..nom = "Stage 2"
        ..distancia = 15000
        ..horaSortida = DateTime.now().add(const Duration(hours: 1));

      await isar.stages.putAll([stage1, stage2]);
    });
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settingsController),
        Provider<Isar>.value(value: isar), // hacemos Isar accesible a toda la app
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsController>(context);

    return MaterialApp(
      title: 'Rally App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: settings.themeMode,
      home: const MainMenuPage(),
    );
  }
}

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isar = Provider.of<Isar>(context); // obtenemos Isar desde Provider

    final List<Widget> _pages = [
      const HomePage(),
      StageTabsPage(isar: isar), // pasamos Isar a StageTabsPage
      const SettingsMenuPage(),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Tramos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
