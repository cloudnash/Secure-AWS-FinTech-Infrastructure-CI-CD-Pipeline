# 🛡️ Secure-AWS-FinTech-Infrastructure-CI-CD-Pipeline


![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen)
![Terraform](https://img.shields.io/badge/Terraform-1.5+-purple)
![AWS](https://img.shields.io/badge/AWS-Secure-orange)
![Compliance](https://img.shields.io/badge/Compliance-GDPR%2FPII-blue)

## 📌 Project Overview

This repository demonstrates a production-ready, GDPR-compliant AWS infrastructure designed for sensitive financial data (e.g., payroll processing). Provisioned entirely via **Terraform**, this project implements strict Role-Based Access Control (RBAC), encrypted data handling, and automated deployments using **GitHub Actions**.

## 🎯 Direct Job Description Requirement Mapping
| JD Requirement | Implementation in this Repo | File Location |
| :--- | :--- | :--- |
| **Multi-tenant RBAC & Data Isolation** | JWT-based role separation (Company, Bureau, Employee) with least-privilege IAM policies. | `app/main.py`, `infra/security.tf` |
| **Secrets Management & Encryption** | All DB credentials and API keys stored in **AWS Secrets Manager**; TLS/SSL enforced via ACM. | `infra/security.tf`, `scripts/validate_secrets.sh` |
| **GDPR/PII Compliance** | Data encrypted at rest (RDS KMS) and in transit; audit logging enabled; no hardcoded secrets. | `docs/GDPR_COMPLIANCE_CHECKLIST.md` |
| **AWS Core Services** | VPC, EC2/ECS, RDS (PostgreSQL), S3, Lambda, CloudWatch, Route 53, CloudFront. | `infra/*.tf` |
| **Threat Detection & WAF** | AWS WAF configured on CloudFront to block common web exploits (SQLi, XSS). | `infra/security.tf` |
| **CI/CD & Zero-Downtime Deploy** | GitHub Actions pipeline with Trivy scanning, Terraform validation, and rolling updates. | `.github/workflows/ci-cd-pipeline.yml` |


## 📌 Project Tree

```
aws-fintech-devops-pipeline/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── app/
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── terraform/
│   ├── ecs.tf
│   ├── provider.tf
│   ├── rds.tf
│   ├── security.tf
│   ├── variables.tf
│   └── vpc.tf
└── README.md
```


## Architecture & Security Features
* **Network Isolation:** Custom AWS VPC with public subnets for load balancers and private subnets for application servers (ECS Fargate) and databases (RDS PostgreSQL).
* **Security & RBAC:** Multi-tenant IAM roles enforcing least-privilege access. Segregated access environments mapped via IAM.
* **Secrets Management:** AWS Secrets Manager integration to prevent hardcoded PII or database credentials.
* **Data Compliance (GDPR context):** Encryption at rest (AWS KMS) and in transit (SSL/TLS).
* **CI/CD Pipeline:** GitHub Actions workflow that builds a secure Docker container, pushes to Amazon ECR, and deploys to ECS with zero downtime.

## Tech Stack
* **Cloud:** AWS (VPC, ECS Fargate, RDS PostgreSQL, IAM, Secrets Manager, CloudWatch)
* **Infrastructure as Code:** Terraform
* **Containerization:** Docker
* **CI/CD:** GitHub Actions

## Step-by-Step Deployment Guide

### Phase 1: Local Setup & Authentication
1. **Clone the repository:**
   `git clone https://github.com/yourusername/aws-fintech-devops-pipeline.git`
   `cd aws-fintech-devops-pipeline`
2. **Configure AWS CLI:** Run `aws configure` and input your IAM User Access Key, Secret Key, and default region (e.g., `eu-west-2` for UK).

### Phase 2: Provision Infrastructure (Terraform)
1. **Navigate to the Terraform directory:**
   `cd terraform`
2. **Initialize Terraform:**
   `terraform init`
3. **Review the execution plan:**
   `terraform plan`
4. **Deploy the infrastructure:**
   `terraform apply --auto-approve`
   *(Note: This provisions a VPC, ECS Cluster, and RDS Database. Note the output values provided at the end).*

### Phase 3: CI/CD Pipeline (GitHub Actions)
1. In your GitHub repository, go to **Settings > Secrets and variables > Actions**.
2. Add the following repository secrets:
   * `AWS_ACCESS_KEY_ID`
   * `AWS_SECRET_ACCESS_KEY`
3. Push your code to the `main` branch. 
4. Navigate to the **Actions** tab in GitHub to watch the automated build, Docker Hub push, and deployment process.

### Phase 4: Teardown
To avoid AWS charges, destroy the infrastructure once testing is complete:
`terraform destroy --auto-approve`
