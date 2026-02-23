# Data-Net-SVC: Resilient Asynchronous Ingestion Baseline

## Executive Summary
**Project Pescador** requires a high-throughput, secure, and observable infrastructure to "catch" and process complex data streams. This repository demonstrates a **Sovereign Infrastructure-as-Code (IaC)** baseline, decoupling core networking from service logic to ensure scalability and data integrity.

## Architectural Capabilities
This demo showcases three core competencies of Systems Architect:

1. **Sovereign Networking (VPC-as-Code):** - Implementation of a custom GCP VPC with isolated private subnets.
   - Private Google Access enabled for secure service communication without public internet exposure.
   - Cloud NAT/Router integration for controlled egress.

2. **Observability-as-Code (The Pulse):**
   - Automated deployment of a Monitoring Dashboard via Terraform.
   - Pre-configured widgets for the "Four Golden Signals": Latency, Traffic, Errors, and Saturation.

3. **Asynchronous "Valve" Design (Mirror Logic):**
   - The directory structure mirrors a Producer-Consumer pattern.
   - **Ingestor:** Handles raw "Scanner Flood."
   - **Processor:** An Intelligence Tier utilizing memory-aware bounded queues for SLM/LLM inference.
   - **API:** The "Submission Drip" for controlled output.

## Directory Structure
- `infrastructure/`: Hardened GCP environment (Terraform).
- `services/`: Containerized microservices (Python/Docker).
- `shared-libs/`: Unified schemas to prevent data drift between stages.

## Getting Started
1. Initialize the net: `cd infrastructure && terraform init`
2. Prepare GCP: `./scripts/prepare_gcp.sh`
3. Deploy: `terraform apply`# data-net-vpc
# data-net-vpc
