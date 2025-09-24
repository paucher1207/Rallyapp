import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';

import 'controllers/settings_controller.dart';
import 'home_page.dart';
import 'stage_tabs_page.dart';
import 'pages/settings/settings_menu_page.dart';
import 'database_service.dart'; // DatabaseService para inicializar Isar

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa SettingsController y carga ajustes
  final settingsController = SettingsController();
  await settingsController.loadSettings();

  // Inicializa Isar mediante DatabaseService
  await DatabaseService.init();

  // Crear stages iniciales si no hay ninguno
  final stagesCount = await DatabaseService.getStagesWithExtras();
  if (stagesCount.isEmpty) {
    await DatabaseService.createStage(
      Stage()
        ..nom = "Stage 1"
        ..distancia = 12000
        ..horaSortida = DateTime.now(),
    );
    await DatabaseService.createStage(
      Stage()
        ..nom = "Stage 2"
        ..distancia = 15000
        ..horaSortida = DateTime.now().add(const Duration(hours: 1)),
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settingsController),
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
    final List<Widget> _pages = [
      const HomePage(),
      StageTabsPage(), // ahora no pasamos Isar, DatabaseService lo maneja
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
