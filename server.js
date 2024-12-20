const express = require("express");
const cors = require('cors');
const bodyParser = require("body-parser");
const OAuth2Server = require("oauth2-server");
const mysql = require("mysql2/promise");
const { DateTime } = require("luxon"); // Use Luxon for timezone handling
require("dotenv").config();


const app = express();

// Enable CORS
app.use(
  cors({
    origin: "http://192.168.0.38:3000", // Allow this specific origin
    methods: ["GET", "POST", "PUT", "DELETE"], // Allow specific methods
    allowedHeaders: ["Content-Type", "Authorization"], // Allow these headers
  })
);

// Use CORS middleware
// app.use(cors());

// // Custom CORS configuration (if needed)
// app.use((req, res, next) => {
//   res.setHeader('Access-Control-Allow-Origin', '*'); // Allow all origins
//   res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS'); // Allowed HTTP methods
//   res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization'); // Allowed headers
//   next();
// });

const Request = OAuth2Server.Request;
const Response = OAuth2Server.Response;

// Database Connection
const db = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME || "oauth2_server",
});

// OAuth2 Server Configuration
app.oauth = new OAuth2Server({
  model: {
    getAccessToken: async (accessToken) => {
      const [rows] = await db.query(
        "SELECT access_token, access_token_expires_at, client_id, user_id FROM tokens WHERE access_token = ?",
        [accessToken]
      );
      if (!rows.length) return null;
      const token = rows[0];
      return {
        accessToken: token.access_token,
        accessTokenExpiresAt: new Date(token.access_token_expires_at),
        client: { id: token.client_id },
        user: { id: token.user_id },
      };
    },

    getClient: async (clientId, clientSecret) => {
      const [rows] = await db.query(
        "SELECT id, client_secret, grants FROM clients WHERE id = ? AND client_secret = ?",
        [clientId, clientSecret]
      );
      if (!rows.length) return null;
      const client = rows[0];
      return {
        id: client.id,
        clientSecret: client.client_secret,
        grants: client.grants.split(","),
      };
    },

    saveToken: async (token, client, user) => {
      await db.query(
        "INSERT INTO tokens (access_token, access_token_expires_at, client_id, user_id, refresh_token) VALUES (?, ?, ?, ?, ?)",
        [token.accessToken, token.accessTokenExpiresAt, client.id, user.id, token.refreshToken]
      );
      return {
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
        accessTokenExpiresAt: token.accessTokenExpiresAt,
        client,
        user,
      };
    },

    getUser: async (username, password) => {
      const [rows] = await db.query(
        "SELECT id, username FROM users WHERE username = ? AND password = ?",
        [username, password]
      );
      if (!rows.length) return null;
      return rows[0];
    },

    verifyScope: () => true, // Simplified for demonstration
  },
});

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Token Endpoint
app.post("/oauth/token", async (req, res) => {
  const request = new Request(req);
  const response = new Response(res);

  // try {
  //   const token = await app.oauth.token(request, response);
  //   res.json(token);
  // } catch (err) {
  //   res.status(err.code || 500).json(err);
  // }

  try {
    const token = await app.oauth.token(request, response);

    // Convert `accessTokenExpiresAt` to Asia/Jakarta timezone
    if (token.accessTokenExpiresAt) {
      token.accessTokenExpiresAt = DateTime.fromJSDate(token.accessTokenExpiresAt)
        .setZone("Asia/Jakarta")
        .toISO();
    }

    res.json(token);
  } catch (err) {
    // Add Jakarta time to the error response for debugging
    const jakartaTime = DateTime.now().setZone("Asia/Jakarta").toISO();
    res.status(err.code || 500).json({ ...err, jakartaTime });
  }
});

// Protected Resource
app.get("/secure", async (req, res) => {
  const request = new Request(req);
  const response = new Response(res);

  try {
    await app.oauth.authenticate(request, response);
    res.json({ message: "You have accessed a protected resource!" });
  } catch (err) {
    res.status(err.code || 500).json(err);
  }
});

// Start Server
const PORT = process.env.PORT || 3007;
app.listen(PORT, () => {
  console.log(`OAuth2 server running on http://localhost:${PORT}`);
});
