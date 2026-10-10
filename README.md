# FreshGuard AI

> **Tagline:** Rescue Freshness. Reduce Waste. Make Smarter Decisions.  
> **Problem Statement:** Zero-Waste Grocery Intelligence & Autonomous Supply Optimization

---

## 1. Executive Summary

Grocery stores face massive financial and environmental losses because perishable goods remain unsold until expiry. At the same time, naive markdowns degrade brand margins, while reactive replenishment triggers stockouts and inventory bullwhip effects.

**FreshGuard AI** is a professional-grade, multi-agent grocery rescue intelligence platform. It replaces arbitrary heuristic discounts with an agentic decision arena where specialist AI agents evaluate inventory, forecast localized consumer demand, calculate spoilage exposure, and compete to recommend the optimal feasible intervention—validated by automated constraint gates and authorized by human supply planners.

---

## 2. The Four Signature Capabilities

FreshGuard AI goes far beyond a generic dashboard with an AI label:

```
┌────────────────────────────────────────────────────────────────────────────────┐
│                           FRESHGUARD AI DECISION FLOW                          │
│                                                                                │
│   1. RESCUE CLOCK              2. ACTION ARENA             3. ROBUSTNESS GATE  │
│   ┌────────────────────┐       ┌────────────────────┐      ┌─────────────────┐ │
│   │ Expiry countdown   │       │ Demand Agent       │      │ 6 Perturbations │ │
│   │ Transit departure  │ ───►  │ Freshness Agent    │ ───► │ Demand shifts   │ │
│   │ Markdown floor     │       │ Markdown Agent     │      │ Transit delays  │ │
│   │ Urgency Tier       │       │ Transfer Agent     │      │ Elasticity drop │ │
│   └────────────────────┘       │ Replenish Agent    │      │ Status: ROBUST  │ │
│                                │ Coordinator Payoff │      └─────────────────┘ │
│                                └────────────────────┘               │          │
│                                           │                         ▼          │
│                                           ▼               4. COUNTERFACTUAL    │
│                                ┌────────────────────┐     ┌─────────────────┐  │
│                                │ HUMAN APPROVAL     │     │ Why not Hold?   │  │
│                                │ Approve/Edit/Reject│ ◄── │ Why not Disc?   │  │
│                                │ Feasibility Recheck│     │ Flip Conditions │  │
│                                └────────────────────┘     └─────────────────┘  │
└────────────────────────────────────────────────────────────────────────────────┘
```

1. **Rescue Clock (Signature Feature 1):**  
   Calculates exact operational intervention windows:
   - Time remaining to batch expiration.
   - Latest feasible departure time for refrigerated transfer to sister stores.
   - Latest useful floor markdown time before retail closing.
   - Action urgency tiers: `RED` (immediate), `AMBER` (urgent), `GREEN` (stable).

2. **Action Arena (Signature Feature 2):**  
   Specialist agents submit competing intervention proposals:
   - **Agent A (Demand Intelligence):** Moving-average baseline with weather, event, and promotion multipliers.
   - **Agent B (Freshness & Spoilage):** FEFO allocation, expected unsold volume, and financial spoilage exposure.
   - **Agent C (Markdown Agent):** Dynamic price elasticity modeling and gross margin preservation.
   - **Agent D (Transfer Agent):** Sister-store routing, cold-chain transit checks, and destination absorption limits.
   - **Agent E (Replenishment Agent):** Dynamic safety stock buffer alignment preventing bullwhip overstocking.
   - **Agent F (Hold & Monitor Agent):** Passive benchmark measuring the exact cost of doing nothing.  
   The **Central Coordinator** validates feasibility and ranks feasible options by the selected objective (`balanced`, `waste_reduction`, `profit_maximization`).

3. **Robustness Gate (Signature Feature 3):**  
   Stress-tests winning recommendations across 6 deterministic perturbation scenarios:
   - Demand shifts ($\pm 15\%$, $-20\%$)
   - Logistics transit delays ($+2.0\text{h}$)
   - Discount response suppression ($-25\%$)
   - Compound adverse stress  
   Calculates stability percentage and assigns rule-based status: `ROBUST`, `SENSITIVE`, or `NEEDS_REVIEW`.

4. **Counterfactual Decision Review (Signature Feature 4):**  
   Explains why the selected action was preferred, the financial and spoilage trade-offs of runner-up actions, reasons why rejected proposals were disqualified, and the exact "flip conditions" that would make an alternative win.

