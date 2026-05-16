# 💊 AptiekasMap

> Tīmekļa platforma zāļu pieejamības noteikšanai tuvākajās aptiekās

**Autors:** Timurs Kvačovs  
**Skola:** Rīgas Valsts Tehnikums — Datorikas nodaļa  
**Modulis:** Datu bāzu programmēšana  
**Mācību gads:** 2025/2026

---

## 🌐 Publiskā piekļuve

| Resurss | URL |
|---------|-----|
| 🖥️ Tīmekļa vietne | [aptiekas-map.netlify.app](https://aptiekas-map.netlify.app) |
| ⚙️ Backend API | [majaslapa3kurss-production.up.railway.app](https://majaslapa3kurss-production.up.railway.app) |
| 📁 GitHub | [github.com/23DP3TKvac/Majaslapa_3kurss](https://github.com/23DP3TKvac/Majaslapa_3kurss) |

---

## 📋 Par projektu

AptiekasMap ir tīmekļa platforma, kas ļauj lietotājiem ātri atrast nepieciešamās zāles tuvākajās Rīgas aptiekās, salīdzināt to cenas un pieejamību reāllaikā.

### Problēma
Latvijā nav vienotas platformas, kas apvienotu dažādu aptieku datus vienā vietā. Esošie risinājumi (Zāles.lv, Apteka.lv, BENU) piedāvā tikai sava tīkla informāciju.

---

## �� Tehnoloģiju steks

| Slānis | Tehnoloģija |
|--------|-------------|
| Frontend | Vue.js 3 + Vuetify 3 + Pinia |
| Backend | Laravel 11 (PHP 8.4) |
| Datubāze | MySQL 8.0 |
| Autentifikācija | Laravel Sanctum (bcrypt) |
| Frontend hosting | Netlify |
| Backend hosting | Railway.app |

---

## ✨ Funkcionalitāte

- 🔍 Zāļu meklēšana pēc nosaukuma vai aktīvās vielas
- 🎛️ Paplašinātā filtrēšana pēc 6 kritērijiem vienlaikus
- 📍 Tuvākās aptiekas ar Google Maps saiti
- 💰 Cenu salīdzināšana pa aptiekām
- 🗺️ Reālās aptiekas no OpenStreetMap API
- 👤 Lietotāju reģistrācija ar lomu pārvaldību (admin/user/pharmacy_rep)
- 🔐 Aizsargāti maršruti — saturs tikai reģistrētiem lietotājiem
- 🛠️ Administrācijas panelis — CRUD zāļu pārvaldībai (tikai admin)
- 📊 Statistikas lapa ar datu vizualizāciju un lietotāju sarakstu (tikai admin)
- 🌙 Dark/Light mode

---

## 🗄️ Datubāze (MySQL 8.0)

6 tabulas: `users`, `medicines`, `pharmacies`, `availability`, `search_history`, `notifications`

---

## 👤 Testa lietotāji

| Loma | E-pasts | Parole |
|------|---------|--------|
| Admin | admin@aptiekasmap.lv | admin123 |
| Lietotājs | janis@gmail.com | user123 |
| Aptieka | benu@benu.lv | pharm123 |

---

## 📁 Projekta struktūra
---

## ⚙️ Lokālā palaišana (GitHub Codespaces)

### Katru reizi atverot Codespaces:

```bash
# 1. MySQL
sudo pkill -9 mysqld 2>/dev/null; sleep 1
sudo mkdir -p /var/run/mysqld && sudo chown mysql:mysql /var/run/mysqld
sudo mysqld_safe --user=mysql --skip-syslog &
sleep 5

# 2. Backend (Terminal 1)
cd aptiekasmap/backend
php artisan serve --host=0.0.0.0 --port=8001

# 3. Frontend (Terminal 2)
cd aptiekasmap/frontend
npm run dev
```

### Pirmreizēja uzstādīšana:

```bash
# MySQL datubāze
sudo mysql -u root -e "CREATE DATABASE aptiekas_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; CREATE USER 'aptiekas'@'localhost' IDENTIFIED BY 'secret123'; GRANT ALL PRIVILEGES ON aptiekas_db.* TO 'aptiekas'@'localhost'; FLUSH PRIVILEGES;"

# Backend
cd aptiekasmap/backend
php artisan key:generate
php artisan migrate:fresh --seed
```

---

## 📡 Galvenie API endpointi

| Metode | URL | Apraksts |
|--------|-----|----------|
| GET | `/api/medicines` | Zāļu saraksts ar filtrēšanu |
| GET | `/api/medicines/forms` | Pieejamās zāļu formas |
| GET | `/api/pharmacies` | Aptieku saraksts |
| GET | `/api/availability/{id}` | Pieejamība konkrētām zālēm |
| GET | `/api/statistics` | Statistikas dati |
| POST | `/api/auth/register` | Reģistrācija |
| POST | `/api/auth/login` | Pieslēgšanās |
| POST | `/api/medicines` | Pievienot zāles (admin) |
| PUT | `/api/medicines/{id}` | Labot zāles (admin) |
| DELETE | `/api/medicines/{id}` | Dzēst zāles (admin) |
| GET | `/api/admin/users` | Lietotāju saraksts (admin) |

---

© 2025/2026 Timurs Kvačovs — Rīgas Valsts Tehnikums
