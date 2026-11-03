-- db-university: query con JOIN (esercizio Boolean del 16/10/2026)

-- 1. Tutti gli studenti iscritti al Corso di Laurea in Economia (68)
SELECT students.* FROM students JOIN degrees ON degrees.id = students.degree_id WHERE degrees.name = 'Corso di Laurea in Economia';

-- 2. Tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze (1)
SELECT degrees.* FROM degrees JOIN departments ON departments.id = degrees.department_id WHERE degrees.level = 'magistrale' AND departments.name = 'Dipartimento di Neuroscienze';

-- 3. Tutti i corsi in cui insegna Fulvio Amato (id 44) (11)
SELECT courses.* FROM courses JOIN course_teacher ON course_teacher.course_id = courses.id WHERE course_teacher.teacher_id = 44;

-- 4. Tutti gli studenti con i dati del corso di laurea e del dipartimento, in ordine alfabetico per cognome e nome (5000)
SELECT students.surname AS cognome, students.name AS nome, students.registration_number AS matricola, students.email AS email_studente, degrees.name AS corso_di_laurea, degrees.level AS livello, degrees.address AS indirizzo_corso, degrees.email AS email_corso, degrees.website AS sito_corso, departments.name AS dipartimento, departments.address AS indirizzo_dipartimento, departments.head_of_department AS direttore FROM students JOIN degrees ON degrees.id = students.degree_id JOIN departments ON departments.id = degrees.department_id ORDER BY students.surname, students.name;

-- 5. Tutti i corsi di laurea con i relativi corsi e insegnanti (1317)
SELECT degrees.name AS corso_di_laurea, courses.name AS corso, teachers.surname AS cognome_insegnante, teachers.name AS nome_insegnante FROM degrees JOIN courses ON courses.degree_id = degrees.id JOIN course_teacher ON course_teacher.course_id = courses.id JOIN teachers ON teachers.id = course_teacher.teacher_id ORDER BY degrees.name, courses.name, teachers.surname, teachers.name;

-- 6. Tutti i docenti che insegnano nel Dipartimento di Matematica, senza duplicati (54)
SELECT DISTINCT teachers.id AS id_insegnante, teachers.surname AS cognome, teachers.name AS nome FROM teachers JOIN course_teacher ON course_teacher.teacher_id = teachers.id JOIN courses ON courses.id = course_teacher.course_id JOIN degrees ON degrees.id = courses.degree_id JOIN departments ON departments.id = degrees.department_id WHERE departments.name = 'Dipartimento di Matematica';

-- 7a. BONUS: per ogni studente, il numero di tentativi per ogni esame (corso) e il voto massimo (32246)
SELECT students.id AS id_studente, students.surname AS cognome, students.name AS nome, courses.name AS corso, COUNT(*) AS numero_tentativi, MAX(exam_student.vote) AS voto_massimo FROM exam_student JOIN students ON students.id = exam_student.student_id JOIN exams ON exams.id = exam_student.exam_id JOIN courses ON courses.id = exams.course_id GROUP BY students.id, students.surname, students.name, courses.id, courses.name;

-- 7b. BONUS: come la 7a, tenendo solo gli esami con voto massimo di almeno 18 (21880)
SELECT students.id AS id_studente, students.surname AS cognome, students.name AS nome, courses.name AS corso, COUNT(*) AS numero_tentativi, MAX(exam_student.vote) AS voto_massimo FROM exam_student JOIN students ON students.id = exam_student.student_id JOIN exams ON exams.id = exam_student.exam_id JOIN courses ON courses.id = exams.course_id GROUP BY students.id, students.surname, students.name, courses.id, courses.name HAVING MAX(exam_student.vote) >= 18;
