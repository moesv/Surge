# Surge

## 自动/手动同步规则

手动同步：
```bash
bash scripts/sync-rules.sh
```

自动同步：
- GitHub Actions `Sync Surge Rules` 每天运行
- 仅在规则有变化时才 commit
