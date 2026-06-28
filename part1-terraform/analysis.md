# 1. Security Issues

| SSH open to 0.0.0.0/0 | Exposes servers to the Internet | Restrict to Bastion Host or VPN |
| HTTP only | Traffic is unencrypted | Use HTTPS (443)|
| Hardcoded DB password | Credentials stored in code | AWS Secrets Manager |
| Default admin username | Use unique username |
| RDS backups disabled | Cannot recover data | Enable automated backups |
| Deletion protection disabled | Risk of accidental deletion | Enable deletion protection |
| S3 bucket has no encryption | Data stored unencrypted | Enable SSE-KMS |
| No S3 versioning | Accidental deletion impossible to recover | Enable Versioning |
| Outbound traffic unrestricted | Excessive permissions | Restrict egress wherever possible |

# 2. Architectural Issues

| Only public subnets | Introduce private subnets |
| Database not isolated | Deploy RDS into private subnet group |
| No NAT Gateway | Allow private workloads Internet access |
| No Internet Gateway defined | Add proper Internet Gateway |
| No Route Tables | Create public/private route tables |
| No Load Balancer | Use Application Load Balancer |
| No Auto Scaling Group | Improve scalability |
| No CloudWatch monitoring | Add monitoring & alarms |
| No Route53 design | Remove DNS SPOF |
| No IAM Roles | Use IAM Roles instead of credentials |
| Hardcoded values | Replace with variables |
| No remote backend | Store Terraform state in S3 |
| No DynamoDB locking | Prevent concurrent state changes |

---

# 3. Production Improvements

## Networking

- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Route53
- Multi-AZ

## Compute

- Auto Scaling Group
- Application Load Balancer
- IAM Roles

## Database

- Multi-AZ RDS
- Storage Encryption
- Automated Backups
- Deletion Protection
- Dedicated Security Group

## Terraform

- Remote Backend (S3)
- State Locking (DynamoDB)
- Modules
- Variables
- Outputs
- Locals
- Workspaces

## Security

- Secrets Manager
- Least Privilege IAM
- HTTPS

## Observability

- CloudWatch
- Prometheus
- Grafana
- OpenTelemetry
- Centralized Logging

## Cost Optimisation

- Auto Scaling
- Right-sizing
- Reserved Instances
- S3 Lifecycle Policies
- Monitoring Resource Utilisation
