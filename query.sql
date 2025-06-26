

CREATE TABLE Department (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);


CREATE TABLE Patient (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    contact VARCHAR(15),
    address TEXT
);


CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    date DATE,
    time TIME,
    status VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);


CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT,
    patient_id INT,
    date DATE,
    notes TEXT,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);


CREATE TABLE Medicine (
    medicine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    dosage VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);


CREATE TABLE Prescription_Medicine (
    prescription_id INT,
    medicine_id INT,
    quantity INT,
    instructions TEXT,
    PRIMARY KEY (prescription_id, medicine_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);


CREATE TABLE Medical_Record (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    diagnosis TEXT,
    treatment TEXT,
    notes VARCHAR(255) DEFAULT 'no note',
	date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);


CREATE TABLE Room (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) UNIQUE,
    type VARCHAR(50),
    status VARCHAR(50)
);


CREATE TABLE Patient_Room (
    patient_id INT,
    room_id INT,
    from_date DATE,
    to_date DATE,
    PRIMARY KEY (patient_id, room_id, from_date),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);


CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    amount DECIMAL(10,2),
    date DATE,
    method VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

ALTER TABLE Patient
ADD blood_group VARCHAR(5);


ALTER TABLE Doctor
MODIFY phone VARCHAR(20);


-- Populating Department Table
INSERT INTO Department (name, location) VALUES
('Cardiology', 'Block A'),
('Neurology', 'Block B'),
('Orthopedics', 'Block C'),
('Pediatrics', 'Block D'),
('Oncology', 'Block E');

select * from Department;

INSERT INTO Doctor (name, specialization, phone, email, department_id) VALUES
('Dr. Asha Mehta', 'Cardiologist', '9876543210', 'asha@hospital.com', 1),
('Dr. Rakesh Nair', 'Neurologist', NULL, 'rakesh@hospital.com', 2),
('Dr. Priya Verma', 'Orthopedic', '9988776655', 'priya@gmail.com', 3),
('Dr. Sunil Rao', 'Pediatrician', '9876501234', 'sunil@hospital.com', 4),
('Dr. Meena Joshi', 'Oncologist', NULL,'meenajoshi27@gmail.com', 5);

INSERT INTO Patient (patient_id,name, age, gender, contact, address, blood_group) VALUES
(1,'Ravi Sharma', 45, 'Male', '9807645321','Mumbai', 'O+'),
(2,'Sneha Patel', 30, 'Female', '9001234567', 'Pune', NULL),
(3,'Aman Khan', 60, 'Male', '9123456789', 'Delhi', 'A+'),
(4,'Neha Kulkarni', 25, 'Female','8907654321' ,'shik', 'B-'),
(5,'Suresh Singh', 52, 'Male', '9876543211', 'Nagpur', NULL);

INSERT INTO Appointment (patient_id, doctor_id, date, time, status) VALUES
(1, 1, '2025-06-01', '10:00:00', 'Scheduled'),
(2, 2, '2025-06-02', '11:00:00', 'Completed'),
(3, 3, '2025-06-03', '12:00:00', 'Cancelled'),
(4, 4, '2025-06-04', '09:30:00', NULL),
(5, 5, '2025-06-05', '14:00:00', 'Scheduled');


INSERT INTO Prescription (doctor_id, patient_id, date, notes) VALUES
(1, 1, '2025-06-01', 'Take aspirin daily'),
(2, 2, '2025-06-02', 'MRI advised'),
(3, 3, '2025-06-03', 'Speech Therapy Advised'),
(4, 4, '2025-06-04', 'Regular checkup'),
(5, 5, '2025-06-05', 'Swallowing Assessment scheduled on monday');

INSERT INTO Medicine (name, dosage, price, stock) VALUES
('Aspirin', '75mg', 10.00, 100),
('Paracetamol', '500mg', 5.00, 200),
('Amoxicillin', '250mg', 20.00, 150),
('Ibuprofen', '400mg', 15.00, 80),
('Vitamin D', '1000 IU', 25.00, 120);

INSERT INTO Prescription_Medicine (prescription_id, medicine_id, quantity, instructions) VALUES
(1, 1, 30, '1 daily after breakfast'),
(2, 2, 15, '2 daily after food'),
(3, 3, 20, '3 times a day'),
(4, 4, 10, 'As required'),
(5, 5, 25, 'Morning only');

INSERT INTO Medical_Record (patient_id, diagnosis, treatment, notes, date) VALUES
(1, 'Hypertension', 'Medication', DEFAULT, '2025-06-01'),
(2, 'Migraine', 'Rest & Medicine', 'Needs follow-up', '2025-06-02'),
(3, 'Fracture', 'Surgery', 'Cast for 6 weeks', '2025-06-03'),
(4, 'Cold', 'General medicine', 'cast for 2 weeks', '2025-06-04'),
(5, 'Cancer Screening', 'Biopsy', 'Awaiting results', '2025-06-05');

select * from Medical_Record;
INSERT INTO Room (room_number, type, status) VALUES
('101', 'General', 'Occupied'),
('102', 'Private', 'Available'),
('103', 'ICU', 'Occupied'),
('104', 'General', 'Maintenance'),
('105', 'Private', 'Available');

INSERT INTO Patient_Room (patient_id, room_id, from_date, to_date) VALUES
(1, 1, '2025-06-01', '2025-06-03'),
(2, 3, '2025-06-02', '2025-06-05'),
(3, 2, '2025-06-03', '2025-06-06'),
(4, 1, '2025-06-04', '2025-06-06'),
(5, 4, '2025-06-05', '2025-06-07');

INSERT INTO Payment (patient_id, amount, date, method) VALUES
(1, 1500.00, '2025-06-01', 'Cash'),
(2, 2000.00, '2025-06-02', 'Card'),
(3, 1800.00, '2025-06-03', 'Online'),
(4, 500.00, '2025-06-04', 'UPI'),
(5, 2200.00, '2025-06-05', 'Cash');

-- Update Dr. Rakesh Nair's phone number (was NULL)
UPDATE Doctor
SET phone = '9998881111'
WHERE doctor_id = 2;

-- Update Dr. Meena Joshi's phone number (was NULL)
UPDATE Doctor
SET phone = '8887772222'
WHERE doctor_id = 5;

-- Update blood group for patient Sneha Patel (patient_id = 2)
UPDATE Patient
SET blood_group = 'AB+'
WHERE patient_id = 2;

-- Update blood group for patient Suresh Singh (patient_id = 5)
UPDATE Patient
SET blood_group = 'O-'
WHERE patient_id = 5;

-- Update appointment status for appointment with NULL (appointment_id = 4)
UPDATE Appointment
SET status = 'Completed'
WHERE appointment_id = 4;
select* from Doctor;

DELETE FROM Patient
WHERE patient_id = 3;


