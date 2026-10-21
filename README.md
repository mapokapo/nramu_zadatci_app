# NRAMU Zadatci App

## Vjezba 2

### Pitanja i odgovori

Pitanje: zašto polja modela (Zadatak) nisu promjenjiva i što bi se dogodilo da u JSON-u polje naslov nedostaje?

Polja modela Zadatak nisu promjenjiva jer se koristi prefix `final`. Zbog toga i metoda `kopiraj` vraca novu kopiju modela umjesto da modificira postojecu - modificiranje je nemoguce radi `final`. Da u JSON-u nedostaje polje `naslov` za jedan model Zadatak, onda ce se program zaustaviti sa greskom `Null is not a subtype of String` - procitano polje `naslov` iz JSON-a ne postoji pa primi default-nu vrijednost `null`, no `null` se ne moze dodijeliti polju kojemu je tip `String` (koristimo sintaksu `as String`), pa Dart baci gresku.

---

Pitanje: što se događa kad iznimku iz Futurea ne uhvatimo ni na jednom mjestu?

Ta iznimka onda prolazi kroz cijeli callstack ("bubbles up") sve do pocetka programa (`main` funkcija). Ako ijedna funkcija "iznad" one u kojoj je bacena iznimka ima try-catch blok koji uspjesno uhvati tu iznimku (i ako pretpostavimo da taj blok ne koristi `rethrow`) onda iznimka tu staje, no ako nema nijedne takve funkcije, onda ce iznimka doci do samog pocetka programa (`main` funkcija) gdje se program zavrsava i ispisuje se `Unhandled exception: ...` u konzolu.
