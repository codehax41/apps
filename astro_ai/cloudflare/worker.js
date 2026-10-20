/**
 * cloudflare/worker.js
 * Daivant AI Astrology - Cloudflare R2 Storage & D1 Database Gateway Worker
 * Handles secure endpoints for storing/retrieving chat histories,
 * generational artifacts, natal backups, D1 audit logs, and zero-knowledge data purge.
 */

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const method = request.method;

    // CORS preflight
    if (method === "OPTIONS") {
      return new Response(null, {
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
          "Access-Control-Allow-Headers": "Content-Type, X-AstroAI-Worker-Key, X-AstroAI-Account-Id, X-AstroAI-R2-Bucket",
        },
      });
    }

    // Authenticate Request
    const workerKey = request.headers.get("X-AstroAI-Worker-Key");
    if (!workerKey || workerKey !== env.WORKER_API_KEY) {
      return new Response(JSON.stringify({ error: "Unauthorized: Invalid Worker Key" }), {
        status: 401,
        headers: { "Content-Type": "application/json" },
      });
    }

    const bucket = env.ASTROAI_BUCKET;

    try {
      // 1. Store Chat Session (/api/chat/store)
      if (url.pathname === "/api/chat/store" && method === "POST") {
        const body = await request.json();
        const { key, data } = body;
        await bucket.put(key, JSON.stringify(data), {
          customMetadata: {
            uploadedAt: new Date().toISOString(),
            contentType: "application/json",
          },
        });
        return new Response(JSON.stringify({ success: true, key }), {
          status: 200,
          headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" },
        });
      }

      // 2. Fetch Chat Session (/api/chat/get)
      if (url.pathname === "/api/chat/get" && method === "GET") {
        const key = url.searchParams.get("key");
        if (!key) return new Response("Key required", { status: 400 });
        const object = await bucket.get(key);
        if (!object) return new Response("Not found", { status: 404 });
        return new Response(object.body, {
          headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" },
        });
      }

      // 3. Store Generational Artifact (/api/artifact/store)
      if (url.pathname === "/api/artifact/store" && method === "POST") {
        const body = await request.json();
        const { key, data } = body;
        await bucket.put(key, JSON.stringify(data), {
          customMetadata: { type: data.type || "general" },
        });
        return new Response(JSON.stringify({ success: true, key }), {
          status: 200,
          headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" },
        });
      }

      // 4. Fetch Generational Artifact (/api/artifact/get)
      if (url.pathname === "/api/artifact/get" && method === "GET") {
        const key = url.searchParams.get("key");
        if (!key) return new Response("Key required", { status: 400 });
        const object = await bucket.get(key);
        if (!object) return new Response("Not found", { status: 404 });
        return new Response(object.body, {
          headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" },
        });
      }

      // 5. Backup User Details (/api/user/backup)
      if (url.pathname === "/api/user/backup" && method === "POST") {
        const body = await request.json();
        const { key, data } = body;
        await bucket.put(key, JSON.stringify(data));
        return new Response(JSON.stringify({ success: true, key }), {
          status: 200,
          headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" },
        });
      }

      // 6. Purge All User Data (/api/user/purge)
      if (url.pathname === "/api/user/purge" && method === "POST") {
        const body = await request.json();
        const { userId } = body;
        if (!userId) return new Response("User ID required", { status: 400 });

        // List all objects prefixed with user's namespaces
        const prefixes = [`chats/${userId}/`, `generations/${userId}/`, `user_backups/${userId}/`];
        for (const prefix of prefixes) {
          const list = await bucket.list({ prefix });
          for (const item of list.objects) {
            await bucket.delete(item.key);
          }
        }

        return new Response(JSON.stringify({ success: true, purgedUserId: userId }), {
          status: 200,
          headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" },
        });
      }

      // 7. D1 Telemetry / Event Log (/api/d1/log)
      if (url.pathname === "/api/d1/log" && method === "POST") {
        const body = await request.json();
        const { eventType, userId, payload } = body;
        if (env.DB) {
          await env.DB.prepare(
            "CREATE TABLE IF NOT EXISTS audit_logs (id INTEGER PRIMARY KEY AUTOINCREMENT, eventType TEXT, userId TEXT, payload TEXT, createdAt DATETIME DEFAULT CURRENT_TIMESTAMP)"
          ).run();
          await env.DB.prepare(
            "INSERT INTO audit_logs (eventType, userId, payload) VALUES (?, ?, ?)"
          ).bind(eventType || "INFO", userId || "anonymous", JSON.stringify(payload || {})).run();
        }
        return new Response(JSON.stringify({ success: true }), {
          status: 200,
          headers: { "Content-Type": "application/json", "Access-Control-Allow-Origin": "*" },
        });
      }

      return new Response("Not Found", { status: 404 });
    } catch (err) {
      return new Response(JSON.stringify({ error: err.message }), {
        status: 500,
        headers: { "Content-Type": "application/json" },
      });
    }
  },
};
