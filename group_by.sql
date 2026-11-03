-- db-university: query con GROUP BY (esercizio Boolean del 16/10/2026)

-- 1. Quanti iscritti ci sono stati ogni anno (4)
SELECT YEAR(enrolment_date) AS anno_iscrizione, COUNT(*) AS numero_iscritti FROM students GROUP BY YEAR(enrolment_date);

-- 2. Quanti insegnanti hanno l'ufficio nello stesso edificio (indirizzo dell'ufficio) (29)
SELECT office_address AS edificio, COUNT(*) AS numero_insegnanti FROM teachers GROUP BY office_address;

-- 3. Media dei voti di ogni appello d'esame (4078)
SELECT exam_id AS appello, AVG(vote) AS voto_medio FROM exam_student GROUP BY exam_id;

-- 4. Quanti corsi di laurea ci sono per ogni dipartimento (12)
SELECT department_id AS dipartimento, COUNT(*) AS numero_corsi_di_laurea FROM degrees GROUP BY department_id;
