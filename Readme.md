Cost-Optimized Deployment Platform for Small Developers

## 🚀 Getting Started

### Prerequisites
- AWS Account
- terraform installed
- GitHub repository
- kubectl installed (for local admin if needed)

-------------
### steps to run
1. Set your AWS credentials locally

```bash
aws configure
```
AWS_ACCESS_KEY_ID=[...]
AWS_SECRET_ACCESS_KEY=[...]
AWS_REGION=[...]

2. Terraform: Provision infra
```bash
cd terraform
terraform init
terraform apply -auto-approve
```

Terraform will output:
-ec2_public_ip
-ecr_repo_url
-ssh_private_key_path (if you let terraform generate key)


3. SSH into EC2 (optional)
```bash
ssh -i ./terraform/k3s_key.pem ubuntu@<ec2_public_ip>
# check k3s: sudo kubectl get nodes
```


4. Configure GitHub Secrets

```
Add these secrets to your GitHub repo (Settings -> Secrets):
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_REGION (same as terraform)
ECR_REPO (value from terraform output)
EC2_USER (ubuntu)
EC2_HOST (ec2_public_ip)
EC2_SSH_KEY (private key contents)
```

5. Push code -> GitHub Actions will build, push, and deploy.

-------------


## 🛠️ Problem Statement

Small development teams and startups often face a significant challenge: building a robust, production-ready deployment platform without incurring high operational costs. Managed services like AWS EKS, ECS, and ALB, while powerful, are prohibitively expensive for small-scale projects. Additionally, setting up a complete CI/CD pipeline, monitoring, and logging infrastructure requires expertise and can be time-consuming. This creates a barrier for teams looking to deploy applications efficiently while staying within budget.

The goal is to design a cost-effective, scalable, and easy-to-manage deployment platform that provides all the essential features of a modern DevOps stack—without the financial burden of traditional solutions.

## 🎯 Purpose:
To create a production-like deployment platform for small companies or dev teams who want:
This platform provides a complete CI/CD pipeline, Kubernetes deployments, ingress with SSL, logs and monitoring, version rollback, and multi-application hosting—all without the high costs associated with managed services like EKS ($75–$150/month) or large EC2 instances. By leveraging a single small EC2 instance (t3.micro or t3.small), you can host everything efficiently. This approach not only minimizes expenses but also serves as a significant resume booster, showcasing your ability to address real-world cost and scalability challenges.


💡 THE CORE IDEA
Instead of using expensive managed services (EKS, ECS, ALB, CloudWatch), you:
1. Use k3s (a lightweight Kubernetes distro)
2. Run it on one EC2 instance
3. Deploy apps via GitHub Actions
4. Use Traefik ingress as a cheap (free) load balancer
5. Add monitoring/logging using Prometheus + Grafana + Loki
6. This creates a full DevOps platform at under $3/month.

🏗️ Architecture Overview
Here’s the logical design:
```
      GitHub
        |
        v
     GitHub Actions
        |
        v
  Build  Push Docker image
        |
        v
      AWS ECR
        |
        v
    k3s Kubernetes Cluster (EC2)
    ├── App A (Flask, Node, etc.)
    ├── App B
    ├── App C
    ├── Traefik Ingress + SSL
    ├── Prometheus (Metrics)
    ├── Grafana (Dashboard)
    └── Loki (Logs)
```

Everything runs on the same VM.

## 📈 Benefits

### Cost Savings
- **Traditional Setup**: EKS ($75-150/month) + ALB + CloudWatch + ECS
- **This Platform**: Single EC2 instance (~$8-15/month)
- **Total Savings**: 80-90% cost reduction

### Technical Advantages
- **Full DevOps Stack**: Complete CI/CD, monitoring, and deployment pipeline
- **Production-Ready**: SSL, ingress, logging, metrics, and rollbacks
- **Multi-App Support**: Host multiple applications on one instance
- **Easy Scaling**: Add more EC2 instances when needed

### Learning & Resume Value
- **Real-World Problem Solving**: Address actual cost/scale challenges
- **Modern Tech Stack**: Kubernetes, Docker, Terraform, GitHub Actions
- **DevOps Expertise**: End-to-end platform engineering experience



### Quick Setup
1. **Clone the repository**
2. **Configure Terraform variables**
3. **Deploy infrastructure**: `terraform apply`
4. **Set up domain DNS** to point to EC2 public IP
5. **Configure GitHub Actions** with AWS credentials
6. **Deploy your first app**

## 📋 Project Structure
```
deployment-platform/
├── terraform/           # Infrastructure as Code
├── kubernetes/          # K8s manifests
├── monitoring/          # Prometheus/Grafana configs
├── github-actions/      # CI/CD workflows
└── examples/           # Sample applications
```

## cons of the project
❗ 1. Single Point of Failure (SPOF) — Biggest Risk
❗ 2. Not “Production Grade” for Large Traffic
❗ 3. No Auto-Scaling at the Node Level
❗ 4. Manual Maintenance & Upgrades
❗ 5. Logs & Monitoring Are Local, Not Centralized
❗ 6. SSL & DNS Management Are Up to You
❗ 7. CI/CD Deployments Can Overload the Server
❗ 8. Multi-Tenancy Is Limited
❗ 9. Not Suitable for Compliance (Security Considerations)
❗ 10. Backups Must Be Manual
❗ 11. No Guaranteed SLAs

