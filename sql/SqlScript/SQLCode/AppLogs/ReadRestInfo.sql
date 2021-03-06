USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[ReadRestInfo]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- =============================================
-- Author:		Master谭
-- Edit:	mh
-- Create date: 2014-03-03
-- Description:	过程用于读取和写入阅读休息提醒的记录
-- Memo:	
select * from ReadingRest where userid = 288556
EXEC AppLogs..ReadRestInfo 288556,1
*/
CREATE PROCEDURE [dbo].[ReadRestInfo]
	@userid int,
	@tag int --1数字图书馆  
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @nt int=0,@spit int=1800,@cx int=600
	
	
	select @nt=DATEDIFF(ss,LastReading,GETDATE())
	 from ReadingRest 
			WHERE userid = @userid 
				AND tag = @tag 
				AND CDate = CAST(GETDATE() AS DATE) 
	
	if(@nt is null or @nt > (@spit+@cx) )
	begin
			;MERGE ReadingRest AS rr
			USING (select @userid userid,@tag tag,CAST(GETDATE() AS DATE) CDate,getdate() LastReading)
			AS mu
			ON (rr.userid = mu.userid and rr.tag = mu.tag and rr.CDate = mu.CDate)
			WHEN MATCHED AND DATEDIFF(ss,rr.LastReading,mu.LastReading) > (@spit+@cx)  THEN
			UPDATE SET rr.LastReading = mu.LastReading
			WHEN NOT MATCHED THEN
			INSERT (userid,tag,CDate,LastReading)
			VALUES (mu.userid, mu.tag, mu.CDate,mu.LastReading);
			
			if(@nt > @spit)
				select @cx ReadingRest
			else
				select 0 ReadingRest
	end	
	else if(@nt<=@cx and @nt>0)
	begin
	
		select (@cx-@nt) ReadingRest
	end
	else 
	begin
		select 0 ReadingRest
	
	end
	
	
END

GO
