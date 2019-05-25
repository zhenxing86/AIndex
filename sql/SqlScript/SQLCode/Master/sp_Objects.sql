USE master
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master̷
-- Create date: 
-- Description:	
-- Memo:	
*/
ALTER PROCEDURE sp_Objects 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT name,type   
		FROM SYS.objects   
		WHERE TYPE IN('U','V','P','FN','TF')   
			and name not in(  
			'sysdiagrams','sp_alterdiagram','sp_creatediagram','sp_dropdiagram',  
			'sp_helpdiagramdefinition','sp_helpdiagrams','sp_renamediagram',  
			'sp_upgraddiagrams','fn_diagramobjects')    
		ORDER BY CASE  
		TYPE WHEN 'V' THEN 0 WHEN 'U' THEN 1 WHEN 'P' THEN 2 ELSE 3 END,TYPE,name  
END
GO

USE master;EXEC sp_MS_marksystemobject 'dbo.sp_Objects';  
GO