USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[GetHBRemarkTempListByPage]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--GetHBRemarkTempListByPage '常用',90,4246,1,100
CREATE PROCEDURE [dbo].[GetHBRemarkTempListByPage]
@tmptype nvarchar(50),
@uid int,
@kid int,
@page int,
@size int
 AS 

declare @catid int
set @catid=0

if(not exists(select * from kwebcms..site_config where isvip=1 and siteid=@kid))
begin
set @page=1
end

IF(@page>1)
	BEGIN
		DECLARE @count int
		DECLARE @ignore int
		SET @count=@page*@size
		SET @ignore=@count-@size

		DECLARE @temptable TABLE
		(
			row int identity(1,1) primary key,
			tempid int,
			userid int
		)

		INSERT INTO @temptable
		SELECT 
		id,t2.userid from zgyey_om..hb_remark_temp t1 left join uid_temp t2 on t1.id=t2.tempid and t2.userid=@uid
		 where t1.tmptype=@tmptype and t1.catid=@catid 
		ORDER BY t2.userid
		
		SET ROWCOUNT @size
		SELECT 
	id,catid,tmptype,tmpcontent,t2.userid
	 FROM zgyey_om..hb_remark_temp s,@temptable  t2
		WHERE s.id=tempid AND row>@ignore 
		ORDER BY t2.userid
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT 
		top 7 id,catid,tmptype,tmpcontent,t2.userid from zgyey_om..hb_remark_temp t1 left join uid_temp t2 on t1.id=t2.tempid and t2.userid=@uid
		where tmptype=@tmptype and catid=@catid
		ORDER BY t2.userid
	END
	
	








GO
