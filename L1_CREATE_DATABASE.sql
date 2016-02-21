USE master;
GO

DROP DATABASE Hospital;
GO

CREATE DATABASE Hospital;
GO

USE Hospital;

CREATE TABLE Addresses (
	spt_index INT IDENTITY(70000, 1) PRIMARY KEY NOT NULL,
	zip_code INT NOT NULL,
	country VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	region VARCHAR(50),
	street VARCHAR(50) NOT NULL,
	building INT NOT NULL,
	apt INT
);

CREATE TABLE Patients (
	patient_id INT IDENTITY(10000, 1) PRIMARY KEY NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	middle_name VARCHAR(50) NOT NULL,
	patient_address INT FOREIGN KEY REFERENCES Addresses(spt_index) ON UPDATE CASCADE NOT NULL,
	notes VARCHAR(MAX)
);

CREATE TABLE Specializations (
	spec_id INT IDENTITY(655000, 1000) PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	spec_description VARCHAR(MAX)
);

CREATE TABLE Doctors (
	doctor_id INT IDENTITY(1000, 1) PRIMARY KEY NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	doctor_address INT FOREIGN KEY REFERENCES Addresses(spt_index) ON UPDATE CASCADE,
	specialization INT FOREIGN KEY REFERENCES Specializations(spec_id) ON UPDATE CASCADE NOT NULL,
);

CREATE TABLE Ingredients (
	ingredient_id INT IDENTITY(44000, 1) PRIMARY KEY NOT NULL,
	codename VARCHAR(40) NOT NULL,
);

CREATE TABLE Medicine (
	medicine_id INT IDENTITY(50000, 10) PRIMARY KEY NOT NULL,
	name VARCHAR(40) NOT NULL,
);

CREATE TABLE Containment (
	containment_id INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	ingredient 	INT FOREIGN KEY REFERENCES Ingredients(ingredient_id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
	medicine INT FOREIGN KEY REFERENCES Medicine(medicine_id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
);

CREATE TABLE Restrictions (
	restriction_id INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	patient INT FOREIGN KEY REFERENCES Patients(patient_id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
	ingredient INT FOREIGN KEY REFERENCES Ingredients(ingredient_id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
);

CREATE TABLE Diagnosis (
	diagnosis_id INT IDENTITY(335000, 1) PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL,
	symptoms VARCHAR(MAX),
);

CREATE TABLE MedicalHistory (
	registry_id INT IDENTITY(972000, 1) PRIMARY KEY NOT NULL,
	patient INT FOREIGN KEY REFERENCES Patients(patient_id) ON UPDATE CASCADE NOT NULL,
	doctor INT FOREIGN KEY REFERENCES Doctors(doctor_id) ON DELETE NO ACTION NOT NULL,
	start_treatment DATE NOT NULL,
	end_treatment DATE,
	mark INT,
	CONSTRAINT u_PatientDoctorStartDate UNIQUE (patient, doctor, start_treatment),
	CONSTRAINT c_Mark CHECK (mark <= 100 AND mark >= 0)
);

CREATE TABLE ConfirmedDiagnosis (
    registry_id INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	medical_history  INT FOREIGN KEY REFERENCES MedicalHistory(registry_id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
	diagnosis INT FOREIGN KEY REFERENCES Diagnosis(diagnosis_id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
);

CREATE TABLE ChosenTreatment (
	registry_id INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	medical_history  INT FOREIGN KEY REFERENCES MedicalHistory(registry_id) ON DELETE CASCADE ON UPDATE CASCADE NOT NULL,
	medicine INT FOREIGN KEY REFERENCES Medicine(medicine_id) ON DELETE CASCADE ON UPDATE CASCADE,
);

