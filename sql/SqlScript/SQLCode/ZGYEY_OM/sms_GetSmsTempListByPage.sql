USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[sms_GetSmsTempListByPage]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sms_GetSmsTempListByPage]
@typeId int,
@page int,
@size int

 AS 	

DECLARE @tempcount int
	SELECT @tempcount=count(1) FROM SMS_Temp WHERE smstype=@typeId
	
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint		
		)
	
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT 
				Id
			FROM 
				SMS_Temp 
			WHERE smstype=@typeId
			

		SET ROWCOUNT @size
		SELECT 
			@tempcount AS tempcount,t1.Id,t1.smstype,t1.smscontent
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			SMS_Temp t1
		 ON 
			tmptable.tmptableid=t1.Id 
				 
		WHERE
			row>@ignore 			
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			@tempcount AS tempcount,t1.Id,t1.smstype,t1.smscontent
		FROM SMS_Temp t1 
		WHERE smstype=@typeId		
	END
GO
