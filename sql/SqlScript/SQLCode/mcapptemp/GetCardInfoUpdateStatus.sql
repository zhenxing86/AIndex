USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[GetCardInfoUpdateStatus]    Script Date: 2014/11/24 23:19:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：查询记录信息 
--项目名称：
--说明：
--时间：2012-10-16 21:55:38
/*test

select COUNT(*) 
		from cardinfo c 		  
			where c.kid=11061 and c.udate<='2013-08-16 19:35:55'
exec [GetCardInfoUpdateStatus] 12511,'001251100',0,'2013-08-16 19:35:55'

*/
------------------------------------
CREATE PROCEDURE [dbo].[GetCardInfoUpdateStatus]
@kid int,
@devid varchar(10),
@s_cnt int,
@lupdate datetime
 AS

	declare @server_cardcnt int
   if(@s_cnt=0)
	begin
		set @lupdate='2000-01-01';
	end
				
   select @server_cardcnt=COUNT(*) 
		from cardinfo c 		 
			where c.kid=@kid and c.udate>=@lupdate
    if(@server_cardcnt=0)
		select 0	
	if(@s_cnt =0 or @server_cardcnt>0)
		select 17
	else
		select 0


GO
