# AWS Infrastructure Automation and Monitoring

Terraform builds the AWS resources, Ansible configures the server, and Prometheus + Grafana (plus a CloudWatch alarm) monitor it.

    Terraform -> EC2 + Security Group + S3 + CloudWatch alarm
    Ansible   -> nginx + node_exporter on the EC2 instance
    Laptop    -> Prometheus scrapes EC2:9100 -> Grafana dashboards

## Prerequisites
AWS account and CLI configured (`aws configure`), Terraform, an existing EC2 key pair, Docker Desktop.
Ansible does not run natively on Windows: run it from **WSL (Ubuntu)** or from a small Linux EC2 instance.

## 1. Provision with Terraform
    cd terraform
    copy terraform.tfvars.example terraform.tfvars     (then edit it)
    terraform init
    terraform plan
    terraform apply
Note the `instance_public_ip` output.

## 2. Configure with Ansible (from WSL or Linux)
    cd ansible
    cp inventory.ini.example inventory.ini     # put the IP and key path in
    ansible-playbook -i inventory.ini site.yml
Open `http://<instance_public_ip>` for the nginx page, and `http://<instance_public_ip>:9100/metrics` for metrics (only your IP is allowed).

## 3. Monitor with Prometheus and Grafana
Put the IP into `monitoring/prometheus.yml`, then:
    cd monitoring
    docker compose up -d
- Prometheus: http://localhost:9090 (Status -> Targets should show `ec2-node` as UP)
- Grafana: http://localhost:3000 (login admin/admin, then change it)
  - Connections -> Data sources -> Prometheus -> URL `http://prometheus:9090`
  - Dashboards -> Import -> ID `1860` (Node Exporter Full)

## 4. Trigger the CloudWatch alarm (optional)
SSH in and run a CPU stress test for ~10 minutes, then check the alarm in the CloudWatch console.

## Clean up (important)
    cd terraform
    terraform destroy
(You may need to empty the S3 bucket first because versioning is on.)

## What you will learn
Infrastructure as Code, Ansible roles, systemd services, Prometheus scraping, Grafana dashboards, CloudWatch alarms and SNS.
