# SQL Cookbook

Ce dossier regroupe des exemples pratiques de requêtes SQL, organisés par niveau de complexité.

L’objectif est de démontrer les compétences SQL essentielles pour l’analyse de données, avec une progression logique allant des requêtes de base jusqu’aux techniques plus avancées.

---

## Structure du dossier

    cookbook/
    ├── README.md
    ├── basics/
    │   ├── 01_basic_select_filter.sql
    │   ├── 02_joins.sql
    │   ├── 03_group_by_aggregations.sql
    │   └── 04_case_when.sql
    ├── intermediate/
    │   └── 05_ctes.sql
    └── advanced/

---

## Organisation par niveau

### `basics/`

Cette section couvre les fondamentaux SQL nécessaires pour :

- sélectionner des données
- filtrer et trier des résultats
- relier plusieurs tables
- agréger des données
- appliquer une logique métier simple

Contenu actuel :

- `01_basic_select_filter.sql` : sélection, filtrage, tri et limitation
- `02_joins.sql` : jointures entre plusieurs tables
- `03_group_by_aggregations.sql` : agrégations avec `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY` et `HAVING`
- `04_case_when.sql` : logique conditionnelle avec `CASE WHEN` pour créer des catégories et segments métier

### `intermediate/`

Cette section introduit des requêtes plus structurées pour :

- améliorer la lisibilité
- organiser les calculs intermédiaires
- préparer des analyses plus complexes

Contenu actuel :

- `05_ctes.sql` : utilisation des CTE (`Common Table Expressions`) pour rendre les requêtes plus lisibles et maintenables

### `advanced/`

Cette section accueillera des techniques plus avancées pour :

- approfondir l’analyse
- calculer des indicateurs plus élaborés
- améliorer la robustesse des requêtes

Contenu prévu :

- fonctions de fenêtre
- sous-requêtes avancées
- analyse temporelle
- calcul de KPI
- contrôles qualité des données

---

## Objectifs du cookbook

Ce cookbook montre comment utiliser SQL pour :

- extraire des données
- filtrer et trier des informations
- relier plusieurs tables
- agréger des données
- introduire une logique métier dans les requêtes
- structurer les analyses SQL
- préparer des jeux de données exploitables

---

## Approche

Chaque fichier contient des requêtes commentées avec un objectif précis.

L’idée n’est pas seulement de montrer la syntaxe SQL, mais aussi la manière de transformer des données brutes en informations utiles pour répondre à des questions métier simples.

---

## Notions déjà couvertes

- `SELECT`
- `WHERE`
- `ORDER BY`
- `LIMIT`
- `JOIN`
- `GROUP BY`
- fonctions d’agrégation
- `HAVING`
- `CASE WHEN`
- `CTE`

---

## Suite prévue

Les prochains fichiers qui viendront enrichir ce dossier sont notamment :

- `06_window_functions.sql`
- `07_subqueries.sql`
- `08_time_series_analysis.sql`
- `09_kpi_calculations.sql`
- `10_data_quality_checks.sql`
