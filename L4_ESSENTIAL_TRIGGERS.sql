USE Hospital;
GO

DROP TRIGGER trg_RestrictedMedicine
GO
DROP TRIGGER trg_PatientsCount
GO

-- Restricted medicine cannot be ordered to a patient
CREATE TRIGGER trg_RestrictedMedicine 
	ON ChosenTreatment
	INSTEAD OF INSERT
	AS BEGIN

		IF NOT EXISTS(
			SELECT 1
			FROM INSERTED JOIN MedicalHistory
			ON INSERTED.medical_history = MedicalHistory.registry_id JOIN Containment
			ON Containment.medicine = INSERTED.medicine JOIN Restrictions 
			ON Restrictions.patient = MedicalHistory.patient
			WHERE Containment.ingredient = Restrictions.ingredient
		)
			INSERT INTO ChosenTreatment (medical_history, medicine)
			SELECT
				medical_history, 
				medicine
			FROM INSERTED
		ELSE
		BEGIN
			RAISERROR('You cannnot order a medicine that have restricted ingredients for the current patient', 14, 1)
		END
	END
GO

-- A foctor cannot have more than 10 patients at once
CREATE TRIGGER trg_PatientsCount
	ON MedicalHistory
	INSTEAD OF INSERT
	AS BEGIN
		IF NOT ((
			SELECT COUNT(*)
			FROM MedicalHistory
			WHERE end_treatment IS NULL
			AND doctor IN (
				SELECT doctor
				FROM INSERTED
			)
		)> 10)
			INSERT INTO MedicalHistory(patient, doctor, start_treatment, end_treatment, mark)
			SELECT 
				patient,
				doctor,
				start_treatment,
				end_treatment,
				mark
			FROM INSERTED 	
		ELSE
			RAISERROR('A doctor cannot have more than 10 patients at once', 14, 1)		
	END
