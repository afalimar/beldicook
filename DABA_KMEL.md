# 🍽️ Al Baraka POS - DABA RAH WJED!

## ✅ Ach 3andek Daba

Database f'Supabase wjed (3 SQL files run-tihom successfully).

## 🎯 3 7ajat Lukhrin Khassek T-Diri:

### **1. Disable RLS** (5 min) ⚠️ MOUHIM

F'Supabase → **Table Editor** (icon dyal tablat f'sidebar gauche)

L'koul wahda men had 5 tables:
- `menu_items`
- `ingredients`  
- `orders`
- `order_items`
- `deliveries`

**Click 3la table → click 🛡️ button (RLS) → Disable RLS → Confirm**

Bla had step, POS ma kay-khdem-ch (kayban "Loading..." infinite).

---

### **2. Fte7 POS** (1 min)

3la Mac:
- Finder → Desktop → folder `restaurant-pos`
- Double-click 3la **`pos_caisse_v2.html`**

Awel marra ghadi y-s9sik:
- **Supabase URL:** paste (men Notes dyalek)
- **Anon Key:** paste (men Notes dyalek)
- Click **"Save & Connect"**

---

### **3. Test Workflow** (5 min)

✅ Khassek t-chouf 3 plats: Tajine Djaj, Couscous Kheddra, Pastilla

**Test sahel:**
1. Click 3la "Tajine Djaj" → kay-zid f'panier
2. Click 3la "Couscous Kheddra"
3. Click "Valider ↗"
4. Toast khder: "✓ Commande #X tsejjet!"

✅ **Ila chufti hadchi = MABROUK! POS dyalek KHDAM!** 🎉

---

## 🚨 Ila Kayn Mochkil

### **POS kay-show "Loading..." stop:**
→ RLS baqi active. Disable RLS l'5 tables (#1 above).

### **Erreur "JWT expired":**
→ Anon Key ghalat. Re-copy men Supabase Settings → API.

### **POS khdam mais ma t-banni-ch plats:**
→ Sample data ma tsejjlat-ch. F'Supabase → SQL Editor → run:
```sql
SELECT COUNT(*) FROM menu_items;
```
Ila returns 0, run derniere partie dyal restaurant_schema.sql 3awd.

---

## 📞 Saqsi M3aya Mnin Tsali

Sift-li:
- ✅ "POS khdam!" + screenshot
- ⚠️ "Mochkil X" + screenshot

Ana hna n-stenna! 🙏

---

## 🎯 Apps Lukhrin Mawjoudin

Mnin POS y-khdem mzyan, tqder t-fte7 had files (kay-7tagou nafs Supabase URL + Anon Key):

- **`kitchen_display.html`** - Display l'couzina (real-time orders)
- **`app_livreur.html`** - App l'livreur (PWA mobile)

L'apps lukhrin (`login.html`, `admin_panel.html`) khassom auth setup - **later mnin baghi**.

---

**Bonne chance khouya! 🚀**
