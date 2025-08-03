```markdown
# Secure Microservices CI/CD Pipeline with Canary Deployment on AWS EKS 🚀

This project presents a platform, meticulously architected to empower a microservices application with seamless automation, unyielding security, and a robust deployment methodology. It confronts the critical challenge of implementing a streamlined software delivery lifecycle that ensures new code is packaged, tested, and deployed with precision and confidence.

The unique proposition of this project lies in its ability to mitigate deployment risk in a live production environment. Rather than a high-stakes "big bang" rollout, this pipeline pioneers a **canary deployment strategy**. This means a new version of the backend API is cautiously introduced to a small, isolated segment of users. Only after its performance is validated and deemed stable will it be fully promoted to serve the entire user base.

This strategic, phased approach drastically reduces the potential for service disruption, safeguarding the user experience and the integrity of the platform.

---

## Features ✨

- **Infrastructure as Code (IaC)**: The entire AWS ecosystem—including a fortified VPC, an EKS cluster, and a fleet of ECR repositories—is provisioned and managed entirely through Terraform.
- **Automated CI/CD**: An end-to-end pipeline powered by GitHub Actions orchestrates the entire journey of code, from a simple commit to a live production deployment.
- **Canary Deployment**: The backend API's deployment uses Helm and a Kubernetes Service to orchestrate a small, initial traffic split, enabling a safe and low-risk rollout of new features.
- **Containerization**: Both the Go API and the static HTML frontend are encapsulated in optimized Dockerfiles, ensuring consistency and portability across all environments.
- **Secure Credentials Management**: The pipeline employs a best-in-class security model, leveraging GitHub Secrets and AWS OIDC to authenticate with AWS services without ever exposing sensitive, long-lived credentials.

---

## Technologies Used 🛠️

- **Cloud Provider**: AWS  
- **Orchestration**: Kubernetes (on AWS EKS)  
- **Infrastructure as Code**: Terraform  
- **Containerization**: Docker  
- **CI/CD**: GitHub Actions  
- **Deployment Packaging**: Helm  
- **Backend**: Golang  
- **Frontend**: HTML, CSS (Tailwind CSS), JavaScript  

---

## Project Structure 📂

```
my-project/
├── .github/                  
│   └── workflows/
│       └── ci.yaml           # The main CI/CD pipeline
├── backend-api/              
│   ├── main.go
│   └── Dockerfile
├── frontend-ui/              # Static HTML frontend
│   ├── index.html
    └── docker-entrypoint.sh
    └── nginx.conf
│   └── Dockerfile
├── helm/                     # Helm chart for deploying the application
│   ├── templates/
│   │   ├── backend-deployment.yaml
│   │   ├── backend-service.yaml
│   │   ├── frontend-deployment.yaml
│   │   └── nginx-config.yaml
│   ├── Chart.yaml
│   └── values.yaml
└── infra/                    # Terraform code for AWS infrastructure
    ├── eks.tf
    └── iam.tf
    └── main.tf
    └── network.tf
    └── output.tf
    └── var.tf
```

---

## Getting Started 🏁

### 1. Provision the Infrastructure ☁️

Use Terraform to provision the necessary AWS resources:

```bash
cd infra/
terraform init
terraform apply
```

Approve the changes. This command creates a VPC, an EKS cluster, ECR repositories, and a secure IAM role for GitHub Actions.  
**Note**: Save the output values—especially the IAM Role ARN and ECR repository URLs—for the next step.

---

### 2. Configure GitHub Secrets 🔒

Go to your repository's settings and add the following secrets:

- `IAM_ROLE_ARN`: The ARN of the IAM role from your Terraform output  
- `BACKEND_ECR_REPO_URL`: The URL of the ECR repository for the backend  
- `FRONTEND_ECR_REPO_URL`: The URL of the ECR repository for the frontend  

---

### 3. Deploy the Application 🚀

Push to the `main` branch to trigger the `ci.yaml` workflow. This will automatically build and deploy your microservices to the EKS cluster.

---

### 4. Viewing the Application 🌐

To access your deployed application, retrieve the URL of your EKS cluster's ingress controller.  
Navigate to this URL in your browser to view the product catalog in action.

---

## The CI/CD Pipeline Workflow ⚙️

The GitHub Actions workflow in `.github/workflows/ci.yaml` performs the following steps:

1. **Checkout Code**: Clones the repository to begin the pipeline  
2. **Configure AWS Credentials**: Uses OIDC to securely assume the IAM role  
3. **Build & Push Images**: Creates Docker images for both services and pushes them to ECR  
4. **Deploy with Helm**:  
   - Updates kubeconfig to connect to EKS  
   - Performs a Helm upgrade to deploy the new version  
   - Activates canary deployment for the backend, directing a small portion of traffic to the updated service  
5. **Promote to Stable**:  
   - After validation, performs a final Helm upgrade to promote the new version to full production  

---
