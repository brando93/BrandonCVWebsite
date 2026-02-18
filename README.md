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

## 🎨 Modifying the Website UI

### Main Files for UI Changes

#### 1. HTML Content (Structure)
**File:** `src/pug/index.pug`
- **What to modify here:**
  - Website text (titles, descriptions, paragraphs)
  - Section structure (About, Services, Portfolio, Contact)
  - Personal information (name, professional title, bio)
  - Social media links
  - Work experience and certifications
  - Portfolio projects

**Common changes example:**
```pug
// Change main title
h1.text-white.font-weight-bold Brandon Rodriguez

// Modify description
p.text-white-75.mb-5 DevOps Engineer | Cloud Architect

// Add new experience section
section#experience
  .container
    h2 Professional Experience
```

#### 2. CSS Styles (Visual Appearance)
**Main files:**

- **`src/scss/styles.scss`** - Main file that imports all styles
- **`src/scss/_variables.scss`** - Global variables (colors, fonts, spacing)
- **`src/scss/_global.scss`** - Global site styles

**Component files:**
- **`src/scss/components/_navbar.scss`** - Navigation menu styles
- **`src/scss/components/_buttons.scss`** - Button styles
- **`src/scss/components/_dividers.scss`** - Section dividers

**Section files:**
- **`src/scss/sections/_masthead.scss`** - Main/hero section
- **`src/scss/sections/_portfolio.scss`** - Portfolio/projects section

**Design variables:**
- **`src/scss/variables/_colors.scss`** - Color palette
- **`src/scss/variables/_typography.scss`** - Fonts and text sizes
- **`src/scss/variables/_spacing.scss`** - Margins and padding

**Common changes example:**
```scss
// Change primary color (src/scss/variables/_colors.scss)
$primary: #f4623a;

// Modify font size (src/scss/variables/_typography.scss)
$font-size-base: 1rem;

// Adjust spacing (src/scss/variables/_spacing.scss)
$spacer: 1rem;
```

#### 3. JavaScript (Interactivity)
**File:** `src/js/scripts.js`
- **What to modify here:**
  - Navigation menu behavior
  - Animations and effects
  - Smooth scrolling between sections
  - Portfolio lightbox
  - Form validation

**Common changes example:**
```javascript
// Modify scroll behavior
window.addEventListener('scroll', function() {
    // Your custom code
});
```

#### 4. Images and Assets
**Directories:**
- **`src/assets/img/`** - General images
- **`src/assets/img/portfolio/`** - Portfolio images
  - `fullsize/` - Full-size images
  - `thumbnails/` - Thumbnail images
- **`src/assets/img/companies/`** - Company logos
- **`src/assets/img/certifications/`** - Certification images
- **`src/assets/favicon.ico`** - Site icon

### Workflow for UI Changes

```
1. Identify what to change:
   ├── Content/Text → src/pug/index.pug
   ├── Colors/Styles → src/scss/
   ├── Behavior → src/js/scripts.js
   └── Images → src/assets/img/

2. Make changes in the corresponding files

3. Test locally (optional):
   npm install
   npm start
   # Opens http://localhost:3000

4. Deploy to DEV:
   git checkout -b feature/ui-changes
   git add .
   git commit -m "Update UI: description of changes"
   git push origin feature/ui-changes
   # Review at: http://bran-website-dev.s3-website-us-east-1.amazonaws.com

5. Deploy to PROD (after testing in DEV):
   git checkout master
   git merge feature/ui-changes
   git push origin master
   # Live at: http://bran-website-prod.s3-website-us-east-1.amazonaws.com
```

### Common Modification Examples

#### Change site primary color
1. Edit `src/scss/variables/_colors.scss`
2. Modify the `$primary` variable
3. Save and deploy

#### Update personal information
1. Edit `src/pug/index.pug`
2. Find the corresponding section (About, Contact, etc.)
3. Modify the text
4. Save and deploy

#### Add new portfolio project
1. Add images to `src/assets/img/portfolio/`
2. Edit `src/pug/index.pug` in the portfolio section
3. Add the new item with its image and description
4. Save and deploy

#### Change navigation menu styles
1. Edit `src/scss/components/_navbar.scss`
2. Modify the desired styles
3. Save and deploy

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
