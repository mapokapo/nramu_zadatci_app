// ignore_for_file: avoid_print
import 'dart:async';

import 'package:nramu_zadatci_app/repozitorij.dart';

Future<void> main() async {
  final repo = ZadatakRepozitorij(neuspjeha: 1);

  for (var pokusaj = 1; pokusaj <= 2; pokusaj++) {
    try {
      print('Pokušaj $pokusaj: dohvaćam...');

      final zadaci = await repo.dohvati();

      for (final z in zadaci) {
        print('- ${z.naslov} (${z.zavrsen ? 'gotovo' : 'u tijeku'})');
      }

      break;
    } on ZadatciException catch (e) {
      print('Pogreška: ${e.poruka}');
    } finally {
      print('Pokušaj $pokusaj završen');
    }
  }

  print('\nSa Future.wait:');

  final repo2 = ZadatakRepozitorij(neuspjeha: 0);

  final stopwatch = Stopwatch()..start();
  try {
    final zadaciLista = await Future.wait([repo2.dohvati(), repo2.dohvati()]);

    for (final lista in zadaciLista) {
      for (final z in lista) {
        print('- ${z.naslov} (${z.zavrsen ? 'gotovo' : 'u tijeku'})');
      }
    }
  } on ZadatciException catch (e) {
    print('Pogreška: ${e.poruka}');
  }
  print('Proteklo vrijeme: ${stopwatch.elapsed.inMilliseconds}ms');

  print('\nSa timeout:');

  final repo3 = ZadatakRepozitorij(neuspjeha: 0);

  try {
    final zadaci = await repo3.dohvati().timeout(
      const Duration(milliseconds: 300),
    );

    for (final z in zadaci) {
      print('- ${z.naslov} (${z.zavrsen ? 'gotovo' : 'u tijeku'})');
    }
  } on ZadatciException catch (e) {
    print('Pogreška: ${e.poruka}');
  } on TimeoutException catch (e) {
    print('Isteklo vrijeme: ${e.message}');
  }
}