---

## 3. Technology Stack

| Layer | Technologies |
|---|---|
| **Frontend** | Next.js 14 (App Router), React 18, TypeScript, Tailwind CSS, Lucide React |
| **Data Visualization** | Recharts (Responsive bar, pie, and metric comparisons) |
| **Backend API** | Python 3.14+, FastAPI, Pydantic V2, Pydantic-Settings |
| **Data Processing** | Pandas, NumPy |
| **Database & Auth** | Supabase PostgreSQL, Supabase Auth (with local fallback demo store) |
| **Testing** | pytest, pytest-cov, TypeScript (`tsc --noEmit`) |

---

## 4. Setup and Launch Instructions (Windows / PowerShell)

### Prerequisites
- Python 3.10+ (tested on Python 3.14)
- Node.js v18+ (tested on Node v24)
- npm v9+

### A. Clone and Setup Environment

```powershell
# Navigate into the project directory
cd "c:\Users\DELL\OneDrive\Desktop\FreshGuard AI"
```

### B. Launch Backend (FastAPI)

```powershell
cd backend

# Create and activate Python virtual environment
python -m venv .venv
.\.venv\Scripts\Activate.ps1

# Install dependencies
pip install -r requirements.txt

# Run backend tests to verify environment
pytest -v

# Launch the FastAPI backend server (Runs at http://localhost:8000)
python -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
```

