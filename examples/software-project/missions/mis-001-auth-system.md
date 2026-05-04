# MIS-001 -- User Authentication System

## METADATA
- **ID:** MIS-001
- **Slug:** auth-system
- **Priority:** P1 (Critical)
- **Type:** ROOT
- **State:** ACTIVE
- **Created:** 2026-04-01
- **Signal:** SIG-001
- **Dependencies:** None
- **Blocks:** MIS-002 (notifications -- needs authenticated user context)
- **Parallel missions:** MIS-004 (rate-limiting -- will integrate auth-aware limits)

## Objective [*(SEC.W1.DEF>MIS-001)*]

Implement a complete user authentication system for TaskFlow API using JWT tokens.
Users must be able to register, log in, refresh tokens, and access protected endpoints.
All task and project endpoints become auth-protected after this mission completes.

## Roadmap

### Phase 1 -- User Model and Database [*(DAT.W1.DEF>MIS-001)*]
- [x] Design User table schema (id, email, hashed_password, display_name, created_at, is_active)
- [x] Create SQLAlchemy model in `src/models/user.py`
- [x] Generate Alembic migration for users table
- [x] Run migration against dev and test databases
- [x] Add unique constraint on email with index

### Phase 2 -- JWT Endpoints [*(API.W1.DEF>MIS-001)*]
- [x] Install python-jose and passlib[bcrypt] dependencies
- [x] Create `src/services/auth.py` with password hashing and JWT creation
- [ ] Build POST /auth/register endpoint with email validation
- [ ] Build POST /auth/login endpoint returning access + refresh tokens
- [ ] Build POST /auth/refresh endpoint for token renewal
- [ ] Build GET /auth/me endpoint returning current user profile
- [ ] Write tests for all auth endpoints (target: 12 new tests)

### Phase 3 -- Middleware and Protection [*(SEC.W1.DEF>MIS-001)*]
- [ ] Create auth middleware in `src/middleware/auth.py`
- [ ] Add `get_current_user` dependency for route injection
- [ ] Protect all task endpoints (require valid token)
- [ ] Protect all project endpoints (require valid token)
- [ ] Add owner-only checks for task/project mutations
- [ ] Update existing tests to include auth headers
- [ ] Integration test: full register-login-create-task flow

## Decisions [*(SEC.W2.DEC>MIS-001)*]

1. **JWT over session cookies** -- Stateless auth fits our API-first architecture.
   Clients are expected to be SPAs or mobile apps, not server-rendered pages.
   Decision date: 2026-04-01.

2. **Access + Refresh token pattern** -- Short-lived access tokens (15 min) with
   longer refresh tokens (7 days). Balances security with UX. Refresh tokens
   stored in DB for revocation capability. Decision date: 2026-04-01.

3. **bcrypt for password hashing** -- Industry standard, resistant to GPU attacks,
   configurable work factor. Using passlib wrapper for clean API.
   Decision date: 2026-04-02.

## Progress Log

### 2026-04-18 -- Phase 1 Complete
Finished the user model and database layer. The `users` table is live in dev and test
environments. Schema includes email uniqueness with a B-tree index for login lookups.
Alembic migration `003_add_users_table.py` applied cleanly. Ran the existing 45 tests
to confirm no regressions from the new table. All green.
Next: begin Phase 2 with the auth service module.

### 2026-05-01 -- Phase 2 In Progress
Auth service module (`src/services/auth.py`) is built and unit-tested. Password hashing
uses bcrypt with work factor 12. JWT creation and validation working with python-jose.
Token payload includes `sub` (user ID), `exp`, and `iat` claims. Access tokens expire
in 15 minutes, refresh tokens in 7 days. Next step: wire up the four auth router
endpoints (register, login, refresh, me). Estimated completion of Phase 2: ~3 days.
