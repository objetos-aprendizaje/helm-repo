# helm-repo

### Install directly lastest version

```bash
helm install po ./portal-objetos-aprendizaje --dry-run > output-test.yaml
helm install po ./portal-objetos-aprendizaje
helm uninstall po
```

### Manually release version

```bash
helm package portal-objetos-aprendizaje -d charts
helm repo index .
```
