USE Hospital
GO
DROP PROCEDURE Doctors_Rating
GO
CREATE PROCEDURE Doctors_Rating
    @Doctor_id INT 
AS 
	DECLARE @BASE INT

    SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF;
    -- Calculating base rating from average MH marks

	SELECT @BASE = SUM(mark) / COUNT(*)
	FROM MedicalHistory
	WHERE doctor = @Doctor_id

	-- Decreasing rating for long-term treatments
	SELECT @BASE = @BASE * 0.95
	FROM MedicalHistory
	WHERE DATEDIFF(month, start_treatment, end_treatment) > 2

	-- Decraasing rating based on patient deaths
	SELECT @BASE = @BASE * 0.8
	FROM MedicalHistory
	WHERE mark = 0

	-- Decreasing ratings for restricted medicine
	SELECT @BASE = @BASE * 0.95
	FROM MedicalHistory JOIN ChosenTreatment ON ChosenTreatment.medical_history = MedicalHistory.registry_id
	JOIN Medicine ON Medicine.medicine_id = ChosenTreatment.medicine
	JOIN Containment ON Containment.medicine = Medicine.medicine_id
	JOIN Restrictions ON Restrictions.patient = MedicalHistory.patient
	WHERE Containment.ingredient = Restrictions.ingredient

	PRINT 'Doctor # ' + CAST(@Doctor_id AS VARCHAR(10) )+ ' -> ' + CAST(@BASE AS VARCHAR(10))
GO