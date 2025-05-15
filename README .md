# MERN Stack Blog App Deployment - Week 11 Assignment

This repository contains the infrastructure and automation for deploying a MERN stack blog application using **Terraform** and **Ansible** on AWS. The backend is hosted on an EC2 instance, the frontend on an S3 bucket, and MongoDB Atlas is used for the database.

---

## Architecture Overview

The architecture includes:

- **EC2 Instance**: Hosts the backend Node.js server and is managed by PM2.
- **MongoDB Atlas**: Stores blog data in the cloud.
- **S3 Buckets**:
  - **Frontend Bucket**: Hosts the React frontend as a static website.
  - **Media Bucket**: Stores uploaded media and is accessed securely via IAM and signed URLs.
- **Terraform**: Used for provisioning all AWS resources.
- **Ansible**: Automates backend configuration and deployment.

![Architecture](architecture.png)

---

## Deployment Steps

### Prerequisites

- AWS Account
- MongoDB Atlas Account
- Terraform installed
- Ansible installed
- Node.js installed
- AWS CLI configured

---

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/mern-deploy-week11.git
cd mern-deploy-week11
```

---

### 2. Infrastructure with Terraform

```bash
cd terraform
terraform init
terraform apply
```

This provisions the EC2 instance, S3 buckets, and security groups.

---

### 3. MongoDB Atlas Setup

- Create a cluster on MongoDB Atlas
- Create a user with password
- Whitelist EC2 public IP address
- Copy the connection string

---

### 4. Backend Deployment with Ansible

```bash
cd ../ansible
ansible-playbook -i inventory backend-playbook.yml
```

Ansible will:

- Install required packages (Node.js, PM2)
- Clone the project
- Generate `.env` file from `.env.j2`
- Start the app with PM2

#### PM2 Confirmation Screenshot:

![PM2 Screenshot](pm2-list.png)

---

### 5. Frontend Deployment to S3

```bash
cd ../frontend
cat > .env <<EOF
VITE_BASE_URL=http://54.85.112.178:5000/api
VITE_MEDIA_BASE_URL=https://mern-msdia-bucket-lina.s3.us-east-1.amazonaws.com
EOF

npm install
npm run build
aws s3 sync dist/ s3://mern-msdia-bucket-lina/
```

#### Frontend Screenshot:

![S3 Screenshot](s3-homepage.png)

---

## Output URLs

- **Frontend (S3):**  
  http://mern-msdia-bucket-lina.s3-website-us-east-1.amazonaws.com

- **Backend (EC2):**  
  http://54.85.112.178:5000/api

---

## Cleanup

To remove all AWS resources:

```bash
cd terraform
terraform destroy
```

Also remember to:

- Remove secrets from EC2
- Delete MongoDB Atlas users and IPs

---

## Credits

Deployed and documented by **Lina**  
Clarusway DevOps Bootcamp – Week 11 Assignment

### **ملاحظة أمنية بخصوص AWS Access Key**

تم اكتشاف وجود AWS Access Key ID في ملف `README.md` من قِبل GitHub من خلال آلية **Secret Scanning**.  
ولأن هذا المفتاح يُعتبر معلومة حساسة، فقد قمت بالإجراءات التالية لحل المشكلة:

1. **حذفت المفتاح فورًا من الملف** لتفادي أي خطر أمني.
2. **أعدت إصدار مفتاح جديد** من AWS Console وقمت بتأمينه بشكل صحيح.
3. راجعت كل الملفات وتأكدت من عدم وجود مفاتيح أو أسرار ظاهرة في المستودع.
4. التزمت باستخدام ملفات `.env` أو AWS IAM Roles في المستقبل لحماية بيانات الاعتماد.
5. في حال بقي المفتاح في سجل Git، سأقوم باستخدام أدوات مثل `BFG Repo-Cleaner` لإزالته بشكل دائم.