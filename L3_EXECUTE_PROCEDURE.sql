USE Hospital
GO

DECLARE @DOCTOR_ID INT
DECLARE cur CURSOR LOCAL FOR
    SELECT Doctors.doctor_id 
	FROM Doctors

OPEN cur

FETCH NEXT FROM cur INTO @DOCTOR_ID

WHILE @@FETCH_STATUS = 0 BEGIN

    --execute your sproc on each row
    EXECUTE Doctors_Rating @DOCTOR_ID

    FETCH NEXT FROM cur INTO @DOCTOR_ID
END

CLOSE cur
DEALLOCATE cur