export PROJECT_ID=fpt-dev

gcloud iam workload-identity-pools create "github" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="GitHub Actions Pool"

  # TODO: replace ${PROJECT_ID} with your value below.

gcloud iam workload-identity-pools describe "github" --location="global" --format="value(name)"

projects/871426567684/locations/global/workloadIdentityPools/github

# TODO: replace ${PROJECT_ID} and ${GITHUB_ORG} with your values below.

gcloud iam workload-identity-pools providers create-oidc "my-repo" --location="global" --workload-identity-pool="github" --display-name="My GitHub repo Provider" --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository,attribute.repository_owner=assertion.repository_owner" --attribute-condition="assertion.repository_owner == 'hlengoc'" --issuer-uri="https://token.actions.githubusercontent.com"

# TODO: replace ${PROJECT_ID} with your value below.

gcloud iam workload-identity-pools providers describe "my-repo" --location="global" --workload-identity-pool="github" --format="value(name)"

projects/871426567684/locations/global/workloadIdentityPools/github/providers/my-repo

principalSet://iam.googleapis.com/projects/871426567684/locations/global/workloadIdentityPools/github/attribute.repository/hlengoc/argocd-app

set HTTP_PROXY=http://10.148.15.253:443
set HTTPS_PROXY=http://10.148.15.253:443
set NO_PROXY=localhost,127.0.0.1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,.svc,.cluster.local

proxy-url: http://10.148.15.253:443 

argocd app create frontend --repo https://github.com/hlengoc/argocd-infra.git --path manifests --dest-server https://kubernetes.default.svc --dest-namespace app


# Get user's home directory
$homeDir = [Environment]::GetFolderPath("UserProfile")
$npmrcPath = Join-Path $homeDir ".npmrc"

# Proxy configuration to add
$proxyConfig = @"
proxy=http://10.148.15.253:443
"@

# Write to .npmrc (overwrite or create)
Set-Content -Path $npmrcPath -Value $proxyConfig -Encoding UTF8