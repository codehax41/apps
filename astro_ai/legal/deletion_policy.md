# Daivant AI Astrology - User Data & Account Deletion Policy
**Last Updated:** October 21, 2026  
**Application:** Daivant AI Astrology (`com.astroai.quantum`)  
**Developer Contact:** ramsundar.1238@gmail.com  

---

## 1. User Sovereignty & Right to Erasure
In compliance with Google Play Developer Policies, Apple App Store Review Guidelines (Guideline 5.1.1(v)), the General Data Protection Regulation (GDPR), California Consumer Privacy Act (CCPA), and the Digital Personal Data Protection Act (DPDP), **Daivant AI Astrology** provides all users with an immediate, irrevocable, and self-service mechanism to delete their accounts and all associated data.

---

## 2. In-App Deletion (Immediate Self-Service)
You can permanently delete your account and all stored astrological matrices directly inside the application:
1. Open **Daivant AI Astrology**.
2. Navigate to **Settings** (or tap the Profile icon).
3. Select **Data & Privacy Management**.
4. Scroll to **Danger Zone** and tap **"Delete All Data & Account"**.
5. Confirm the cryptographic purge prompt.

Upon confirmation, our automated **15-Step Cryptographic Purge Protocol** executes across your local device and cloud infrastructure in real-time.

---

## 3. The 15-Step Cryptographic Purge Architecture
When initiated, the following sequence is executed:

| Step | Scope | Operation Executed |
|---|---|---|
| **01** | Device / Security | Invalidate active JWT authorization sessions and OAuth tokens. |
| **02** | Local Storage | Truncate local SQLite encrypted database records. |
| **03** | Local Storage | Clear Hive box containers holding astrological cache. |
| **04** | Biometrics | Invalidate Android Keystore / iOS Keychain hardware encryption keys. |
| **05** | Cache | Evict temporary transit overlays and planetary ephemeris caches. |
| **06** | Cloud Firestore | Permanently delete `/users/{userId}` user document. |
| **07** | Cloud Firestore | Recursively delete `/users/{userId}/natal_matrix/*` subcollection. |
| **08** | Cloud Firestore | Recursively delete `/users/{userId}/saved_readings/*` subcollection. |
| **09** | Cloudflare D1 | Purge query execution records matching hashed UID in D1 SQL Vault. |
| **10** | Cloudflare R2 | Delete encrypted birth chart binary blobs stored in `daivant-vault` bucket. |
| **11** | AI Consultation | Evict active ephemeral memory contexts in AI model inference engines. |
| **12** | Notifications | Deregister Firebase Cloud Messaging (FCM) device push tokens. |
| **13** | Analytics | Disassociate Firebase Crashlytics pseudonymous device installation identifiers. |
| **14** | Firebase Auth | Permanently delete the user account in Firebase Authentication. |
| **15** | App State | Clear all SharedPreferences / UserDefaults and reset client to factory zero. |

---

## 4. Manual Web-Based Deletion Request
If you have uninstalled the application or cannot access your mobile device, you can request manual deletion:

1. **Email:** Send an email to `ramsundar.1238@gmail.com` with the subject line:  
   `DATA DELETION REQUEST - Daivant AI Astrology`
2. **Identification Details:** Provide your registered email address or the approximate date/time of your birth profile.
3. **Turnaround Time:** Requests are processed and confirmed within **48 hours**. Once purged, you will receive a cryptographic confirmation receipt.

---

## 5. Retention Exceptions
We do **not** retain any personal or astrological data following account deletion. Transaction logs related to past billing receipts are maintained solely within Apple App Store and Google Play Console according to statutory financial reporting regulations.
