```bash
brew install postgresql@14

brew services start postgresql@14

psql --version

createdb transport_rent_db

psql -d transport_rent_db

\i 01_schema.sql
\i 02_seed_data.sql
```