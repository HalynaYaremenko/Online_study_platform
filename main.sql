
-- створюємо таблицю студентів
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    full_name  TEXT NOT NULL,
    city       TEXT,
    reg_date   DATE
);

-- створюємо таблицю викладачів
CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    full_name     TEXT NOT NULL,
    specialization TEXT
);

-- створюємо таблицю курсів
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name TEXT NOT NULL,
    category    TEXT,
    instructor_id INT REFERENCES instructors(instructor_id)
);

-- створюємо таблицю — записи студентів на курси
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id  INT REFERENCES courses(course_id),
    enroll_date DATE
);

-- створюємо таблицю — прогрес студентів
CREATE TABLE progress (
    progress_id SERIAL PRIMARY KEY,
    enrollment_id INT REFERENCES enrollments(enrollment_id),
    lesson_number INT,
    score NUMERIC(5,2),     -- оцінка за урок
    completed BOOLEAN
);

-- INSERT даних у таблиці ---

-- заповнюємо таблицю студентів

INSERT INTO students (full_name, city, reg_date) VALUES
('Anna Kovalenko', 'Kyiv', '2024-01-12'),
('Dmytro Shevchenko', 'Lviv', '2024-02-05'),
('Olena Bondar', 'Kharkiv', '2024-03-18'),
('Serhii Melnyk', 'Odesa', '2024-01-25'),
('Iryna Tkachenko', 'Dnipro', '2024-04-02'),
('Maksym Horbunov', 'Kyiv', '2024-02-20'),
('Kateryna Polishchuk', 'Lviv', '2024-03-01'),
('Yurii Kravets', 'Kharkiv', '2024-03-22'),
('Sofiia Levchenko', 'Odesa', '2024-04-10'),
('Vladyslav Chernenko', 'Kyiv', '2024-01-30');

-- заповнюємо таблицю викладачів

INSERT INTO instructors (full_name, specialization) VALUES
('Oleh Marchenko', 'Data Science'),
('Tetiana Ivanova', 'Web Development'),
('Roman Sydorenko', 'Machine Learning'),
('Natalia Hlushko', 'UI/UX Design'),
('Andrii Petrenko', 'Databases');

-- заповнюємо таблицю курсів

INSERT INTO courses (course_name, category, instructor_id) VALUES
('Python for Beginners', 'Programming', 1),
('Data Analysis with SQL', 'Data Science', 5),
('Machine Learning Basics', 'Machine Learning', 3),
('Frontend Development with React', 'Web Development', 2),
('UI/UX Fundamentals', 'Design', 4),
('Advanced SQL Analytics', 'Data Science', 5),
('Deep Learning Intro', 'Machine Learning', 3),
('JavaScript Essentials', 'Programming', 2);

-- заповнюємо таблицю — записи студентів на курси

INSERT INTO enrollments (student_id, course_id, enroll_date) VALUES
(1, 1, '2024-02-01'),
(1, 2, '2024-02-10'),
(2, 2, '2024-02-15'),
(2, 4, '2024-03-01'),
(3, 3, '2024-03-20'),
(3, 6, '2024-03-25'),
(4, 1, '2024-02-05'),
(4, 5, '2024-04-01'),
(5, 2, '2024-04-05'),
(5, 7, '2024-04-12'),
(6, 4, '2024-03-10'),
(7, 5, '2024-03-15'),
(8, 6, '2024-04-02'),
(9, 3, '2024-04-15'),
(10, 1, '2024-02-20');

-- заповнюємо таблицю — прогрес студентів

-- Для кожного enrollment_id створюю кілька уроків із оцінками та статусом.

INSERT INTO progress (enrollment_id, lesson_number, score, completed) VALUES
-- Enrollment 1 (Anna, Python)
(1, 1, 85, TRUE),
(1, 2, 90, TRUE),
(1, 3, 88, TRUE),

-- Enrollment 2 (Anna, SQL)
(2, 1, 92, TRUE),
(2, 2, 87, TRUE),
(2, 3, 95, TRUE),

-- Enrollment 3 (Dmytro, SQL)
(3, 1, 78, TRUE),
(3, 2, 82, TRUE),
(3, 3, 80, FALSE),

-- Enrollment 4 (Dmytro, React)
(4, 1, 88, TRUE),
(4, 2, 90, TRUE),

-- Enrollment 5 (Olena, ML)
(5, 1, 91, TRUE),
(5, 2, 89, TRUE),
(5, 3, 93, TRUE),

-- Enrollment 6 (Olena, Advanced SQL)
(6, 1, 85, TRUE),
(6, 2, 87, TRUE),

