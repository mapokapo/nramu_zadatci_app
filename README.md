# NRAMU Zadatci App

## Vjezba 4

Ime i prezime: Leo Petrovic

OS: Ubuntu 24.04 LTS

Verzija Fluttera: 3.47.7

Verzija Darta: 3.13.5

Koristeni uredjaji: Android mobitel i Google Chrome

Provedene izmjene:

Problemi: nije instaliran devtools za Flutter Linux (nije potrebno)

### Pitanja i odgovori

Pitanje: što je Always Free instanca i zašto za Supabase ne smijete odabrati Micro shape?

Always Free instanca je besplatna konfiguracija virtualnog stroja koju pruza Oracle Cloud Infrastructure. Postoji nekoliko razlicitih konfiguracija koje spadaju u Always Free kategoriju, i te instance ne zahtijevaju kreditnu karticu i ne trose nikakve kredite. Primjeri tih instanci su Ampere A1 Flex (ARM) i E2 Micro (AMD). Razlog zasto se ne moze koristiti E2 Micro konfiguracija za Supabase je jer Supabase zahtjeva 4GB RAM-a za rad po dokumentaciji dok ova konfiguracija pruza samo 1GB RAM-a.

---

Pitanje: objasnite razliku između Docker slike (image) i kontejnera te zašto se podaci baze moraju držati u volumenu.

Docker slika/image je sablon kojeg Docker koristi da bi instancirao kontejner odnosno virtualni stroj koji radi kao proces na trenutnom racunalu. Kontejner je instanca slike koja aktivno obradjuje neke procese i moze komunicirati sa vanjskim svijetom (posluziteljem) putem mreze i sustava podataka. Analogija za ovo je Java/OOP: Docker slika je klasa (sablon, ne radi nista sama po sebi) a Docker kontejner je instanca klase odnosno objekt (zivi u memoriji, aktivan, ima zivotni tok koji traje od stvaranja do unistenja objekta). Posto su kontejneri "ephemeral" (kratkotrajni, brisu se svi podatci i ponovno rekreiraju kada zaustavimo i ponovno pokrenemo kontejner), ne mozemo njegov interni sustav podataka koristiti za skladistenje baze podataka. Podatke zbog toga moramo drzati u posluzitelju (stvarnom stroju koji pokrece Docker kontejnere) putem Docker volumena. Volumen je nacin da Docker kontejner pohranjuje podatke na posluziteljskom stroju, i na taj nacin podatci ostanu sacuvani cak i nakon restarta kontejnera.

---

Pitanje: što rade servisi Postgres, REST (PostgREST), Auth, Storage i Studio te što je gateway na portu 8000.

Servis Postgres je baza podataka koja se koristi za pohranu i upravljanje podacima. REST (PostgREST) je servis koji omogucuje pristup bazi podataka putem REST API-ja, sto omogucuje aplikacijama da komuniciraju s bazom podataka koristeci HTTP zahtjeve. Auth servis je odgovoran za autentifikaciju i autorizaciju korisnika, omogucujuci siguran pristup aplikaciji i njenim resursima. Storage servis omogucuje pohranu i upravljanje datotekama, dok Studio servis pruza graficko sucelje za upravljanje bazom podataka i drugim resursima.
