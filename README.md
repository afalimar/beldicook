# 🍽️ Restaurant Management System - Al Baraka

Système kamel dyal gestion restaurant b'Darija. Kay-3awd POS + Kitchen Display + App Livreur, koulchi real-time, b'Supabase comme backend.

---

## 📦 L'Files

### **SQL Files (Backend)**

| File | Ach kay-dir? | Order |
|------|--------------|-------|
| `restaurant_schema.sql` | Schema principal: 9 tables + triggers + sample data | 1️⃣ Awel |
| `modifiers_schema.sql` | Extension: 3 tables dyal modifiers | 2️⃣ Thani |
| `delivery_trigger.sql` | Trigger auto-create delivery + view | 3️⃣ Thaleth |
| `rls_policies.sql` | Security policies (⚠️ SKIP daba l'testing) | Skip |

### **HTML Apps (Frontend)**

| File | Usage | Device |
|------|-------|--------|
| `pos_caisse_v2.html` | POS l'caisse - prise de commandes | Tablette/PC |
| `kitchen_display.html` | Kitchen Display l'couzina | Tablette |
| `app_livreur.html` | App livreur - PWA installable | Phone |
| `test_supabase.html` | Test connexion Supabase (debug) | PC |
| `pos_caisse.html` | Version 1 (qbel customer info) | Archive |

---

## 🚀 Setup Kaml (45 دقائق)

### **Step 1: Crée Supabase Project**

1. Sir l https://supabase.com → Sign Up b'GitHub
2. New Project:
   - Name: `restaurant-pos`
   - Region: `West EU (Ireland)`
   - Password: **strong password, sejjlo!**
3. Stenna 2-3 min bach project y-wjed

### **Step 2: Run SQL Files**

F'Supabase → SQL Editor → New Query, run b'tartib:

```
1. restaurant_schema.sql  (Awel!)
2. modifiers_schema.sql
3. delivery_trigger.sql
```

⚠️ **Ma t-run-ch `rls_policies.sql` daba!**

### **Step 3: Khdem API Keys**

Settings → API → copy:
- **Project URL** (https://xxx.supabase.co)
- **Anon key** (eyJhbGc...)

### **Step 4: Enable Realtime (Mouhim!)**

Database → **Replication** → Toggle ON l'had tables:
- ✅ `orders`
- ✅ `deliveries`

### **Step 5: Disable RLS Temporaire**

Table Editor → 🛡️ "Disable RLS" l':
- `menu_items`, `ingredients`, `orders`, `order_items`, `deliveries`

### **Step 6: Test b'`test_supabase.html`**

Baddel keys f'code, run f'browser, click "Test Menu".

---

## 🎬 Demo Scenario Kaml

### **Setup 3 tabs:**

1. **Tab 1:** `pos_caisse_v2.html`
2. **Tab 2:** `kitchen_display.html`
3. **Tab 3:** `app_livreur.html`

### **L'Workflow:**

**POS:**
1. Add plats
2. Click "Livraison"
3. 3mer customer info
4. Submit

**Kitchen:**
- 🔔 Notification automatic
- "Bdit n-sa(h)bha" → "Wjdat ✓"

**Livreur:**
- 🔔 Notification automatic
- "Qbel" → "Picked up" → "En route" → "Slemt"

---

## ✨ Features 3andek

- POS m3a customer info + categories
- Kitchen Display real-time + timers
- App Livreur PWA installable
- Stock deduction automatic
- 12 tables relationally normalized
- Multi-tenant ready

---

## 🛠️ Production Checklist

### **Qbel Pilot:**
- [ ] Login page (auth)
- [ ] Re-enable RLS
- [ ] Deploy l'cloud (Netlify/Vercel)
- [ ] Hardware setup
- [ ] Wifi check f'restaurant

### **Nice to have:**
- [ ] Print ticket couzina
- [ ] Modifiers UI
- [ ] Dashboard manager
- [ ] Offline mode
- [ ] SMS notifications

---

## 📊 Costs

### **Free Tier:**
- Supabase: **0 MAD**
- Hosting: **0 MAD**
- **Total: 0 MAD/chahr**

### **Scale (1000+ orders/youm):**
- Supabase Pro: ~250 MAD/chahr
- Domain: ~150 MAD/year

### **Hardware:**
- Tablette × 2: ~3,500 MAD
- Stands: ~200 MAD

---

## 🆘 Troubleshooting

| Problem | Solution |
|---------|----------|
| "Loading..." infinite | Check console F12, probablement RLS |
| Realtime ma kay-khdem | Database → Replication → enable |
| Stock ma tnaqes | Re-run trigger men schema.sql |
| Modal ma kay-ban | Sta3mel pos_caisse_v2.html |
| Sound iOS ma tseme3 | Click sound toggle awel marra |

---

## 🎯 Next Steps

1. **Pilot test** 1-2 semana
2. **Collect feedback** men staff
3. **Fix priorities** based 3la real usage
4. **Iterate** features li khass

Bonne chance khouya! 🚀
