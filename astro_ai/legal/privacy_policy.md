# Daivant AI Astrology - Privacy Policy
**Last Updated:** October 21, 2026  
**Effective Date:** October 21, 2026  
**Application:** Daivant AI Astrology (`com.astroai.quantum`)  
**Developer Contact:** ramsundar.1238@gmail.com  

---

## 1. Introduction & Overview
Welcome to **Daivant AI Astrology** ("Daivant", "we", "us", or "our"). We are committed to protecting your privacy and ensuring you have complete control over your personal and astrological data. This Privacy Policy describes how we collect, store, calculate, and safeguard your information when you use our mobile application across Android and iOS platforms.

Daivant operates on a **Zero-PII Exploitation Guarantee**: We **never** sell, rent, monetize, or broker your personal information or birth charts to third-party data brokers, advertising networks, or data aggregators.

---

## 2. Information We Collect

### A. Astrological Birth Matrix Data
To calculate accurate Vedic charts, planetary transits, Dashas, and divisional charts (Shodashvarga), you may provide:
- **Name / Nickname** (for report labeling)
- **Date and Time of Birth** (used for planetary longitude and Ascendant / Lagna calculations)
- **Place of Birth / Geographic Coordinates** (Latitude, Longitude, and Timezone for Topocentric / Geocentric ephemeris calculations)
- **Gender** (optional, for specific classical astrological reference metrics)

### B. Chat & Consultation Transcripts
- Queries submitted to the AI Astrologer assistant.
- Ephemeral reading context generated during your consultation sessions.

### C. Technical & Diagnostic Data
- Device identifiers, operating system version, and anonymous crash logs (processed via Firebase Crashlytics) to ensure system stability.
- In-app purchase verification receipts (processed securely via Google Play Billing and Apple App Store StoreKit). We **never** collect, view, or store your credit card or financial account numbers.

---

## 3. How We Process & Store Your Information

### 1. Local-First Processing
Where possible, calculations and chart renderings are performed locally on your device using Swiss Ephemeris algorithms.

### 2. Cloudflare Zero-Knowledge Vault (D1 & R2)
Backups and encrypted chart storage utilize our Cloudflare D1 database and R2 cloud storage infrastructure. User-specific records are encrypted at rest using industry-standard AES-256 / ChaCha20-Poly1305 encryption.

### 3. Firebase Cloud Infrastructure
- **Firebase Authentication:** Handles secure user authentication tokens (Anonymous guest sign-in, Google Sign-in, or Apple ID).
- **Cloud Firestore (Region: `asia-south1`, Mumbai):** Stores user preferences and synchronized reading history under strict Firebase Security Rules that enforce per-user read/write isolation.

---

## 4. Third-Party Services
We partner exclusively with enterprise infrastructure providers that comply with global privacy standards (GDPR, CCPA, and Indian Digital Personal Data Protection Act):
- **Google Firebase (Google Cloud Platform):** Authentication, Analytics & Cloud Firestore (`asia-south1`).
- **Cloudflare, Inc.:** Secure API routing, D1 encrypted SQL store, and R2 artifact storage.
- **Google Play & Apple App Store:** In-app payment processing and app distribution.

---

## 5. Data Retention & The 15-Step Cryptographic Purge
You retain absolute sovereignty over your astrological profiles and consultation records.
You may at any time initiate our **15-Step Cryptographic Purge** directly from the mobile application (`Settings -> Data & Privacy -> Delete All Data`):
1. User identity token invalidation.
2. Local SQLite / Hive database truncation.
3. Secure biometric key destruction.
4. Cached ephemeris transit cache clearance.
5. Cloud Firestore profile document deletion.
6. Cloud Firestore natal matrix purge.
7. Cloud Firestore reading history removal.
8. Cloudflare D1 query log zeroing.
9. Cloudflare R2 natal vault blob deletion.
10. Temporary server-side consultation context eviction.
11. Push notification token deregistration.
12. Crashlytics installation ID unlinking.
13. Firebase Authentication user record deletion.
14. Local cache and shared preferences purge.
15. Application state reset to factory zero.

For web-based or manual deletion requests, visit our [Deletion Policy](deletion_policy.html) or contact ramsundar.1238@gmail.com.

---

## 6. Children's Privacy
Daivant AI Astrology is not intended for children under the age of 13 (or under 16 in the European Union). We do not knowingly collect personal data from minors.

---

## 7. Updates to This Privacy Policy
We may update this policy periodically to reflect architectural updates or regulatory changes. Updated versions will be posted at this URL with a revised "Last Updated" timestamp.

---

## 8. Contact Us
For any privacy questions, data access requests, or regulatory inquiries:  
**Email:** ramsundar.1238@gmail.com  
**Developer:** Daivant AI Astrology Team  
