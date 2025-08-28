-- ClinicEase Database
-- Author: Joseph Nguu Mutisya
-- Description: Clinic Appointment & Patient Management System
-- Normalized up to 3NF

-- Drop database if exists (for testing)
DROP DATABASE IF EXISTS ClinicEase;
CREATE DATABASE ClinicEase;
USE ClinicEase;

-- =========================
-- 1. Patients Table
-- =========================
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255)
);

-- =========================
-- 2. Doctors Table
-- =========================
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- =========================
-- 3. Clinics Table
-- =========================
CREATE TABLE Clinics (
    clinic_id INT AUTO_INCREMENT PRIMARY KEY,
    clinic_name VARCHAR(150) NOT NULL,
    location VARCHAR(200) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

-- =========================
-- 4. Appointments Table
-- =========================
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    clinic_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (clinic_id) REFERENCES Clinics(clinic_id) ON DELETE CASCADE
);

-- =========================
-- 5. Prescriptions Table
-- =========================
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication_name VARCHAR(150) NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- =========================
-- 6. Payments Table
-- =========================
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME NOT NULL,
    method ENUM('Cash','Card','Insurance') NOT NULL,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- =========================
-- Sample Data
-- =========================
INSERT INTO Patients (first_name, last_name, date_of_birth, gender, phone, email, address)
VALUES 
('John','Doe','1990-01-15','Male','0712345678','john@example.com','Nairobi'),
('Jane','Smith','1985-06-20','Female','0723456789','jane@example.com','Mombasa');

INSERT INTO Doctors (first_name, last_name, specialization, phone, email)
VALUES
('Emily','Clark','Pediatrics','0701122334','emily@clinic.com'),
('Michael','Brown','Cardiology','0702233445','michael@clinic.com');

INSERT INTO Clinics (clinic_name, location, phone)
VALUES
('City Health Clinic','Nairobi CBD','0799887766'),
('Coastal Care','Mombasa','0799776655');

INSERT INTO Appointments (patient_id, doctor_id, clinic_id, appointment_date, status, notes)
VALUES
(1,1,1,'2025-09-10 10:00:00','Scheduled','Routine checkup'),
(2,2,2,'2025-09-12 14:30:00','Scheduled','Heart consultation');

INSERT INTO Prescriptions (appointment_id, medication_name, dosage, instructions)
VALUES
(1,'Paracetamol','500mg','Take twice daily after meals'),
(2,'Atorvastatin','10mg','Take once daily at night');

INSERT INTO Payments (appointment_id, amount, payment_date, method)
VALUES
(1,1500.00,'2025-09-10 11:00:00','Cash'),
(2,3000.00,'2025-09-12 15:00:00','Card');
