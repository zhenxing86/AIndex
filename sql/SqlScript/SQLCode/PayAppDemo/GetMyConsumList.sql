USE [PayAppDemo]
GO
/****** Object:  StoredProcedure [dbo].[GetMyConsumList]    Script Date: 2014/11/24 23:24:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetMyConsumList]
@userid int,
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
		SELECT t1.[consumid]    
  FROM [PayApp].[dbo].[consum_record] t1 left join [sbapp].[dbo].[sb_book] t2
	on t1.sbid=t2.sbid
where userid=@userid
order by t1.actiondatetime desc
		
		SET ROWCOUNT @size
		SELECT t1.[consumid]
      ,t1.[userid]
      ,t1.[sbid]
      ,t1.[redu_bean]
      ,t1.[actiondatetime]
	  ,t2.book_title
  FROM [PayApp].[dbo].[consum_record] t1 left join [sbapp].[dbo].[sb_book] t2
	on t1.sbid=t2.sbid
	 left join @temptable t3 on t1.consumid=t3.tempid
		WHERE  row>@ignore 
		order by t1.actiondatetime desc
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT t1.[consumid]
      ,t1.[userid]
      ,t1.[sbid]
      ,t1.[redu_bean]
      ,t1.[actiondatetime]
	  ,t2.book_title
      
  FROM [PayApp].[dbo].[consum_record] t1 left join [sbapp].[dbo].[sb_book] t2
	on t1.sbid=t2.sbid
where userid=@userid
order by t1.actiondatetime desc
	END
	ELSE
	BEGIN
		SELECT t1.[consumid]
      ,t1.[userid]
      ,t1.[sbid]
      ,t1.[redu_bean]
      ,t1.[actiondatetime]
	  ,t2.book_title
      
  FROM [PayApp].[dbo].[consum_record] t1 left join [sbapp].[dbo].[sb_book] t2
	on t1.sbid=t2.sbid
where userid=@userid
order by t1.actiondatetime desc
	END






GO
