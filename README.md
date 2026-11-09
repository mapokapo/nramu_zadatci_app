# NRAMU Zadatci App

## Vjezba 4

Ime i prezime: Leo Petrovic

OS: Ubuntu 24.04 LTS

Verzija Fluttera: 3.47.7

Verzija Darta: 3.13.5

Koristeni uredjaji: Android mobitel i Google Chrome

Provedene izmjene:

Problemi: nije instaliran devtools za Flutter Linux (nije potrebno)

### Provjera razumijevanja 1

Pitanje: navedite tri stvari koje u vježbi 3 rade ekranu ne pripadaju (po obrascu MVVM) i u koji bi sloj ih premjestili.

Ucitavanje podataka (4 stanja: ucitavanje, uspjeh, greska, prazna lista), dodavanje podataka (rucno generirati novi ID, dodati u listu, itd.), rucna validacija.

---

Pitanje: što bi se dogodilo kad bi StatistikaEkran u svom initState stvorio novi ZadatciViewModel(ZadatakRepozitorij())?

StatistikaEkran bi onda koristio svoj vlastiti izvor podataka koji nema veze sa ViewModelom koji se koristi u main.dart. Kada bi usli u StatistikaEkran, uvijek bi vidjeli "Ukupno: 0, Zavrseno: 0, Preostalo: 0" jer je lista podataka prazna po zadanom (mora se rucno pozvati metoda `ucitaj` u VM-u) i nijedan dio koda ne modificira tu listu (bilo kroz VM ili ne) pa ostane prazna.

### Pitanja i odgovori
