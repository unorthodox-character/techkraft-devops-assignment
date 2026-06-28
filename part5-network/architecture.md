# Redundant DNS Architecture Design

## Objective

The current environment has a single Unbound DNS server running on one EC2 instance. This creates a Single Point of Failure (SPOF). If the instance fails, internal and external DNS resolution becomes unavailable, potentially impacting all production services.

The proposed architecture eliminates this SPOF while improving scalability, availability, and maintainability.

---

# Proposed Architecture

```
                        Internet
                            |
                     Amazon Route53
                    (Hosted Zone + DNS)
                            |
        ------------------------------------------
        |                                        |
 Route53 Health Check                    Route53 Health Check
        |                                        |
 Primary DNS                           Secondary DNS
 (EC2 Unbound)                         (EC2 Unbound)
 us-east-1a                            us-east-1b
        |                                        |
        ------------------------------------------
                            |
                     Internal VPC Network
                            |
            -------------------------------
            |                             |
      Application Servers            RDS MySQL
```

---

# Components

## Amazon Route53

- Public hosted zone
- DNS failover
- Health checks
- Low latency global DNS

---

## Primary DNS

- EC2
- Unbound
- Private subnet
- Multi-AZ capable

---

## Secondary DNS

- Separate Availability Zone
- Same DNS configuration
- Automatically serves traffic during failures

---

## Health Checks

Route53 continuously monitors:

- DNS service
- TCP Port 53
- HTTP health endpoint
- EC2 instance health

Health check interval:

30 seconds

Failure threshold:

3 consecutive failures

---


If the primary DNS server becomes unhealthy, Route53 automatically updates DNS responses to point clients to the healthy secondary server.

No manual intervention is required.

---

# AWS Improvements

Along with redundant DNS I would also recommend:

- Private Subnets
- Public Subnets
- NAT Gateway
- Internet Gateway
- Multi-AZ RDS
- Application Load Balancer
- Auto Scaling Group
- IAM Roles
- CloudWatch Monitoring


# Security Improvements

- Security Groups restricting DNS traffic
- IAM Roles instead of credentials
- Systems Manager for administration
- No direct SSH access from Internet
- Enable CloudTrail logging
- Enable AWS Config

---

# Monitoring

- CloudWatch
- Route53 Health Checks
- CloudWatch Alarms
- SNS Notifications
- Prometheus
- Grafana
- OpenTelemetry

---

# Cost Estimate

| Component | Estimated Monthly Cost |
|------------|-----------------------|
| Route53 Hosted Zone | ~$0.50 |
| Route53 Health Checks (2) | ~$1.00 |
| Secondary EC2 t3.small | ~$15–18 |
| CloudWatch Metrics | ~$5 |
| Total Additional Cost | ~$22–25/month |

---

# Estimated Implementation Timeline

| Design Review | 2 Hours |
| Build Secondary DNS | 2 Hours |
| Configure Route53 | 2 Hour |
| Configure Health Checks | 1 Hour |
| Testing | 2 Hours |
| Documentation | 1 Hour |

Total Estimated Time:

Approximately **2 working day** 
 
---

# Benefits

- Eliminates Single Point of Failure
- Automatic Failover
- High Availability
- Improved Disaster Recovery
- Lower Operational Risk
- Better Monitoring
- Easier Maintenance
- Scalable Design

---

# Conclusion

Replacing the current single Unbound DNS server with a Route53-based redundant architecture significantly improves availability and resilience. Combined with Multi-AZ deployment, health checks, and observability, this design provides a production-ready DNS solution suitable for TechKraft's growing infrastructure.