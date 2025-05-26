
# AWS Notes: Solution Architect Associate

## ✅ First Course to Start With

* **Course Name**: AWS Certified Solutions Architect – Associate
* **Study Material Validity**: 2 years
* **Lab Access**: 1-month validity

---

## 🧱 AWS Services Overview

### 1. **Well-Architected Framework**

* Used for designing highly reliable, secure, and efficient AWS architectures.
* Based on **6 pillars**:

  * Operational Excellence
  * Security
  * Reliability
  * Performance Efficiency
  * Cost Optimization
  * Sustainability
* Around **57 questions** to validate the design against these pillars.
* Post-evaluation, you can contact AWS for support/queries via SLA-based responses.

---

### 2. **IAM (Identity and Access Management)**

* **Root User**: Created using one email ID (full access).
* **IAM** is used for **authentication** and **authorization**.
* **CloudTrail**: Used for **auditing** AWS account activities.

#### Access Methods:

* **Console (GUI)** access
* **Programmatic access**:

  * AWS CLI
  * AWS SDK

#### IAM Entities:

| Entity         | Description                                                            |
| -------------- | ---------------------------------------------------------------------- |
| Principal      | Entity that can log in (IAM User, Role, Service, Workload)             |
| IAM Role       | Temporarily assumed by trusted entities using STS (default: 1hr creds) |
| Trusted Entity | IAM User, Role, AWS Service, Federated (non-AWS) user                  |

---

## 🌐 VPC (Virtual Private Cloud)

* Acts like a **private data center in AWS**.
* **VPC is region-specific**; create separate VPCs for each region.
* **Subnets** are created within a VPC and tied to an **Availability Zone** (AZ).
* Subnets can be **public** or **private**.

### 🧾 Example:

```yaml
VPC:
  Name: Autodesk
  CIDR: 10.0.0.0/16   # ~65,000 IPs

Subnet:
  Name: eventing
  CIDR: 10.0.1.0/24   # 256 IPs
```

---

### 🌍 Access to EC2 Machines in VPC

1. **Attach IGW (Internet Gateway)** to the VPC – acts as a **router** to the internet.
2. Create a **route table** and **attach it to subnets** for network traffic routing.

---

### 📦 Public vs Private Subnets

| Feature             | Public Subnet                   | Private Subnet                     |
| ------------------- | ------------------------------- | ---------------------------------- |
| Internet Accessible | Yes                             | No                                 |
| IGW Required        | Yes                             | No                                 |
| NAT Gateway Usage   | Not Required                    | Required for outbound internet     |
| EC2 Exposure        | Exposed to internet (e.g., web) | Internal services (e.g., DB, APIs) |

### 🛠 Setup Steps

1. Create **VPC**
2. Create **Public and Private Subnets**
3. Create and attach **Internet Gateway (IGW)** to VPC
4. Create **Route Table** for public subnet → add rule to route `0.0.0.0/0` to IGW
5. Attach Route Table to **Public Subnet**
6. Launch **EC2 instances** in subnets as per need
7. Create **NAT Gateway** in **Public Subnet** and attach an **Elastic IP**
8. Create Route Table for **Private Subnet** to route `0.0.0.0/0` via **NAT Gateway**
9. Attach Security Groups to EC2 with:

   * **Inbound Rules**: Permit specific ports (e.g., 22 for SSH, 80 for HTTP)
   * **Outbound Rules**: Generally allow all unless restricted

---

### 💻 EC2 & Session Manager

* EC2 is a virtual machine in AWS.
* Session Manager (from Systems Manager) allows **secure shell access** to EC2 **without opening port 22 (SSH)**.
* Benefits:

  * No need for key pairs
  * No inbound SSH rule needed
  * Logging and auditing possible via CloudWatch

**To use Session Manager:**

* Attach appropriate **IAM role** to EC2 with `AmazonSSMManagedInstanceCore` policy.
* Ensure **SSM agent** is installed and EC2 has internet access (via IGW or NAT).

