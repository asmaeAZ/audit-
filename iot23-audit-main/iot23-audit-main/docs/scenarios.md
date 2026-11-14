# Scénarios IoT-23 retenus

Source : https://www.stratosphereips.org/datasets-iot23 (Stratosphere Laboratory, Avast-AIC).
Archive utilisée : iot_23_datasets_full.tar.gz (21,5 Go), extraite sélectivement (≈ 3,2 Go, 34 fichiers).
Les données ne sont pas versionnées (voir .gitignore). Empreintes : docs/checksums.txt
(25 fichiers : 15 PCAP + 10 conn.log.labeled).

## Scénarios et effectifs vérifiés

| Scénario | Famille / appareil | Flux | Étiquettes |
|---|---|---|---|
| CTU-Honeypot-Capture-4-1 | Philips HUE (bénin) | 452 | benign 452 |
| CTU-Honeypot-Capture-5-1 | Amazon Echo (bénin) | 1 374 | benign 1 374 |
| CTU-Honeypot-Capture-7-1 | Somfy Doorlock (bénin) | 130 (Somfy-01) | benign 130 |
| CTU-IoT-Malware-Capture-34-1 | Mirai | 23 145 | DDoS 14 394, C&C 6 706, benign 1 923, scan 122 |
| CTU-IoT-Malware-Capture-44-1 | Mirai | 237 | benign 211, C&C 14, C&C-FileDownload 11, DDoS 1 |
| CTU-IoT-Malware-Capture-8-1 | Hakai | 10 403 | C&C 8 222, benign 2 181 |
| CTU-IoT-Malware-Capture-3-1 | Muhstik | 156 103 | scan 145 597, Attack 5 962, benign 4 536, C&C 8 |
| CTU-IoT-Malware-Capture-1-1 | Hide and Seek | 1 008 748 | scan 539 465, benign 469 275, C&C 8 |
| CTU-IoT-Malware-Capture-60-1 | Gafgyt | 3 581 028 | DDoS 3 578 457, benign 2 476, C&C-HeartBeat 95 |
| CTU-IoT-Malware-Capture-20-1 | Torii | 3 209 | benign 3 193, C&C-Torii 16 |

Total : 4 784 829 flux étiquetés (benign 485 751 ; DDoS 3 592 852 ; scan 685 184 ;
C2 15 080 ; Attack 5 962).

## Fichiers PCAP (15 fichiers, ≈ 3,09 millions de paquets, ≈ 2,6 Go)

| Scénario | Fichier | Paquets | Durée | Taille |
|---|---|---|---|---|
| 4-1 | Philips-Hue-Bridge.pcap | 8 573 | 39 min | 2,3 Mo |
| 4-1 | 2018-10-25-14-06-32-192.168.1.132.pcap | 21 664 | 21,9 h | 4,4 Mo |
| 5-1 | 2018-09-21-capture.pcap | 398 312 | 5,5 h | 364 Mo |
| 7-1 | Somfy-01 (first_start_somfy_gateway) | 8 276 | 1,4 h | 2,0 Mo |
| 7-1 | Somfy-02 à 06 (5 PCAP, sans étiquettes) | 544 766 | 12 à 24 h | 143 Mo |
| 3-1 | 2018-05-21_capture.pcap | 496 959 | 36,1 h | 55 Mo |
| 3-1 | test.pcap | 12 202 | 36,1 h | 0,9 Mo |
| 34-1 | 2018-12-21-15-50-14-192.168.1.195.pcap | 233 865 | 24,0 h | 120 Mo |
| 34-1 | ...192.168.1.195.irc.pcap | 36 797 | 23,9 h | 3,6 Mo |
| 44-1 | 2019-01-10-21-06-26-192.168.1.199.pcap | 1 309 350 | 1,9 h | 1 738 Mo |
| 8-1 | 2018-07-31-15-15-09-192.168.100.113.pcap | 23 623 | 24,0 h | 2,0 Mo |

## Hôtes de référence (à confirmer avec Zeek)

| Scénario | Adresse | Source |
|---|---|---|
| 3-1 | 192.168.2.5 (hôte infecté) | README |
| 4-1 | 192.168.1.132 | README et nom du PCAP |
| 34-1 | 192.168.1.195 | nom du PCAP |
| 44-1 | 192.168.1.199 | nom du PCAP |
| 8-1 | 192.168.100.113 | nom du PCAP |
| 7-1 (Somfy) | 192.168.1.158 | nom du PCAP |

Tous ces réseaux sont inclus dans 192.168.0.0/16 (HOME_NET de Suricata).

## Particularités constatées
- Étiquette bénigne écrite `benign` (appareils réels) ou `Benign` (captures infectées) :
  normaliser la casse avant tout traitement.
- 7-1 : seul Somfy-01 a un conn.log.labeled ; Somfy-02 à 06 serviront de test de faux positifs.
- 4-1 : deux PCAP pour un seul conn.log.labeled (le PCAP du 25/10 est le plus probable).
- 3-1 : le PCAP principal couvre la durée du README (19 au 21/05/2018) ; test.pcap est un extrait.
- 34-1 : le fichier *.irc.pcap est un sous-ensemble du PCAP principal.
- 44-1 : 1,3 million de paquets pour 237 flux étiquetés (à examiner avec Zeek).
- Le trafic bénin des appareils réels ne compte que 1 956 flux ; 96,6 % des flux bénins viennent de 1-1.
- Le trafic C2 représente 0,3 % des flux de l'échantillon.

## Reproduire l'extraction (PowerShell, archive dans Téléchargements)

    cd $HOME\Downloads
    mkdir $HOME\iot23_selection
    tar -xzf iot_23_datasets_full.tar.gz -C $HOME\iot23_selection `
      "*CTU-Honeypot-Capture-4-1/*" "*CTU-Honeypot-Capture-5-1/*" "*CTU-Honeypot-Capture-7-1/*" `
      "*CTU-IoT-Malware-Capture-34-1/*" "*CTU-IoT-Malware-Capture-44-1/*" `
      "*CTU-IoT-Malware-Capture-8-1/*" "*CTU-IoT-Malware-Capture-3-1/*" `
      "*CTU-IoT-Malware-Capture-1-1/README.md" "*CTU-IoT-Malware-Capture-1-1/bro/conn.log.labeled" `
      "*CTU-IoT-Malware-Capture-60-1/README.md" "*CTU-IoT-Malware-Capture-60-1/bro/conn.log.labeled" `
      "*CTU-IoT-Malware-Capture-20-1/README.md" "*CTU-IoT-Malware-Capture-20-1/bro/conn.log.labeled"
    scp -r "$HOME\iot23_selection\*" <utilisateur>@<IP_VM>:~/iot23-audit/data/

Sur la VM, remonter les dossiers à la racine de data/ :

    cd ~/iot23-audit/data
    for d in $(find . -mindepth 2 -type d -name 'CTU-*' -prune); do mv "$d" . ; done
    find . -type d -empty -delete

Contrôle : comparer docs/checksums.txt entre les deux membres du binôme.
