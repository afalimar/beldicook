# 🍽️ Restaurant POS - Guide Sahel

## 📦 Files Kayna (14 files)

### **SQL Files (Supabase) - 5 files:**
1. `restaurant_schema.sql` - Database structure
2. `modifiers_schema.sql` - Modifiers extension
3. `delivery_trigger.sql` - Delivery automation
4. `auth_setup.sql` - Authentication setup
5. `rls_policies.sql` - Security (later)

### **HTML Files (Apps) - 7 files:**
1. `login.html` - Login page
2. `admin_panel.html` - Admin (manage staff)
3. `pos_caisse_v2.html` - POS Caisse (use this)
4. `kitchen_display.html` - Kitchen display
5. `app_livreur.html` - App livreur (PWA)
6. `test_supabase.html` - Connection test
7. `pos_caisse.html` - Old version (skip)

### **Documentation - 2 files:**
1. `README.md` - General readme
2. `BRIEF_FREELANCER.md` - For freelancers

---

## 🎯 Tartib Dyal Setup

### **Step 1: Run SQL Files f'Supabase**

⚠️ **Tartib MOUHIM!** Run b'tartib hada exactement:

#### **1.1 - restaurant_schema.sql** (AWEL!)
- Fte7 file f'TextEdit
- Cmd+A → Cmd+C
- F'Supabase SQL Editor: paste → Run
- Khassek t-chouf: ✅ "Success"

#### **1.2 - modifiers_schema.sql**
- Same process
- ✅ Success

#### **1.3 - delivery_trigger.sql**
- Same process
- ✅ Success

⚠️ **MA T-RUN-CH had files daba:**
- ❌ `auth_setup.sql` (later - mnin baghi auth)
- ❌ `rls_policies.sql` (later - mnin baghi security)

---

### **Step 2: Khdem Keys**

F'Supabase:
- Settings (icon ⚙️) → API
- Copy:
  - **Project URL:** `https://xxxxx.supabase.co`
  - **anon public key:** `eyJhbGc...`

---

### **Step 3: Disable RLS Temporaire**

F'Supabase:
- Table Editor (icon 📊) → Click 3la table
- Click 🛡️ button → "Disable RLS"

Tables li khassek t-disabli RLS:
- `menu_items`
- `ingredients`
- `orders`
- `order_items`
- `deliveries`

---

### **Step 4: Test Connexion**

3la Mac:
- Fte7 `test_supabase.html` f'browser
- Edit file (TextEdit) → baddel:
  ```javascript
  const SUPABASE_URL = 'https://YOUR-URL.supabase.co';
  const SUPABASE_ANON_KEY = 'YOUR-ANON-KEY';
  ```
- Save
- Reload browser
- Click "Test: Fetch Menu"
- ✅ Khassek t-chouf 3 plats: Tajine Djaj, Couscous Kheddra, Pastilla

---

### **Step 5: Test POS**

3la Mac:
- Fte7 `pos_caisse_v2.html`
- Awel marra: paste URL + Anon Key
- Click "Save & Connect"
- Test: add plat → submit order

---

## ❌ Errors Common

### **"relation public.users does not exist"**
→ Ma run-tich `restaurant_schema.sql` baqi.
→ Solution: run-h awel.

### **"function uuid_generate_v4() does not exist"**
→ Awel sutour dyal SQL ma t-run-ch.
→ Solution: re-run kollchi.

### **"Loading..." infinite f'POS**
→ RLS active 3la `menu_items`.
→ Solution: disable RLS f'Table Editor.

---

## 🆘 Ila Stuck

1. Ferm tab → fte7 jdid
2. Re-paste keys
3. Verify tables mawjoudin: Table Editor → khass t-chouf 9-12 tables
4. Saqsi Claude m3a screenshot dyal error

---

**Bonne chance! 🚀**
