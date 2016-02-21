USE Hospital;

SELECT 
	patient_id,
	first_name,
	last_name,
	middle_name,
	city,
	notes
FROM Patients
JOIN Addresses
ON Patients.patient_address = Addresses.spt_index
WHERE city = 'Lviv'
ORDER BY last_name


SELECT 
	first_name,
	last_name,
	SUM(DATEDIFF(day, start_treatment, end_treatment)) AS [Total Days Ill]
FROM Patients JOIN MedicalHistory
ON Patients.patient_id = MedicalHistory.patient
WHERE MedicalHistory.end_treatment IS NOT NULL
GROUP BY first_name, last_name


SELECT *
FROM Medicine, Ingredients
WHERE Medicine.name = Ingredients.codename
ORDER BY Medicine.name


SELECT
	Patients.patient_id,
	MedicalHistory.mark
FROM Patients 
LEFT JOIN MedicalHistory
ON Patients.Patient_ID = MedicalHistory.patient

SELECT *
FROM Diagnosis
WHERE symptoms LIKE '%Temperature%'


SELECT 
	medicine_id,
	name,
	ingredient AS ingredient_id,
	codename AS ingredient_codename
FROM Medicine
JOIN Containment
ON Medicine.medicine_id = Containment.medicine
JOIN Ingredients
ON Ingredients.ingredient_id = Containment.ingredient
WHERE Ingredients.codename IN ('Codeine', 'Restizine', 'Jyssezine')

SELECT 
	registry_id,
	patient_id,
	first_name,
	Patients.last_name,
	Doctors.doctor_id,
	Doctors.last_name,
	mark
FROM MedicalHistory
JOIN Patients
ON MedicalHistory.patient = Patients.patient_id
JOIN Doctors
ON MedicalHistory.doctor = Doctors.doctor_id
WHERE mark BETWEEN 80 AND 90


SELECT *
FROM Restrictions
WHERE EXISTS (
	SELECT *
	FROM MedicalHistory
	JOIN ChosenTreatment
	ON MedicalHistory.registry_id = ChosenTreatment.medical_history
	JOIN Containment
	ON Containment.medicine = ChosenTreatment.medicine
	WHERE ingredient = Restrictions.ingredient
)

SELECT 
	first_name,
	last_name
FROM Restrictions
JOIN Patients
ON Restrictions.patient = Patients.patient_id
WHERE Restrictions.ingredient = ANY (
	SELECT ingredient_id
	FROM Ingredients
	WHERE codename = 'Codeine' OR codename = 'Flugozole'
)
 

SELECT Doctors.last_name, SUM(1) AS NumberOfPatients
FROM Doctors
RIGHT JOIN MedicalHistory
ON Doctors.doctor_id = MedicalHistory.doctor
GROUP BY Doctors.last_name

SELECT DISTINCT 
	doctor_id,
	last_name
FROM (
	SELECT 
		Doctors.doctor_id, 
		Doctors.last_name, 
		Doctors.specialization, 
		Doctors.doctor_address
	FROM Doctors JOIN MedicalHistory
	ON Doctors.doctor_id = MedicalHistory.doctor
	WHERE end_treatment IS NULL
) AS DoctorsCurrentlyThreatingPatients
JOIN Addresses
ON Addresses.spt_index = DoctorsCurrentlyThreatingPatients.doctor_address
WHERE zip_code = 72123


/* Cross-TAB */

SELECT *
FROM 
(
	SELECT patient, last_name
	FROM MedicalHistory JOIN Doctors
	ON Doctors.doctor_id = MedicalHistory.doctor
) AS SourceTable
PIVOT (
	SUM(SourceTable.patient)
	FOR last_name IN (Feth, Colemann, Evans)
) AS PivotTable;

/*
UPDATE Patients
SET Patients.[Last Name] = 'Ericson'
WHERE Patients.Patient_ID = 1006

INSERT INTO Patients(Patient_ID, [First Name], [Last Name], [Middle Name], [Address], [Description]) VALUES 
	(1007, 'John', 'Smith', 'Evan', 999126, 'Some Desc')

INSERT INTO Patients([Last Name])
SELECT [Last Name]
FROM Doctors;

/*	DELETE 
	FROM ChosenThreatment
*/
/*	DELETE
	FROM Containment
	WHERE ID=1
*/
*/