-- Enrollment 7 (Serhii, Python)
(7, 1, 70, TRUE),
(7, 2, 75, FALSE),

-- Enrollment 8 (Serhii, UI/UX)
(8, 1, 95, TRUE),
(8, 2, 97, TRUE),

-- Enrollment 9 (Iryna, SQL)
(9, 1, 88, TRUE),
(9, 2, 92, TRUE),
(9, 3, 90, TRUE),

-- Enrollment 10 (Iryna, Deep Learning)
(10, 1, 84, TRUE),
(10, 2, 86, TRUE),

-- Enrollment 11 (Maksym, React)
(11, 1, 80, TRUE),
(11, 2, 82, TRUE),

-- Enrollment 12 (Kateryna, UI/UX)
(12, 1, 98, TRUE),
(12, 2, 96, TRUE),

-- Enrollment 13 (Yurii, Advanced SQL)
(13, 1, 75, TRUE),
(13, 2, 78, TRUE),

-- Enrollment 14 (Sofiia, ML)
(14, 1, 89, TRUE),
(14, 2, 91, TRUE),
(14, 3, 94, TRUE),

-- Enrollment 15 (Vladyslav, Python)
(15, 1, 82, TRUE),
(15, 2, 85, TRUE),
(15, 3, 88, TRUE);

-- Задача 1. Базові SELECT --

-- 1. Вивести всіх студентів, які зареєструвалися після 2024‑01‑01.

SELECT * 
  FROM students
 WHERE reg_date > DATE('2024-01-01')
 ORDER BY reg_date;

-- 2. Вивести всі курси категорії `"Data Science"`.

SELECT * 
  FROM courses
 WHERE category = 'Data Science';

-- Задача 2. Групування та агрегація --

-- 1. Порахувати кількість студентів у кожному місті.

SELECT city,
       COUNT (*) AS count_student 
  FROM students
 GROUP BY city
 ORDER BY count_student;

-- 2. Порахувати кількість курсів у кожній категорії.

SELECT category,
       COUNT(*) AS count_course 
  FROM courses
  GROUP BY category;

-- 3. Порахувати середню оцінку по кожному курсу.

SELECT c.course_name,
       ROUND(AVG(p.score),2) AS avg_score
  FROM progress p
  JOIN enrollments e ON e.enrollment_id = p.enrollment_id
  JOIN courses c ON c.course_id = e.course_id
  GROUP BY c.course_name
  ORDER BY avg_score DESC;

-- Задача 3. JOIN‑аналіз --

-- 1. Вивести список курсів разом з іменами викладачів.

SELECT c.course_name,
       i.full_name
  FROM courses c
  JOIN instructors i ON c.instructor_id = i.instructor_id;

-- 2. Вивести студентів та назви курсів, на які вони записані.

SELECT s.full_name,
       c.course_name
  FROM students s
  JOIN enrollments e ON s.student_id = e.student_id
  JOIN courses c ON e.course_id = c.course_id;

-- 3. Порахувати, скільки студентів у кожного викладача.

SELECT i.full_name,
       COUNT(DISTINCT e.student_id) AS count_students
  FROM enrollments e
  JOIN courses c ON c.course_id = e.course_id
  JOIN instructors i ON i.instructor_id = c.instructor_id
GROUP BY i.full_name
ORDER BY count_students DESC;

-- Задача 4. Аналітика прогресу --

-- 1. Порахувати середню оцінку кожного студента.

SELECT s.full_name,
       ROUND(AVG(p.score),2) AS avg_score
  FROM progress p
  JOIN enrollments e ON p.enrollment_id = e.enrollment_id
  JOIN students s ON s.student_id = e.student_id
  GROUP BY s.full_name
  ORDER BY avg_score DESC;

-- 2. Порахувати відсоток завершених уроків для кожного курсу.

SELECT c.course_name,
       ROUND((SUM(CASE WHEN p.completed = 'TRUE' THEN 1 ELSE 0 END)
             / COUNT(*)) * 100,2)  AS completed_percent
  FROM progress p
  JOIN enrollments e ON p.enrollment_id = e.enrollment_id
  JOIN courses c ON c.course_id = e.course_id
GROUP BY c.course_name

-- 3. Знайти студентів, які завершили всі уроки у своїх курсах.

-- Задача 5. Віконні функції --

-- 1. Для кожного курсу визначити рейтинг студентів за середнім балом.


-- 2. Порахувати кумулятивну кількість уроків, завершених студентом у хронологічному порядку.


-- 3. Для кожної категорії курсів знайти топ‑1 курс за кількістю студентів.
