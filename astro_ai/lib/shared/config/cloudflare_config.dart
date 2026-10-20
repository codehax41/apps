// shared/config/cloudflare_config.dart
// Cloudflare Storage & Worker Gateway Configuration for Daivant AI Astrology.
// Handles high-throughput object storage (R2), chat session logs, generational artifacts,
// and zero-egress backups for both iOS and Android platforms.

class CloudflareConfig {
  // Cloudflare Account Details
  static const String accountId = "41c57dfaf7c338deb5d557178ca75656";
  static const String r2BucketName = "daivant-vault";
  static const String d1DatabaseId = "ba5c55a5-a5b8-42f2-837d-8fbde117a2b6";
  static const String r2PublicDomain = "https://daivant-vault.r2.cloudflarestorage.com";

  // Cloudflare Worker API Gateway (Handles encrypted auth, R2 presigning & D1 chat indices)
  static const String workerBaseUrl = "https://daivant-storage-worker.ramsundar-1238.workers.dev/api";
  static const String workerApiKey = "cf_sec_daivant_astrology_41c57dfaf7c338deb5d557178ca75656";

  // Storage Object Paths & Namespaces
  static const String namespaceChats = "chats";
  static const String namespaceGenerations = "generations";
  static const String namespaceUserBackups = "user_backups";
  static const String namespaceEphemeris = "ephemeris_charts";
  static const String namespaceAudio = "audio_transcripts";

  static Map<String, String> get authHeaders => {
    "Content-Type": "application/json",
    "X-AstroAI-Worker-Key": workerApiKey,
    "X-AstroAI-Account-Id": accountId,
    "X-AstroAI-R2-Bucket": r2BucketName,
  };
}
