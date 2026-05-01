create database holi;
use holi;

-- Tạo bảng
CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL CHECK (salary >= 0)
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    teacher_id INT NULL,
    credits INT CHECK (credits > 0),
    tuition_fee DECIMAL(10,2) CHECK (tuition_fee >= 0),
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other'))
);

CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    date DATE,
    score DECIMAL(4,2) NULL CHECK (score BETWEEN 0 AND 10),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- Dữ liệu teachers
INSERT INTO teachers (full_name, salary) VALUES
('Nguyen Van A', 1000),
('Tran Thi B', 1200),
('Le Van C', 1100);

-- Dữ liệu courses
INSERT INTO courses (course_name, teacher_id, credits, tuition_fee) VALUES
('IT Basic', 1, 3, 300),
('Advanced IT', 1, 4, 500),
('Database Systems', 2, 3, 400),
('Networking', 2, 3, 350),
('Mathematics', 3, 2, 200),
('Unassigned Course', NULL, 3, 250);

-- Dữ liệu students
INSERT INTO students (full_name, date_of_birth, gender) VALUES
('Student 1', '2000-01-01', 'Male'),
('Student 2', '2000-02-02', 'Female'),
('Student 3', '2000-03-03', 'Male'),
('Student 4', '2000-04-04', 'Female'),
('Student 5', '2000-05-05', 'Male'),
('Student 6', '2000-06-06', 'Female'),
('Student 7', '2000-07-07', 'Male'),
('Student 8', '2000-08-08', 'Female'),
('Student 9', '2000-09-09', 'Male'),
('Student 10', '2000-10-10', 'Female');

-- Dữ liệu enrollments 2 chưa có điểm
INSERT INTO enrollments (student_id, course_id, date, score) VALUES
(1,1,'2025-01-01',8),
(2,1,'2025-01-01',7),
(3,2,'2025-01-02',9),
(4,2,'2025-01-02',6),
(5,3,'2025-01-03',8.5),
(6,3,'2025-01-03',7.5),
(7,4,'2025-01-04',9),
(8,4,'2025-01-04',8),
(9,5,'2025-01-05',7),
(10,5,'2025-01-05',6),
(1,2,'2025-01-06',NULL),
(2,3,'2025-01-06',NULL),
(3,4,'2025-01-07',8),
(4,5,'2025-01-07',7),
(5,1,'2025-01-08',9);

-- Tăng lương 10% 
UPDATE teachers
SET salary = salary * 1.1
WHERE id IN (
    SELECT DISTINCT teacher_id
    FROM courses
    WHERE course_name LIKE '%IT%'
);
