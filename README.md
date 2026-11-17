# NRAMU Zadatci App

## Vjezba 5

Ime i prezime: Leo Petrovic

OS: Ubuntu 24.04 LTS

Koristeni oblika Oracle instance: Always Free Ampere A1 Flex (2 OCPU, 12 GB RAM, 200 GB block storage), Ubuntu Linux 22.04 LTS

Verzija Supabase: 17.6

Verzija Fluttera: 3.47.7

Verzija Darta: 3.13.5

Koristeni uredjaji: Android mobitel i Google Chrome

Provedene izmjene: aplikacija spojena na Supabase, implementirane metode za dohvat, dodavanje, brisanje i promjenu zadataka, dodana mogucnost promjene naslova zadatka.

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

---

Pitanje: što bi aplikacija prikazala da u skripti nema politike "anon cita", i zašto nema poruke o pogrešci?

Ako u skripti nema politike "anon cita", aplikacija bi prikazala praznu listu ili ne bi prikazala nikakve podatke jer bi zahtjev za dohvat podataka bio odbijen zbog nedostatka autorizacije. Supabase RLS ne radi jednostavnu autorizaciju, nego filtrira redove u tablici na koju korisnik cilja i vraca samo one redove koji zadovoljavaju uvjete definirane u politici. Ako ne postoji politika koja dozvoljava anonimni pristup, korisnik nece dobiti nikakve podatke, ali nece biti prikazana poruka o pogresci jer je zahtjev tehnicki uspješan (HTTP status 200), ali rezultat je prazan zbog RLS pravila.

---

Pitanje: zašto ViewModel mijenja lokalni popis tek nakon što izvor uspije, a ne prije? Što bi korisnik vidio da je obrnuto, a veza padne?

Ako bi ViewModel mijenjao lokalni popis prije nego sto izvor uspije, korisnik bi vidio promjene u sucelju koje nisu zapravo potvrdjene od strane izvora podataka. Ako veza padne ili dodje do pogreske prilikom komunikacije s izvorom, korisnik bi mogao vidjeti netocne ili nepotvrdjene podatke, sto bi moglo dovesti do konfuzije i gubitka povjerenja u aplikaciju. Stoga je bolje da se lokalni popis mijenja tek nakon sto izvor uspije, kako bi se osigurala konzistentnost i tocnost prikazanih podataka. Postoje slucajevi kada se lokalni popis promijeni odmah (optimistic update), ali to zahtijeva dodatnu logiku za rollback u slucaju pogreske.

---

Pitanje: zašto se u aplikaciju stavlja publishable, a ne secret ključ, i što bi se dogodilo kad bi secret ključ završio u repozitoriju?

Publishable kljuc od Supabase-a se koristi unutar javnih klijentskih aplikacija (kao sto je Flutter aplikacija) jer je namijenjen za javnu upotrebu i ne sadrzi osjetljive informacije. Sa Supabase strane taj kljuc ima "anon" rolu koji po zadanom nema nikakav pristup podatcima osim onih koje mi eksplicitno navedemo, stoga je siguran za koristenje u ovakvim slucajevima. Secret kljuc je namijenjen za server-side aplikacije (nisu izlozene korisnicima) i on se mapira u rolu "service_role" sa Supabase strane, koja potpuno zaobilazi sva sigurnosna pravila i daje potpun pristup svim podatcima i funkcijama, stoga nije primjeren za koristenje u javnim aplikacijama. Ako bi secret kljuc zavrsio u repozitoriju, bilo tko tko ima pristup repozitoriju bi mogao koristiti taj kljuc za pristup svim podatcima i funkcijama Supabase instance, sto bi predstavljalo ozbiljan sigurnosni rizik.
