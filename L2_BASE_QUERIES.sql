/* ESSENTIAL REPORTS FOR MY TASK */

USE Hospital;

/* List of doctors and patients for a given time */
SELECT 
	doctor_id,
	Doctors.last_name,
	doctor_address,
	name AS Specialization,
	registry_id,
	patient,
	Patients.last_name
FROM Doctors 
JOIN Specializations
ON Doctors.specialization = Specializations.spec_id
LEFT JOIN MedicalHistory
ON MedicalHistory.doctor = Doctors.Doctor_ID
JOIN Patients
ON MedicalHistory.patient = Patients.patient_id
WHERE MedicalHistory.start_treatment >= '2015-09-01'
ORDER BY Doctors.last_name

/* Diagnosis, and threatments for each patient */
SELECT 
	patient_id,
	last_name,
	first_name,
	MedicalHistory.registry_id,
	start_treatment,
	end_treatment,
	Diagnosis.name AS Diagnosis,
	Medicine.name AS Treated_Medicine
FROM ((Patients JOIN MedicalHistory
ON MedicalHistory.patient = Patients.Patient_ID) LEFT JOIN ChosenTreatment
ON MedicalHistory.registry_id = ChosenTreatment.medical_history) 
JOIN Medicine
ON medicine = Medicine.medicine_id
JOIN ConfirmedDiagnosis
ON MedicalHistory.registry_id = ConfirmedDiagnosis.medical_history
JOIN Diagnosis
ON diagnosis = Diagnosis.diagnosis_id

/* Doctors load on 2015 */
SELECT
	Doctors.last_name,
	SUM(CASE WHEN start_treatment >= '2015-01-01' and start_treatment < '2015-02-01' THEN 1 ELSE 0 END) AS Jan,
	SUM(CASE WHEN start_treatment >= '2015-02-01' and start_treatment < '2015-03-01' THEN 1 ELSE 0 END) AS Feb,
	SUM(CASE WHEN start_treatment >= '2015-03-01' and start_treatment < '2015-04-01' THEN 1 ELSE 0 END) AS Mar,
	SUM(CASE WHEN start_treatment >= '2015-04-01' and start_treatment < '2015-05-01' THEN 1 ELSE 0 END) AS Apr,
	SUM(CASE WHEN start_treatment >= '2015-05-01' and start_treatment < '2015-06-01' THEN 1 ELSE 0 END) AS May,
	SUM(CASE WHEN start_treatment >= '2015-06-01' and start_treatment < '2015-07-01' THEN 1 ELSE 0 END) AS Jun,
	SUM(CASE WHEN start_treatment >= '2015-07-01' and start_treatment < '2015-08-01' THEN 1 ELSE 0 END) AS Jul,
	SUM(CASE WHEN start_treatment >= '2015-08-01' and start_treatment < '2015-09-01' THEN 1 ELSE 0 END) AS Aug,
	SUM(CASE WHEN start_treatment >= '2015-09-01' and start_treatment < '2015-10-01' THEN 1 ELSE 0 END) AS Sep,
	SUM(CASE WHEN start_treatment >= '2015-10-01' and start_treatment < '2015-11-01' THEN 1 ELSE 0 END) AS Oct,
	SUM(CASE WHEN start_treatment >= '2015-11-01' and start_treatment < '2015-12-01' THEN 1 ELSE 0 END) AS Nov,
	SUM(CASE WHEN start_treatment >= '2015-12-01' and start_treatment < '2016-01-01' THEN 1 ELSE 0 END) AS Dec
FROM Doctors LEFT JOIN MedicalHistory
ON Doctors.Doctor_ID = MedicalHistory.doctor
GROUP BY Doctors.last_name

SELECT * 
FROM (
	SELECT Doctors.last_name, LEFT(DATENAME(month, DATEADD(month, MONTH(start_treatment)-1, CAST('2015-01-01' AS datetime))), 3) AS [Month], patient
	FROM Doctors LEFT JOIN MedicalHistory
	ON Doctors.doctor_id = MedicalHistory.doctor
	WHERE start_treatment BETWEEN '2015-01-01' AND '2015-12-31'
) AS SourceTable
PIVOT(
	COUNT(patient)
	FOR [Month] IN (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, [Dec])
) AS PVT