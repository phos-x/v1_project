# Secure CI/CD with Canary Deployment on AWS EKS 🚀

This project provides a fully automated, secure **CI/CD pipeline for microservices** on **AWS EKS**. It implements a **canary deployment strategy** to safely roll out new code to a small group of users before a full release, minimizing risk and protecting the user experience.

-----

### **Key Features ✨**

  * **Infrastructure as Code (IaC):** AWS infrastructure—including a **VPC**, **EKS cluster**, and **ECR** repositories—is provisioned and managed with **Terraform**.
  * **End-to-End Automation:** An automated pipeline built with **GitHub Actions** handles everything from code commit to a live production deployment.
  * **Canary Deployment:** Safely deploy new versions of the backend API by routing a small, initial percentage of traffic to the new service using **Helm**.
  * **Secure Credentials:** The pipeline uses **GitHub Secrets** and **AWS OIDC** for authentication, so you never expose long-lived credentials.

-----

### **Technologies 🛠️**

  * **Cloud:** AWS
  * **Orchestration:** Kubernetes (on EKS)
  * **IaC:** Terraform
  * **CI/CD:** GitHub Actions
  * **Deployment:** Helm, Docker
  * **Backend:** Go
  * **Frontend:** HTML/CSS (Tailwind), JavaScript

-----

### **Project Structure 📂**

```
my-project/
├── .github/
│   └── workflows/
│       └── ci.yaml           # The main CI/CD pipeline
├── backend-api/              
│   ├── main.go
│   └── Dockerfile
├── frontend-ui/              
│   ├── index.html
    └── docker-entrypoint.sh
    └── nginx.conf
│   └── Dockerfile
├── helm/                     # Helm chart for deploying the app
│   └── ...
└── infra/                    # Terraform for AWS infrastructure
    └── ...
```

-----

### **Getting Started 🏁**

#### **1. Provision AWS Infrastructure**

Use Terraform to create the necessary AWS resources.

```bash
cd infra/
terraform init
terraform apply
```

This will create your VPC, EKS cluster, and ECR repositories. Be sure to save the output values, especially the **IAM Role ARN** and **ECR repository URLs**.

#### **2. Configure GitHub Secrets**

Navigate to your repository's settings and add the following secrets:

  * `IAM_ROLE_ARN`
  * `BACKEND_ECR_REPO_URL`
  * `FRONTEND_ECR_REPO_URL`

#### **3. Deploy the Application**

Simply push your code to the `main` branch. This will automatically trigger the `ci.yaml` workflow, which handles building and deploying your microservices to the EKS cluster.

-----

### **How the CI/CD Pipeline Works ⚙️**

The GitHub Actions workflow automates these steps:

1.  **Secure Authentication:** Assumes the **IAM role** via **OIDC** to securely connect to your AWS account.
2.  **Build & Push Images:** Builds **Docker images** for both the backend and frontend, then pushes them to **ECR**.
3.  **Deploy with Helm:** Deploys the application to EKS using the **Helm chart**. It activates the **canary deployment** for the backend, routing a small portion of traffic to the new version.
4.  **Promote to Stable:** After a successful validation period, it performs a final Helm upgrade to promote the new version to serve all users.
