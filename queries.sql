-- db-university: query con SELECT (esercizio Boolean del 13/10/2026)

-- 1. Studenti nati nel 1990 (160)
SELECT * FROM students WHERE YEAR(date_of_birth) = 1990;

-- 2. Corsi che valgono più di 10 crediti (479)
SELECT * FROM courses WHERE cfu > 10;

-- 3. Studenti che hanno più di 30 anni
SELECT * FROM students WHERE TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) > 30;

-- 4. Corsi del primo semestre del primo anno (286)
SELECT * FROM courses WHERE period = 'I semestre' AND year = 1;

-- 5. Appelli del pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * FROM exams WHERE date = '2020-06-20' AND hour >= '14:00:00';

-- 6. Corsi di laurea magistrale (38)
SELECT * FROM degrees WHERE level = 'magistrale';

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(*) AS numero_dipartimenti FROM departments;

-- 8. Insegnanti senza numero di telefono (50)
SELECT COUNT(*) AS insegnanti_senza_telefono FROM teachers WHERE phone IS NULL;
