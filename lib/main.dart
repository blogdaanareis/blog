import 'package:flutter/material.dart';

void main() {
  runApp(const EntreLinhasApp());
}

class EntreLinhasApp extends StatelessWidget {
  const EntreLinhasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Entre Linhas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.purple,
      ),
      home: const CamouflageScreen(),
    );
  }
}

/// ======================
/// TELA CAMUFLAGEM (NOTAS)
/// ======================
class CamouflageScreen extends StatelessWidget {
  const CamouflageScreen({super.key});

  void _unlock(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UnlockScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notas Rápidas')),
      body: GestureDetector(
        onLongPress: () => _unlock(context), // gesto secreto
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            ListTile(title: Text('Comprar pão')),
            ListTile(title: Text('Estudar para prova')),
            ListTile(title: Text('Ligar para Maria')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// ======================
/// TELA DESBLOQUEIO
/// ======================
class UnlockScreen extends StatefulWidget {
  const UnlockScreen({super.key});

  @override
  State<UnlockScreen> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends State<UnlockScreen> {
  final controller = TextEditingController();
  final senhaCorreta = '1234';

  void _checkPassword() {
    if (controller.text == senhaCorreta) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pop(context); // volta para camuflagem
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Digite a senha')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: controller,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _checkPassword,
              child: const Text('Confirmar'),
            )
          ],
        ),
      ),
    );
  }
}

/// ======================
/// MENU PRINCIPAL
/// ======================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entre Linhas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const CamouflageScreen()),
                (_) => false,
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
              ),
              onPressed: () => _open(context, const EmergencyScreen()),
              child: const Text('PRECISO DE AJUDA'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _open(context, const DiaryScreen()),
              child: const Text('Registrar ocorrência'),
            ),
            ElevatedButton(
              onPressed: () => _open(context, const InfoScreen()),
              child: const Text('Informações'),
            ),
          ],
        ),
      ),
    );
  }
}

/// ======================
/// EMERGÊNCIA (SIMULADA)
/// ======================
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergência')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Mensagem de ajuda enviada'),
              ),
            );
          },
          child: const Text('ENVIAR ALERTA'),
        ),
      ),
    );
  }
}

/// ======================
/// DIÁRIO
/// ======================
class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: TextField(
          maxLines: 10,
          decoration: const InputDecoration(
            labelText: 'O que aconteceu?',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}

/// ======================
/// INFORMAÇÕES
/// ======================
class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informações')),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Violência doméstica pode ser física ou psicológica'),
            SizedBox(height: 12),
            Text('📞 180 – Central de Atendimento à Mulher'),
            Text('🚓 190 – Emergência'),
          ],
        ),
      ),
    );
  }
}
