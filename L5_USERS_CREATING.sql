DROP LOGIN MainDoctor
CREATE LOGIN MainDoctor WITH PASSWORD='main'
GO
DROP LOGIN Pharmacian
CREATE LOGIN Pharmacian WITH PASSWORD='smokeweedeveryday'
GO
DROP LOGIN Nurse
CREATE LOGIN Nurse WITH PASSWORD='nursy'
GO

USE Hospital
GO
DROP USER MainDoctor
CREATE USER MainDoctor FOR LOGIN MainDoctor
GO
EXEC sp_addrolemember 'db_owner', 'MainDoctor'
GRANT ALL
ON Doctors
TO MainDoctor
GO
GRANT ALL ON Specializations
TO MainDoctor
GO
GRANT ALL ON MedicalHistory
TO MainDoctor
GO
GRANT ALL ON Restrictions
TO MainDoctor
GO
GRANT EXEC ON Doctors_Rating
TO MainDoctor
GO

DROP VIEW DoctorAddresses
GO
CREATE VIEW DoctorAddresses
AS SELECT * 
	FROM Addresses
	WHERE spt_index IN (
		SELECT doctor_address
		FROM Doctors
	)
GO
GRANT ALL
ON DoctorAddresses
TO MainDoctor
GO


DROP USER Pharmacian
CREATE USER Pharmacian FOR LOGIN Pharmacian
GO
GRANT ALL ON Ingredients
TO Pharmacian
GO
GRANT ALL ON Containment
TO Pharmacian
GO
GRANT ALL
ON Medicine
TO Pharmacian
GO

DROP USER Nurse
CREATE USER Nurse FOR LOGIN Nurse
GO
GRANT ALL
ON Patients
TO Nurse
GO
DROP VIEW PatientAddresses
GO
CREATE VIEW PatientAddresses
AS SELECT * 
	FROM Addresses
	WHERE spt_index IN (
		SELECT patient_address
		FROM Patients
	)
GO
GRANT ALL
ON PatientAddresses
TO Nurse
GO 

DROP ROLE Doctors_role
CREATE ROLE Doctors_role
GO
GRANT ALL 
ON Diagnosis
TO Doctors_role
GO
GRANT SELECT
ON Medicine
TO Doctors_role
GO


DROP TRIGGER AddDoctorUser
GO
CREATE TRIGGER AddDoctorUser
ON Doctors
AFTER INSERT, UPDATE
AS BEGIN
	DECLARE @SQL VARCHAR(MAX)
	DECLARE @DoctorLastName VARCHAR(50)
	DECLARE @Doctor INT
	DECLARE @DoctorID VARCHAR(40)
	DECLARE @DoctorLOGIN VARCHAR(90)
	
	SELECT @DoctorLastName = last_name, @Doctor=doctor_id
	FROM INSERTED
	SET @DoctorID = CAST(@Doctor AS VARCHAR(20))
	SET @DoctorLOGIN = CONCAT('Doctor_', @DoctorID)

	DECLARE @n INT
	SET @n = (SELECT count(name) FROM master..syslogins WHERE name=@DoctorLOGIN)
	IF (@n=1)
	BEGIN
		SET @SQL = 'DROP LOGIN ' + @DoctorLOGIN
		EXEC (@SQL)
	END

	SET @SQL = 
	'CREATE LOGIN Doctor_' + @DoctorID + ' WITH PASSWORD=''' + @DoctorLastName + ''''
	EXEC(@SQL)

	SET @SQL='USE Hospital'
	EXEC(@SQL)
	SET @n = (SELECT count(name) FROM sys.database_principals WHERE name=@DoctorLOGIN)
	IF (@n=1)
	BEGIN
		SET @SQL = 'DROP USER ' + @DoctorLOGIN
		EXEC (@SQL)
	END
	SET @SQL='
	CREATE USER Doctor_' + @DoctorID + ' FOR LOGIN Doctor_' + @DoctorID
	EXEC(@SQL)
	SET @n = (SELECT count(name) FROM sysobjects WHERE name='Patients_' + @DoctorID)
	IF (@n=1)
	BEGIN
		SET @SQL = 'DROP VIEW Patients_' + @DoctorID
		EXEC (@SQL)
	END
	SET @SQL=' CREATE VIEW Patients_' + @DoctorID +
	' AS SELECT * FROM Patients
	 WHERE patient_id IN ('+
	 'SELECT DISTINCT patient 
	 FROM MedicalHistory 
	 WHERE doctor=' + @DoctorID + ') '
	 EXEC(@SQL)

	 SET @n = (SELECT count(name) FROM sysobjects WHERE name='MHs_' + @DoctorID)
	IF (@n=1)
	BEGIN
		SET @SQL = 'DROP VIEW MHs_' + @DoctorID
		EXEC (@SQL)
	END
	SET @SQL=' CREATE VIEW MHs_' + @DoctorID +
	' AS SELECT * FROM MedicalHistory
		WHERE doctor = '+ @DoctorID
		EXEC(@SQL)


	 SET @SQL = 
	 '
	 GRANT SELECT ON Patients_' + @DoctorID + 
	 ' TO Doctor_' + @DoctorID
	 EXEC(@SQL)
	  SET @SQL = 
	 '
	 GRANT ALL ON MHs_' + @DoctorID + 
	 ' TO Doctor_' + @DoctorID
	 EXEC(@SQL)
	 SET @SQL = 'Doctor_' + @DoctorID
	 EXEC sp_addrolemember 'Doctors_role', @SQL
END
GO

DROP TABLE ChangeLog
GO
CREATE TABLE ChangeLog(
	id INT IDENTITY (10000, 1) PRIMARY KEY NOT NULL,
	action_type VARCHAR(100) NOT NULL,
	user_changed VARCHAR(100) NOT NULL,
	change_date DATE NOT NULL,
)
GO

DROP TRIGGER trg_LogChanges
GO
CREATE TRIGGER trg_LogChanges
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS BEGIN
	DECLARE 
		@EventData XML = EVENTDATA()
	INSERT INTO ChangeLog VALUES (
		@EventData.value('(/EVENT_INSTANCE/EventType)[1]',   'VARCHAR(100)'),
		SYSTEM_USER,
		GETDATE()
	)
END