USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[HBRemarkTemp_GetListByPage]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[HBRemarkTemp_GetListByPage]
@tmptype nvarchar(50),
@catid int,
@page int,
@size int
 AS 

IF(@page>1)
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
		SET @count=@page*@size
		SET @ignore=@count-@size

		DECLARE @temptable TABLE
		(
			row int identity(1,1) primary key,
			tempid int
		)

		INSERT INTO @temptable
		SELECT 
		id from hb_remark_temp where tmptype=@tmptype and catid=@catid
		ORDER BY lastUpdatetime DESC
		
		SET ROWCOUNT @size
		SELECT 
	id,catid,tmptype,tmpcontent,status,lastUpdatetime
	 FROM hb_remark_temp s,@temptable 
		WHERE s.id=tempid AND row>@ignore 
		ORDER BY lastUpdatetime DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		id,catid,tmptype,tmpcontent,status,lastUpdatetime from hb_remark_temp where tmptype=@tmptype and catid=@catid
		ORDER BY lastUpdatetime DESC
	END
	ELSE
	BEGIN
		SELECT 
		id,catid,tmptype,tmpcontent,status,lastUpdatetime from hb_remark_temp where tmptype=@tmptype and catid=@catid
		ORDER BY lastUpdatetime DESC
	END





GO
