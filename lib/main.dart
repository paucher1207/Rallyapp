import 'package:flutter/material.dart';
import 'stage_list_page.dart';

void main() {
  runApp(const RallyApp());
}

class RallyApp extends StatelessWidget {
  const RallyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rally App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
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
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const StageListPage(),
    // Para Waypoints y Pace necesitamos un Stage seleccionado
    const Placeholder(), // placeholder temporal para Waypoints
    const Placeholder(), // placeholder temporal para Pace Notes
  ];

  final List<String> _titles = [
    "Stages",
    "Waypoints",
    "Pace Notes",
  ];

  void _onSelectPage(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context); // cerrar el drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text(
                "Menú Rally",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.terrain),
              title: const Text("Stages"),
              onTap: () => _onSelectPage(0),
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text("Waypoints"),
              onTap: () => _onSelectPage(1),
            ),
            ListTile(
              leading: const Icon(Icons.notes),
              title: const Text("Pace Notes"),
              onTap: () => _onSelectPage(2),
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
