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

3. **Create persistent volumes and secrets:**

   You must create persistent volumes and volume claims for persistent data in the installation, there are two required volumes by this application for public and protected data uploads. You can customize the persistent volume claim name by modifying chart values (keys `admin.existingPVClaimPublic` and `admin.existingPVClaimProtected`), the default expected pvc names are:
   `pvc-portable-objetos-aprendizaje-admin-public` and `pvc-portable-objetos-aprendizaje-admin-protected`

   By default this chart is going to deploy a postgresql installation aswell (unless disabling with `postgresql.enabled` key and configuring `postgresql.postgresqlHost` and `postgresql.postgresqlPort` keys) and their default expected pvc name is `postgresql.existingPVClaim`. In case that do you use an external postgresql instance, it is required that [pg_vector](https://github.com/pgvector/pgvector) extension is enabled.

   There are also some manifest examples under [extra-manifest-examples folder](https://github.com/objetos-aprendizaje/helm-repo/tree/main/extra-manifest-examples) at this chart repository. Note that they are illustrative and using hostpath /tmp folder, so this is not intended to be used for production.

   For app secrets it is configured in the same way, the system will require the secrets `poa-postgresql-secret`, `poa-admin-appkey-secret` and `poa-web-appkey-secret` (unless changed names on values.yml). There are also [one manifest example](https://github.com/objetos-aprendizaje/helm-repo/tree/main/extra-manifest-examples/required-secrets.yaml) under extra-manifest-examples folder.

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

5. **Access to the platform**

   If everything goes well you should be able to login using the default admin user: `admin@admin.com` with password `12345678`.

   In case that do you want to load demo data into the platform you should start a exec session on portal-objetos-aprendizaje-admin pod and execute `php artisan db:seed`.

## Using FMNT client certificates

In order to use FMNT client certificates for authentication you need to setup a ingress route with higher priority for path `/certificate-access` that requests client certificate on SSL connection and redirect to service `{{ include "portal-objetos-aprendizaje.fullname" . }}-admin-service` (check [_helpers.tpl](./portal-objetos-aprendizaje/templates/_helpers.tpl) file to see how portal-objetos-aprendizaje.fullname is generated).

This request should include a header with client certificate pem content (without begin/end tags nor line breaks), by default the header used is called `X-Forwarded-Tls-Client-Cert` but it can be changed by configuring value `admin.fmntCertHeader`.

There are some manifests examples using traefik in k8s cluster as the edge inbound load balancer to configure client certificate authentication and header pem binding to backend using `X-Forwarded-Tls-Client-Cert` header in the [fmnt-traefik-ingress.yaml](./extra-manifest-examples/fmnt-traefik-ingress.yaml) example file.

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
