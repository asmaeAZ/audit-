# Audit de sécurité IoT : dataset IoT-23 (SMARTFACTORY)

Projet du module Audit de Sécurité (5e année, Cybersécurité, Infrastructure et Réseaux).

## Objectif
Distinguer le trafic IoT légitime du trafic malveillant (botnets, scans, C2) et
proposer une architecture de supervision pour la SMARTFACTORY.

## Structure
| Dossier | Contenu |
|---|---|
| `data/` | Dataset IoT-23 (non versionné) |
| `notebooks/` | Analyse exploratoire et ML (Jupyter) |
| `scripts/` | Scripts d'installation et de traitement |
| `suricata/rules/` | Règles de détection |
| `dashboards/` | Exports des tableaux de bord |
| `report/` | Sources du rapport |
| `docs/` | Notes, versions des outils, schémas |

## Environnement
- Ubuntu Server 26.04 LTS (VM)
- Suricata 8.0.x (PPA OISF), tshark, tcpdump
- Zeek exécuté via Docker (image officielle `zeek/zeek`), car aucun paquet natif
  n'est disponible pour Ubuntu 26.04
- Python 3.14 (pandas, scikit-learn, scapy)

## Installation

    git clone git@github.com:elmameriiliass/iot23-audit.git
    cd iot23-audit
    python3 -m venv ~/venv && source ~/venv/bin/activate
    pip install -r requirements.txt
    bash scripts/check_env.sh

## Données
Les PCAP et les `conn.log.labeled` ne sont pas versionnés (voir `.gitignore`).
Chaque membre les télécharge dans `data/` depuis la page officielle d'IoT-23
(Stratosphere Lab). La liste des scénarios retenus est dans `docs/scenarios.md`.

## Règles de collaboration
- Une branche par tâche (`feature/eda`, `feature/suricata-rules`...).
- Intégration via Pull Request relue par l'autre membre.
- Messages de commit explicites.
- Ne jamais pousser de données, de clés ou de mots de passe.
