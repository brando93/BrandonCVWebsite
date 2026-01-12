# Professional CV Website - Infrastructure & CI/CD

Static website hosted on AWS S3 with automated CI/CD pipeline using GitHub Actions and Infrastructure as Code with Terraform.

## 🏗️ Infrastructure

### AWS Resources (Terraform)

- **2 S3 Buckets**: DEV and PROD environments
- **S3 Website Hosting**: Static website configuration
- **S3 Versioning**: Enabled for backup and rollback
- **Public Access**: Configured with bucket policies
- **Region**: us-east-1

### Terraform Structure

```
terraform/
├── main.tf           # Provider and backend configuration
├── variables.tf      # Input variables
├── s3-buckets.tf     # S3 bucket resources
└── outputs.tf        # Output values (URLs, bucket names)
```

## 🚀 CI/CD Pipeline (GitHub Actions)

### Workflows

#### 1. DEV Deployment (`deploy-dev.yml`)
- **Trigger**: Push to any branch except `master`
- **Purpose**: Test changes before production
- **Steps**:
  1. Checkout code
  2. Setup Node.js 18
  3. Install dependencies (`npm ci`)
  4. Build website (`npm run build`)
  5. Configure AWS credentials
  6. Sync to S3 DEV bucket
  7. Display deployment URL

#### 2. PROD Deployment (`deploy-prod.yml`)
- **Trigger**: Push to `master` branch
- **Purpose**: Deploy to production
- **Steps**:
  1. Checkout code
  2. Setup Node.js 18
  3. Install dependencies (`npm ci`)
  4. Build website (`npm run build`)
  5. Configure AWS credentials
  6. Sync to S3 PROD bucket
  7. Display deployment URL

### GitHub Secrets Required

```
AWS_ACCESS_KEY_ID       # IAM user access key
AWS_SECRET_ACCESS_KEY   # IAM user secret key
```

## 📦 Deployment Flow

```
┌─────────────────────────────────────────────────────────┐
│  Developer                                              │
│  ├── Create feature branch                             │
│  ├── Make changes                                       │
│  └── Push to GitHub                                     │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│  GitHub Actions (DEV Workflow)                          │
│  ├── Build website                                      │
│  ├── Deploy to S3 DEV                                   │
│  └── URL: bran-website-dev.s3-website-us-east-1...     │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│  Review & Test                                          │
│  └── Verify changes in DEV environment                 │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│  Merge to Master                                        │
│  └── Create PR and merge                               │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│  GitHub Actions (PROD Workflow)                         │
│  ├── Build website                                      │
│  ├── Deploy to S3 PROD                                  │
│  └── URL: bran-website-prod.s3-website-us-east-1...    │
└─────────────────────────────────────────────────────────┘
```

## 🛠️ Setup Instructions

### 1. Infrastructure Deployment

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 2. Configure GitHub Secrets

1. Go to repository Settings → Secrets and variables → Actions
2. Add `AWS_ACCESS_KEY_ID`
3. Add `AWS_SECRET_ACCESS_KEY`

### 3. Deploy Website

#### Deploy to DEV (Testing)
```bash
# 1. Create a feature branch
git checkout -b feature/my-changes

# 2. Make your changes and commit
git add .
git commit -m "My changes"

# 3. Push to GitHub (triggers DEV deployment automatically)
git push origin feature/my-changes
```

**GitHub Actions will automatically:**
- Build the website
- Deploy to DEV environment
- Provide the DEV URL in the workflow output

**DEV URL:** http://bran-website-dev.s3-website-us-east-1.amazonaws.com

#### Deploy to PROD (After testing in DEV)
```bash
# 1. Switch to master branch
git checkout master

# 2. Merge your tested feature branch
git merge feature/my-changes

# 3. Push to master (triggers PROD deployment automatically)
git push origin master
```

**GitHub Actions will automatically:**
- Build the website
- Deploy to PROD environment
- Your changes are now live!

**PROD URL:** http://bran-website-prod.s3-website-us-east-1.amazonaws.com

#### Workflow Summary
```
Feature Branch → Push → DEV Deploy (Test) → Merge to Master → PROD Deploy (Live)
```

## 🌐 Environments

| Environment | URL | Purpose |
|-------------|-----|---------|
| DEV | http://bran-website-dev.s3-website-us-east-1.amazonaws.com | Testing |
| PROD | http://bran-website-prod.s3-website-us-east-1.amazonaws.com | Production |

## 📊 Tech Stack

### Infrastructure
- **Terraform** - Infrastructure as Code
- **AWS S3** - Static website hosting
- **AWS IAM** - Access management

### CI/CD
- **GitHub Actions** - Automated deployments
- **GitHub** - Version control and collaboration

### Build Tools
- **Node.js 18** - Build environment
- **npm** - Package management
- **Pug** - HTML templating
- **SCSS** - CSS preprocessing

## 🔒 Security

- S3 versioning enabled for rollback capability
- IAM user with minimal required permissions
- Secrets stored in GitHub encrypted secrets
- Public read-only access to website content

## 📝 Maintenance

### Update Website Content
1. Edit files in `src/` directory
2. Push to feature branch (deploys to DEV)
3. Test in DEV environment
4. Merge to master (deploys to PROD)

### Update Infrastructure
1. Modify Terraform files in `terraform/`
2. Run `terraform plan` to preview changes
3. Run `terraform apply` to apply changes

### Rollback
Use S3 versioning to restore previous versions:
```bash
aws s3api list-object-versions --bucket bran-website-prod
aws s3api get-object --bucket bran-website-prod --key index.html --version-id <VERSION_ID> index.html
```
