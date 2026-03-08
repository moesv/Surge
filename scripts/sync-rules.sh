#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

# 目标文件 -> 上游 URL
# Blackmatrix7 (Surge)
declare -A SOURCES=(
  ["rules/Surge/OpenAI.list"]="https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/OpenAI/OpenAI.list"
  ["rules/Surge/YouTube.list"]="https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/YouTube/YouTube.list"
  ["rules/Surge/PayPal.list"]="https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/PayPal/PayPal.list"
  ["rules/Surge/Gemini.list"]="https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Gemini/Gemini.list"
  ["rules/Surge/Claude.list"]="https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Claude/Claude.list"
  ["rules/Surge/Google.list"]="https://raw.githubusercontent.com/blackmatrix7/ios_rule_script/master/rule/Surge/Google/Google.list"

  # SukkaW (Surge Source)
  ["rules/Surge/apple_cdn.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/non_ip/apple_services.conf"
  ["rules/Surge/apple_cn.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/non_ip/apple_cn.conf"
  ["rules/Surge/cdn_non_ip.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/non_ip/cdn.conf"
  ["rules/Surge/domainset_cdn.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/domainset/cdn.conf"
  ["rules/Surge/domainset_speedtest.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/domainset/speedtest.conf"
  ["rules/Surge/domestic.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/non_ip/domestic.conf"
  ["rules/Surge/microsoft_cdn.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/non_ip/microsoft.conf"
  ["rules/Surge/reject-drop.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/non_ip/reject-drop.conf"
  ["rules/Surge/reject-no-drop.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/non_ip/reject-no-drop.conf"
  ["rules/Surge/telegram_non_ip.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/non_ip/telegram.conf"
  ["rules/Surge/telegram_ip.list"]="https://raw.githubusercontent.com/SukkaW/Surge/master/Source/ip/telegram_asn.conf"
)

for target in "${!SOURCES[@]}"; do
  url="${SOURCES[$target]}"
  echo "[SYNC] $target"
  mkdir -p "$(dirname "$target")"
  curl -fsSL "$url" -o "$target"
done

git add rules/Surge/*.list
if git diff --cached --quiet; then
  echo "[INFO] No changes, skip commit."
  exit 0
fi

git commit -m "chore: sync Surge rules from upstream"
git push

echo "[DONE] synced + pushed"
