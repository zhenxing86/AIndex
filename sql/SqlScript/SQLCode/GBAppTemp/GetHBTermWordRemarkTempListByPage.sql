USE [GBAppTemp]
GO
/****** Object:  StoredProcedure [dbo].[GetHBTermWordRemarkTempListByPage]    Script Date: 2014/11/24 23:08:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






--[GetHBTermWordRemarkTempListByPage] 15187,90,3,10
CREATE PROCEDURE [dbo].[GetHBTermWordRemarkTempListByPage]
@classid int,
@kid int,
@page int,
@size int
 AS 

declare @catid int
set @catid=1

if(not exists(select * from ossapp..kinbaseinfo where status='正常缴费' and kid=@kid))
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
			classid int
		)

		INSERT INTO @temptable
		SELECT 
		id ,t2.classid from zgyey_om..hb_remark_temp t1 left join ebook..cid_temp t2 on t1.id=t2.tempid and t2.classid=@classid
		where catid=@catid			 
		ORDER BY t2.classid 
		
		SET ROWCOUNT @size
		SELECT 
	id,catid,tmptype,tmpcontent,t1.classid
	 FROM zgyey_om..hb_remark_temp s,@temptable t1
		WHERE s.id=tempid AND row>@ignore 
		ORDER BY t1.classid 
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			top 7 id,catid,tmptype,tmpcontent,t2.classid from zgyey_om..hb_remark_temp t1
		left join ebook..cid_temp t2 on t1.id=t2.tempid and t2.classid=@classid
		where t1.catid=1
		order by t2.classid 
	END
	
	






		



GO
