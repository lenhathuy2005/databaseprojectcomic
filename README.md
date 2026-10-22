# Comic Cultivation database schema

`schema.sql` contains the database structure without account, token, or payment rows. Import it into an empty MariaDB database, then import `seed-reference.sql` for roles and other static reference data. Apply any backend migrations after that.

Keep full database exports outside Git. The original export remains available only in the local working directory as `comic_cultivation_system (2).sql`.
