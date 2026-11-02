# NRAMU Zadatci App

## Vjezba 3

Ime i prezime: Leo Petrovic

OS: Ubuntu 24.04 LTS

Verzija Fluttera: 3.47.7

Verzija Darta: 3.13.5

Koristeni uredjaji: Android mobitel i Google Chrome

Provedene izmjene: dodan FAB i tema, dodan FormaEkran, dodano dugme "Odbaci", dodan brojac zadataka u main.dart AppBaru, dodano jos validatora za FormaEkran.

Problemi: nije instaliran devtools za Flutter Linux (nije potrebno)

### Pitanja i odgovori

Pitanje: Zašto je bolje zadati boju u temi nego na svakom widgetu?

Vise razloga: mozemo primijeniti temu na cijelu aplikaciju umjesto da svaki widget postavljamo jedan po jedan, imamo jedan izvor za sve boje i tematske modifikacije u aplikaciji (ne moramo tragati svaki izmjenu u svakom widgetu), i widgeti se nativno znaju prilagoditi podatcima iz Flutter ThemeData widgeta sto znaci da ne moramo svako tematsko svojstvo rucno mijenjati.

---

Pitanje: Dodajte gumb Odustani u formu koji zatvara zaslon bez rezultata. Što tada vraća Navigator.push?

Navigator.push vraca drugi argument koji je proslijedjen metodi Navigator.pop. U slucaju kada pritisnemo dugme "Odustani", drugi argument ne proslijedjujemo, pa je on `null`. Zbog toga ce rezultat Navigator.push biti takodjer `null`.

---

Pitanje: objasnite što radi validate() i zašto validator vraća null za ispravan unos.

Metoda `validate` se poziva na kljucu forme i ona validira sve ulazne widgete trenutne Forme. To se radi tako sto prolazi kroz listu djece od trenutnog Form widgeta, i za svako dijete koje je tipa FormField, poziva njegovu `validator` metodu. Ta metoda vraca tekst koji opisuje gresku koja se nalazi u ulazu tog polja, no ako nema greske onda ta metoda vraca `null`. Ako svi FormField elementi od Form roditelja vrate `null` iz njihove `validator` metode, onda metoda `validate` vraca `true`.

---

Pitanje: objasnite zašto se nakon await Navigator.push provjerava mounted.

`mounted` je ugradjena vrijednost svakog Flutter widgeta koja nam govori je li widget trenutno ucitan u memoriju (true) ili izbrisan (false). U nekim slucajevima izostatak provjere ove varijable nakon asinhronih operacija moze srusiti aplikaciju. Na primjer ako se nalazimo na ekranu B i onda udjemo u ekran C, na kojem se nalazi dugme "Vrati se na pocetni ekran" (odnosno ekran A), onda ce Flutter direktno prebaciti kontrolu na ekran A, a ekran B ce se izbrisati. Ako smo u ekranu B cekali neki async rezultat od ekrana C (npr. putem `await Navigator.push`), onda smo u situaciji gdje je trenutni widget (ekran B) unmounted te njegov `BuildContext` vise nije validan, sto znaci da ne smijemo pozivati metode poput setState. Ako ekran B ipak mora pozvati setState radi svoje funkcionalnosti, onda moramo provjeriti je li `mounted` true prije nastavka, odnosno `return`-ati iz trenutne funkcije ako je `mounted` false.
