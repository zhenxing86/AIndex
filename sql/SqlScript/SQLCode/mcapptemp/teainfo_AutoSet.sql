USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[teainfo_AutoSet]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 
-- Description:	
-- Memo:	teainfo_AutoSet 12511,12530,0					
*/
CREATE PROCEDURE [dbo].[teainfo_AutoSet]
	@kid int,
	@userid int = 0,
	@CardType int = 0
as
BEGIN
	SET NOCOUNT ON
	EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'teainfo_AutoSet&0' --设置上下文标志	
	
	declare @size int
	create table #temp
	(
		xid [int] IDENTITY(1,1) NOT NULL,
		tuid int,
		tcard varchar(20)
	)

	insert into #temp(tuid)
		select ut.userid
			from BasicData..User_Teacher ut			
			where ut.kid = @kid 
				and ut.usertype = 1 
				and not exists(select * from cardinfo where userid = ut.userid)

	set @size=@@rowcount
	SET ROWCOUNT @size

	DECLARE @tp TABLE(rownum int IDENTITY(1,1),	[card] varchar(100))

	insert into @tp
		select [card] 
			from cardinfo 
			where usest = 0 
				and kid = @kid 
				and CardType = @CardType
			order by [card]

	update #temp set tcard=[card] from @tp where rownum = xid

	update c set  usest=1, userid = t.tuid 
	from cardinfo c 
		inner join #temp t 
		on t.tcard = c.[cardno]   

	drop table #temp
	EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志    
END

GO
