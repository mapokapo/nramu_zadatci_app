import 'package:flutter/material.dart';

import 'repozitorij.dart';
import 'zadatak.dart';

void main() => runApp(const ZadatciApp());

class ZadatciApp extends StatelessWidget {
  const ZadatciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zadatci',
      home: ZadatciEkran(),
    );
  }
}

class ZadatciEkran extends StatefulWidget {
  const ZadatciEkran({super.key});

  @override
  State<ZadatciEkran> createState() => _ZadatciEkranState();
}

class _ZadatciEkranState extends State<ZadatciEkran> {
  // Promijenite parametre da isprobate sva stanja:
  // neuspjeha: 1 -> prvi dohvat padne, ponovni pokušaj uspije
  // prazno: true -> poslužitelj vraća prazan popis
  final _repo = ZadatakRepozitorij(neuspjeha: 0, prazno: false);

  late Future<List<Zadatak>> _buduci = _repo.dohvati();

  Future<void> _ponovi() async {
    setState(() {
      _buduci = _repo.dohvati();
    });

    try {
      await _buduci;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zadatci')),
      body: FutureBuilder<List<Zadatak>>(
        future: _buduci,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting &&
              !snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snap.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text('Dogodila se greška prilikom dohvata podataka'),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _ponovi,
                    child: const Text('Pokušaj ponovno'),
                  ),
                ],
              ),
            );
          }

          final zadaci = snap.data ?? [];

          if (zadaci.isEmpty) {
            return RefreshIndicator(
              onRefresh: _ponovi,
              child: ListView(
                children: const [
                  SizedBox(
                    height: 300,
                    child: Center(child: Text('Nema zadataka')),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _ponovi,
                  child: ListView.builder(
                    itemCount: zadaci.length,
                    itemBuilder: (context, i) {
                      final z = zadaci[i];
                      return ListTile(
                        leading: Icon(
                          z.zavrsen
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                        ),
                        title: Text(
                          z.naslov,
                          style: TextStyle(
                            decoration: z.zavrsen
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Zavrsenih zadataka: ${zadaci.where((z) => z.zavrsen).length} od ${zadaci.length}',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
