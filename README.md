# NERGZ Website — deployment guide

This is a secure starter project for a single shared website link with:
- One admin account
- Three editable information sections
- Admin-created individual usernames/passwords
- Password-protected login and server-side sessions
- Cloudflare Pages static assets + Cloudflare Worker + D1 database

## Important
This ZIP is the website source, not a published public URL. A public URL is created only after deployment to an account you control. The hosting and D1 free tiers may be sufficient for light use, but provider limits can change. Do not publish the admin password in source code.

## Deploy (one-time setup)
1. Create a free Cloudflare account at https://dash.cloudflare.com/
2. Install Node.js, then in this folder run:
   `npm install -g wrangler`
   `wrangler login`
3. Create the database:
   `wrangler d1 create nergz-db`
   Copy the returned database_id into `wrangler.toml`.
4. Initialize the tables:
   `wrangler d1 execute nergz-db --file=./schema.sql`
5. Set a strong admin password as a secret:
   `wrangler secret put ADMIN_PASSWORD`
   (The initial admin account is created on first startup only if it does not exist; see step 6.)
6. Create the initial admin user by running the one-time setup endpoint after deploy:
   `POST /api/setup-admin` with JSON `{"username":"admin","password":"YOUR_STRONG_PASSWORD"}`.
   This endpoint must be enabled only during setup. See the note below.
7. Deploy:
   `wrangler deploy`
8. Your public URL will be shown by Cloudflare, usually `https://nergz-website.<your-subdomain>.workers.dev`.

## Initial admin setup
After deploying for the first time, create the admin account by sending one POST request to:
`https://YOUR-WORKER-URL/api/setup-admin`
with JSON body:
`{"username":"admin","password":"YOUR_STRONG_PASSWORD"}`

Use a password of at least 12 characters. This endpoint works only until the first admin account is created; after that it is permanently blocked by the database check. Keep the admin password private.

## Sections and users
Log in with the admin username/password. Edit the three section text areas and save. Create a separate username/password for each customer. Give everyone the same website URL; each person logs in using their own credentials.

## Logo and branding
The uploaded NERGZ logo is included as `public/logo.jpeg`. Colors use navy blue and gold.

## Notes
- Admin can edit the section text and create user accounts.
- User accounts can read the three sections only.
- Sessions expire after seven days.
- For a production rollout, add rate limiting and account deletion/password reset features.
