# Portal Objetos de Aprendizaje: helm-repo

## How to install this chart

1. **Add Helm Chart Repository:**

    ```bash
    helm repo add poa-repo https://objetos-aprendizaje.github.io/helm-repo/
    ```

2. **Create Namespace (if not exists):**

    ```bash
    kubectl create namespace <namespace-name>
    ```

   Replace `<namespace-name>` with the desired name for the namespace.

3. **Create persistent volumes:**

   You must create persistent volumes and volume claims for persistent data in the installation, there are two required volumes by this application for public and protected data uploads. You can customize the persistent volume claim name by modifying chart values (keys `admin.existingPVClaimPublic` and `admin.existingPVClaimProtected`), the default expected pvc names are:
   `pvc-portable-objetos-aprendizaje-admin-public` and `pvc-portable-objetos-aprendizaje-admin-protected`

   By default this chart is going to deploy a mysql installation aswell (unless disabling with `mysql.enabled` key and configuring `mysql.mysqlHost` and `mysql.mysqlPort` keys) and their default expected pvc name is `mysql.existingPVClaim`.

   There are also some manifest examples under [extra-manifest-examples folder](https://github.com/objetos-aprendizaje/helm-repo/tree/main/extra-manifest-examples) at this chart repository. Note that they are illustrative and using hostpath /tmp folder, so this is not intended to be used for production.


4. **Install Helm Chart:**

    ```bash
    helm install <release-name> portal-objetos-aprendizaje --namespace <namespace-name>
    ```

   - Replace `<release-name>` with the desired name for the release.
   - Replace `<namespace-name>` with the name of the namespace where the release will be installed.

   ---

   It is also possible to customize this chart deployment by using a values.yaml file, check for all possible keys and default values at [./portal-objetos-aprendizaje/values.yaml](https://github.com/objetos-aprendizaje/helm-repo/blob/main/portal-objetos-aprendizaje/values.yaml)

   ```bash
   helm install <release-name> <chart-name> --namespace <namespace-name> -f values.yaml
   ```

   - Replace `<release-name>` with the desired name for the release.
   - Replace `<chart-name>` with the name of the Helm chart to be installed.
   - Replace `<namespace-name>` with the name of the namespace where the release will be installed.
   - Use `-f` flag followed by the path to your values file (e.g., `values.yaml`) to specify the configuration options for the Helm chart.


## Developer guide

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