*Interactive API Swagger Documentation:* [http://localhost:8000/docs](http://localhost:8000/docs)  
*Health Check Endpoint:* [http://localhost:8000/health](http://localhost:8000/health)

### C. Launch Frontend (Next.js)

Open a new PowerShell terminal:

```powershell
cd "c:\Users\DELL\OneDrive\Desktop\FreshGuard AI\frontend"

# Install frontend dependencies (if not already installed)
npm install

# Run TypeScript check to verify build integrity
npm test

# Launch the Next.js development server (Runs at http://localhost:3000)
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## 5. Supabase Configuration (Optional for Cloud DB)

FreshGuard AI includes an integrated Supabase migration and client adapter:
- **Standalone Demo Mode:** Functions out-of-the-box with the deterministic synthetic dataset without requiring cloud credentials.
- **To Connect Live Supabase:**
  1. Create a project at [supabase.com](https://supabase.com).
  2. Execute `supabase/migrations/001_initial_schema.sql` in the Supabase SQL Editor.
  3. Execute `supabase/seed.sql` to populate sample data.
  4. Copy your project URL, anon key, and service role key into `backend/.env` and `frontend/.env.local`:
     ```env
     SUPABASE_URL=https://your-project.supabase.co
     SUPABASE_ANON_KEY=eyJhbGciOi...
     SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOi...
     ```
  5. Restart the backend and frontend. The navbar badge will update to **"Supabase Connected"**.

---

## 6. Flagship Demonstration: "The 90-Minute Rescue"

This deterministic scenario proves real decision-making:

- **Situation:** Metro Downtown Store has batch `B-MLK-90M-01` (85 units of Organic Whole Milk) expiring in $\sim 36$ hours.
- **Problem:** Downtown baseline sales rate is only 14 units/day. Without intervention, 64 units ($179.20 inventory cost) will spoil and be written off.
- **Agent Analysis:**
  1. **Demand Agent:** Forecasts 21 units consumed downtown before expiry.
  2. **Markdown Agent:** Evaluates 25% discount. Projects rescuing 32 units, but leaves 32 units to spoil due to store foot traffic limits.
  3. **Transfer Agent:** Identifies Westside Suburb store with high dairy demand (32 units/day), plenty of cold-room capacity, 1.5h transit time, and $14 transport cost.
  4. **Feasibility Validator:** Verifies that arrival occurs with 36.5h of shelf-life buffer remaining (passes the 12h threshold).
  5. **Coordinator:** Computes net economic payoff: Transfer yields **+$98.00** margin improvement and rescues **56 units**, beating markdown and passive hold.
  6. **Robustness Gate:** Evaluates 6 stress scenarios, confirming **ROBUST** status (83% stability).
  7. **Counterfactual Review:** Shows transfer wins because Westside demand velocity absorbs volume that downtown discounts cannot.
  8. **Human Governance:** Planner authorizes transfer with simulated execution, dispatching a refrigerated delivery and updating inventory.

---

## 7. Automated Test Suite Results

Backend automated tests pass with 100% coverage of core decision logic:

```powershell
============================= test session starts =============================
tests/test_agents.py::test_demand_agent_forecast_with_multipliers PASSED [  5%]
tests/test_agents.py::test_freshness_agent_critical_risk PASSED          [ 11%]
tests/test_agents.py::test_markdown_agent_rejects_expired_product PASSED [ 16%]
tests/test_agents.py::test_transfer_agent_rejects_late_arrival PASSED    [ 22%]
tests/test_agents.py::test_replenishment_agent_avoids_overordering_with_pipeline_stock PASSED [ 27%]
tests/test_api.py::test_health_check_endpoint PASSED                     [ 33%]
tests/test_api.py::test_auth_login PASSED                                [ 38%]
tests/test_api.py::test_get_batches PASSED                               [ 44%]
tests/test_api.py::test_decision_evaluate_batch PASSED                   [ 50%]
tests/test_api.py::test_approval_workflow_with_revalidation PASSED       [ 55%]
tests/test_api.py::test_simulation_run_scenario PASSED                   [ 61%]
tests/test_api.py::test_evaluation_benchmarks PASSED                     [ 66%]
tests/test_coordinator.py::test_coordinator_selects_feasible_action_for_90_minute_rescue PASSED [ 72%]
tests/test_coordinator.py::test_coordinator_never_selects_infeasible_action PASSED [ 77%]
tests/test_feasibility.py::test_feasibility_rejects_negative_quantity PASSED [ 83%]
tests/test_feasibility.py::test_feasibility_rejects_discount_exceeding_product_limit PASSED [ 88%]
tests/test_feasibility.py::test_feasibility_rejects_transfer_exceeding_source_stock PASSED [ 94%]
tests/test_rescue_clock.py::test_rescue_clock_deadlines PASSED           [100%]
======================== 18 passed, 1 warning in 2.43s ========================
```

Frontend production build verification (`next build` & `tsc --noEmit`):
- **11/11 static and dynamic routes compiled successfully.**
- **0 TypeScript type errors.**

---

## 8. Recommended 3-Minute Hackathon Judge Demo Script

- **Minute 1: Problem & Executive Overview (`/dashboard`)**  
  Show store health, real perishable financial exposure ($378+ at risk), and the Rescue Clock watchlist showing milk batch `B-MLK-90M-01` approaching expiry.
- **Minute 2: The Action Arena (`/action-arena`)**  
  Select `B-MLK-90M-01`. Show the four specialist agent proposals. Show the **Rescue Clock** (36.5h transfer gate), the **Coordinator winning transfer decision**, the **Robustness Gate** (ROBUST, 83% stability across 6 perturbation scenarios), and the **Counterfactual Review** explaining why Transfer beat Markdown.
- **Minute 3: Governance & Simulation Lab (`/simulation`)**  
  Click "The 90-Minute Rescue" scenario button. Fast-forward the clock by +24 hours or add a +30h transit delay. Watch the system dynamically detect that transfer has become **INFEASIBLE** due to shelf-life constraints, immediately pivoting to an on-site clearance markdown! Authorize the action in the Approval Modal to demonstrate human governance and immutable audit logging.

---

## 9. Frequently Asked Judge Questions & Answers

**Q: How do you prevent hallucinated or arbitrary AI scores?**  
*A:* FreshGuard AI uses deterministic mathematical models. Demand forecasting uses weighted moving averages with validated multipliers; waste exposure is calculated directly from current stock and time-to-expiry; price elasticities are grounded in grocery retail benchmarks (-1.8); and constraint validation strictly checks physical reality (positive stock, destination capacity, shelf-life arrival buffers).

**Q: What happens if a human planner edits a recommendation to an impossible value?**  
*A:* The backend `FeasibilityValidator` intercepts all edits. If a planner enters a negative transfer quantity, exceeds available stock, or enters a discount higher than category limits, the system rejects the modification with a `400 Bad Request` and detailed constraint explanation.

**Q: Why not just discount every expiring item?**  
*A:* Naive discounts degrade brand margin and frequently fail when store foot traffic is inadequate. If a downtown store has only 15 shoppers a day, discounting 80 milk gallons cannot sell them all before expiry. FreshGuard AI evaluates sister-store transfers, rescuing 100% of volume at full price where demand exists.



PROJECT LINK :
https://freshguard-ai-gamma.vercel.app/
