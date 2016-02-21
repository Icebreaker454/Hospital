USE Hospital;
GO

DECLARE @TableSchema NVARCHAR(MAX)
DECLARE @TableName NVARCHAR(MAX)

DECLARE CUR CURSOR FOR
	SELECT TABLE_SCHEMA,
			TABLE_NAME
	FROM   INFORMATION_SCHEMA.TABLES
	WHERE  TABLE_TYPE = 'BASE TABLE'
--OPEN CURSOR
OPEN CUR
--Fetch First Row
FETCH NEXT FROM CUR INTO @TableSchema,@TableName
--Loop
DECLARE @CTriggerName NVARCHAR(100)
DECLARE @UTriggerName NVARCHAR(100)

WHILE @@FETCH_STATUS = 0
	BEGIN

	DECLARE @SQL NVARCHAR(MAX)
	SET @CTriggerName = 'trg_' + @TableName + '_DCR_UCR'
	SET @UTriggerName = 'trg_' + @TableName + '_DLC_ULC'
	SET @SQL=NULL

	DECLARE @pk VARCHAR(256)
	SET @pk = dbo.PK(@TableName)

	IF NOT EXISTS (
		SELECT 1
		FROM sysobjects
		WHERE sysobjects.type = 'TR' 
		AND sysobjects.name = @CTriggerName
	)

	BEGIN
		SET @SQL=
			'CREATE TRIGGER ' + @CTriggerName +
			' ON ' + @TableName +
			' AFTER INSERT
				AS BEGIN
					UPDATE ' + @TableName + 
					' 
					SET DCR = GETDATE(),
						UCR = SYSTEM_USER
					FROM ' + @TableName +
					' JOIN INSERTED ON ' + @TableName + '.' + @pk + ' = INSERTED.' + @pk + 
				' END'
		PRINT @SQL
		EXEC ( @SQL)
	END
	ELSE
	BEGIN
		PRINT 'Trigger ' + @CTriggerName + ' already exists in the database'
		--EXEC('DROP TRIGGER ' + @CTriggerName)
	END
	IF NOT EXISTS (
		SELECT 1
		FROM sysobjects
		WHERE sysobjects.type = 'TR' 
		AND sysobjects.name = @UTriggerName
	)
	BEGIN
		SET @SQL=
			'CREATE TRIGGER ' + @UTriggerName +
			' ON ' + @TableName +
			' AFTER UPDATE
				AS BEGIN
					UPDATE ' + @TableName + 
					' 
					SET DLC = GETDATE(),
						ULC = SYSTEM_USER
					FROM ' + @TableName +
					' JOIN INSERTED ON ' + @TableName + '.' + @pk + ' = INSERTED.' + @pk + 
				' END'
		PRINT @SQL
		EXEC ( @SQL)
	END
	ELSE
	BEGIN
		PRINT 'Trigger ' + @UTriggerName + ' already exists in the database'
		--EXEC('DROP TRIGGER ' + @UTriggerName)
	END

	FETCH NEXT FROM CUR INTO @TableSchema,@TableName
END
--Close and Deallocate Cursor
CLOSE CUR
DEALLOCATE CUR