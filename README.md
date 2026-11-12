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
