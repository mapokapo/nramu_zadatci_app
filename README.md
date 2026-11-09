# NRAMU Zadatci App

## Vjezba 4

Ime i prezime: Leo Petrovic

OS: Ubuntu 24.04 LTS

Verzija Fluttera: 3.47.7

Verzija Darta: 3.13.5

Koristeni uredjaji: Android mobitel i Google Chrome

Provedene izmjene: dodan ViewModel za zadatke, iskoristen ZadatciViewModel u main.dart i StatistikaEkran, dodani Flutter testovi za ZadatciViewModel, dodana `ukloni` metoda, dodana polja `samoNezavrseni` i `prikazani` u ZadatciViewModel.

Problemi: nije instaliran devtools za Flutter Linux (nije potrebno)

### Pitanja i odgovori

Pitanje: navedite tri stvari koje u vježbi 3 rade ekranu ne pripadaju (po obrascu MVVM) i u koji bi sloj ih premjestili.

Ucitavanje podataka (4 stanja: ucitavanje, uspjeh, greska, prazna lista), dodavanje podataka (rucno generirati novi ID, dodati u listu, itd.), rucna validacija.

---

Pitanje: što bi se dogodilo kad bi StatistikaEkran u svom initState stvorio novi ZadatciViewModel(ZadatakRepozitorij())?

StatistikaEkran bi onda koristio svoj vlastiti izvor podataka koji nema veze sa ViewModelom koji se koristi u main.dart. Kada bi usli u StatistikaEkran, uvijek bi vidjeli "Ukupno: 0, Zavrseno: 0, Preostalo: 0" jer je lista podataka prazna po zadanom (mora se rucno pozvati metoda `ucitaj` u VM-u) i nijedan dio koda ne modificira tu listu (bilo kroz VM ili ne) pa ostane prazna.

---

Pitanje: zašto ViewModel izlaže UnmodifiableListView, a ne običnu listu? Navedite što bi moglo poći po zlu.

Zato sto obicnu listu moze bilo tko modificirati, ukljucujuci ekran. To moze omoguciti neke banalne greske koje je ipak tesko za uociti, npr. slucajno modificiranje liste u ekranu sto moze poremetiti stanje ViewModela. Ako koristimo UnmodifiableListView, onda ce direktna modifikacija te liste odmah baciti gresku, pa cemo je lakse uociti.

---

Pitanje: što se dogodi s osvježavanjem ekrana ako u metodi promijeniZavrsen izostavite notifyListeners()? Isprobajte i opišite što ste vidjeli.

Ako uklonimo `notifyListeners()`, onda nakon sto kliknemo na CheckboxListTile widget, nista se ne dogodi (prije ovoga, widget se oznaci kao zavrsen sa kvacicom i tekst postane precrtan, odnosno obrnuto ako je zadatak vec zavrsen i vracamo ga na nezavrseno stanje) - lista ostane kakva jeste. Ako odemo na ekran statistika, ipak vidimo da se stanje promijenilo (broj zavrsenih zadataka se promijenio) iako se to nije pokazalo u glavnom ekranu. Ako pritisnemo dugme za mijenjanje polja `samoNezavrseni`, tek tada ce se lista azurirati sa ispravnim stanjem, zato sto metoda `samoNezavrseniToggle` u sebi poziva `notifyListeners()`.
