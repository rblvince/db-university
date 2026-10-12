-- Dipartimenti dell'università. Ogni dipartimento ha più corsi di laurea (1:N con degrees).
CREATE TABLE departments (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  address VARCHAR(255),
  phone VARCHAR(20),
  email VARCHAR(255),
  website VARCHAR(255)
);

-- Corsi di laurea. Ognuno appartiene a un solo dipartimento (N:1 con departments).
CREATE TABLE degrees (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  department_id BIGINT UNSIGNED NOT NULL,
  name VARCHAR(100) NOT NULL,
  level VARCHAR(50) NOT NULL, -- es. triennale, magistrale
  email VARCHAR(255),
  website VARCHAR(255),
  FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- Corsi (insegnamenti). Ognuno appartiene a un solo corso di laurea (N:1 con degrees).
CREATE TABLE courses (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  degree_id BIGINT UNSIGNED NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  period VARCHAR(50), -- es. I semestre
  year TINYINT UNSIGNED NOT NULL, -- anno di corso
  cfu TINYINT UNSIGNED NOT NULL, -- crediti formativi
  FOREIGN KEY (degree_id) REFERENCES degrees(id)
);

-- Insegnanti. Il legame con i corsi sta nella tabella ponte course_teacher.
CREATE TABLE teachers (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  phone VARCHAR(20),
  email VARCHAR(255)
);

-- Tabella ponte N:N tra courses e teachers: un corso ha più insegnanti, un insegnante più corsi.
-- La chiave primaria doppia impedisce di inserire due volte la stessa coppia.
CREATE TABLE course_teacher (
  course_id BIGINT UNSIGNED NOT NULL,
  teacher_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (course_id, teacher_id),
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

-- Appelli d'esame. Un corso ha più appelli (1:N con courses).
CREATE TABLE exams (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  course_id BIGINT UNSIGNED NOT NULL,
  date DATE NOT NULL,
  hour TIME NOT NULL,
  location VARCHAR(255) NOT NULL,
  FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Studenti. Ognuno è iscritto a un solo corso di laurea (N:1 con degrees).
-- Codice fiscale, matricola ed email sono unici.
CREATE TABLE students (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  degree_id BIGINT UNSIGNED NOT NULL,
  name VARCHAR(50) NOT NULL,
  surname VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  fiscal_code CHAR(16) NOT NULL UNIQUE,
  registration_number VARCHAR(20) NOT NULL UNIQUE, -- matricola
  email VARCHAR(255) NOT NULL UNIQUE,
  FOREIGN KEY (degree_id) REFERENCES degrees(id)
);

-- Tabella ponte N:N tra exams e students, con il voto.
-- vote NULL = iscritto all'appello ma non ha partecipato; un numero = ha partecipato (anche se insufficiente).
CREATE TABLE exam_student (
  exam_id BIGINT UNSIGNED NOT NULL,
  student_id BIGINT UNSIGNED NOT NULL,
  vote TINYINT UNSIGNED NULL,
  PRIMARY KEY (exam_id, student_id),
  FOREIGN KEY (exam_id) REFERENCES exams(id),
  FOREIGN KEY (student_id) REFERENCES students(id)
);
