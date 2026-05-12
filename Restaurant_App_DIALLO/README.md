# 🍽️ LES DÉLICES CHEZ DIALLO
## Application de Gestion de Restaurant Ivoirien

**Adapté par : DIALLO CHEICK**  
**Base :** Application React + Redux + NodeJS + ExpressJS + Sequelize

---

## 📋 Description

Application complète de gestion pour le restaurant **"LES DÉLICES CHEZ DIALLO"**,
spécialisé dans la cuisine ivoirienne authentique.

### Menu inclus :
- 🍱 Plats Traditionnels : Garba, Placali, Foutou, Kedjenou...
- 🔥 Grillades & Braisés : Poisson braisé, Poulet braisé, Tilapia...
- 🌿 Accompagnements : Alloco, Attiéké, Igname...
- 🥣 Soupes & Sauces : Soupe de poisson, Sauce graine...
- 🥤 Boissons : Bissap, Gnamankoudji, Bangui...
- 🍌 Desserts : Beignets de banane, Ananas...

---

## 🚀 Installation

### Prérequis
- Node.js ≥ 18
- MySQL
- npm

### Backend
```bash
cd backend
npm install
# Configurer .env (voir backend/.env)
# Importer la base de données :
# mysql -u root -p < database/les_delices_chez_diallo.sql
npm start
```

### Frontend
```bash
cd frontend
npm install
npm start
```

---

## 🔐 Connexion par défaut
- **Email :** diallo@delices.ci
- **Mot de passe :** admin123

---

## 🗄️ Base de données
Fichier SQL : `backend/database/les_delices_chez_diallo.sql`
- 6 catégories de plats
- 45 produits du menu ivoirien
- 12 tables (dont terrasse et VIP)
- Rôles : Administrateur, Serveur, Cuisinier, Caissier

---

© 2024 LES DÉLICES CHEZ DIALLO — DIALLO CHEICK
