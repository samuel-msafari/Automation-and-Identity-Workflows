# IT Operations & Security Automation Suite
**Author:** Samuel Msafari  
**Focus:** Eliminating Toil & Hardening Identity Governance

## 🚀 Overview
This repository contains a collection of PowerShell and Bash scripts designed to automate recurring IT operations and enforce security baselines within Microsoft 365 and hybrid cloud environments. 

The primary goal of these scripts is to move from **manual task execution** to **Policy-as-Code**, ensuring 100% consistency in security controls.

---

## 🛠️ Featured Scripts

### 1. [M365-Automated-Offboarding.ps1](./M365-Automated-Offboarding.ps1)
**Problem:** Manual offboarding is prone to human error, leaving "orphan accounts" that become prime targets for malicious actors.
**Solution:** An automated 7-step departure protocol.
* **Key Actions:** Revokes all sessions, disables the account, converts mailbox to shared, and triggers an Intune remote wipe.
* **Business Impact:** Reduces offboarding time by 80% and ensures 100% data preservation for legal/audit compliance.

### 2. [Intune-Compliance-Audit.ps1](./Intune-Compliance-Audit.ps1)
**Problem:** In a remote-first fleet, devices can fall out of compliance (encryption off, OS outdated) without immediate notification.
**Solution:** Queries the Microsoft Graph API to identify non-compliant devices.
* **Key Actions:** Compiles a CSV report of devices failing "BitLocker" or "Antivirus" status.
* **Strategic Value:** Provides the raw data for the **Microsoft Secure Score** improvement from 38% to 91%.
  
### 3. [Inactive-User-Audit.ps1](./Inactive-User-Audit.ps1)
**Problem:** Inactive accounts (stale identities) represent both a security vulnerability and a wasted licensing cost ($30+/mo per user for M365 E5).
**Solution:** Scans the tenant for users who haven't signed in for 90+ days.
* **Key Actions:** Queries `SignInActivity` metadata to identify dormant accounts across the global organization.
* **Business Impact:** Facilitates "License Reclamation," potentially saving thousands in annual OpEx while closing security backdoors.

---

## 🏗️ Technical Architecture
These scripts are designed to work within a **Secure DevOps** framework:
* **Identity:** Utilizes Microsoft Graph PowerShell SDK.
* **Auth:** Supports Certificate-based authentication for secure, unattended execution.
* **Logging:** All actions are logged to local transcripts for forensic auditability.

---

## 💡 Why Automation?
As an IT Manager, I view automation as the ultimate **Scalability Tool**. By automating "The Toil," my team is empowered to focus on high-value strategic projects like **Zero-Trust Architecture** and **Fintech Compliance**, rather than manual account resets.
