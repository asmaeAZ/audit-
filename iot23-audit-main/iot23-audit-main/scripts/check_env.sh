#!/usr/bin/env bash
# Vérifie les outils requis et affiche leurs versions
ok=0; ko=0

check() {            # check "Nom" "binaire" "commande de version..."
  local name="$1" bin="$2"; shift 2
  if command -v "$bin" > /dev/null 2>&1; then
    local out; out=$("$@" 2>&1 | head -n1)
    printf "[OK] %-12s %s\n" "$name" "$out"; ok=$((ok+1))
  else
    printf "[KO] %-12s introuvable\n" "$name"; ko=$((ko+1))
  fi
}

pycheck() {          # pycheck "Nom" "module"
  local out
  if out=$(python3 -c "import $2; print('$2', $2.__version__)" 2>&1); then
    printf "[OK] %-12s %s\n" "$1" "$out"; ok=$((ok+1))
  else
    printf "[KO] %-12s module absent (venv activé ?)\n" "$1"; ko=$((ko+1))
  fi
}

echo "=== Environnement audit IoT-23 ($(date '+%Y-%m-%d %H:%M')) ==="
check "OS"       lsb_release lsb_release -ds
check "Kernel"   uname       uname -r
check "tshark"   tshark      tshark --version
check "tcpdump"  tcpdump     tcpdump --version
check "Suricata" suricata    suricata -V
check "Docker"   docker      docker --version
check "Zeek"     zeek        zeek --version
check "Git"      git         git --version
check "Python"   python3     python3 --version
pycheck "pandas"   pandas
pycheck "sklearn"  sklearn
pycheck "scapy"    scapy
echo "--- Ressources ---"
echo "CPU: $(nproc) | RAM: $(free -h | awk '/Mem:/{print $2}') | Disque libre: $(df -h / | awk 'NR==2{print $4}')"
echo "Résultat : $ok OK, $ko KO"
