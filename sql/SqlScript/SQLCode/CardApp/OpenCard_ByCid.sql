USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[OpenCard_ByCid]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




 -- =============================================
-- Author:		select * from cardlist where kid=10640
--				select * from syninterface_userinfo where kid=10640
--select * from syninterface_cardbinding where kid=10640
--select * From usercard where kid=10640
-- Create date: <Create Date,,2007-07-06>
-- Description:	按幼儿园和用户类型批量开卡
--exec [OpenCard_ByKidAndUsertype] 10640,0
--exec [OpenCard_ByCid] 10710,38278
--exec [OpenCard_ByCid] 10710,37866
--exec [OpenCard_ByCid] 10710,37867
--exec [OpenCard_ByCid] 10710,38279
--exec [OpenCard_ByCid] 10710,37013
--exec [OpenCard_ByCid] 10710,37865
--exec [OpenCard_ByCid] 10710,39403
-- =============================================
CREATE PROCEDURE [dbo].[OpenCard_ByCid]  
@kid int,
@cid int
AS
BEGIN
	declare @userid int
	declare @cardno nvarchar(50)
	declare @enrolnum bigint

	if(@cid>0)	
	begin
			declare childrs insensitive cursor for 
			select t1.userid From basicdata.dbo.[user] t1 left join basicdata.dbo.user_class t2 on t1.userid=t2.userid
			 where t2.cid=@cid and t1.usertype=0 and t1.deletetag=1 and t1.userid not in(select userid from usercard where kid=@kid)
			open childrs
			fetch next from childrs into @userid
			while @@fetch_status=0
			begin				
				--fetch next from childrs into @userid
				select top 1 @cardno = cardno,@enrolnum=enrolnum from cardlist where kid=@kid and status=0 order by enrolnum desc
				insert into usercard (userid,cardno,usertype,kid)values(@userid,@cardno,0,@kid)
				update cardlist set status=1 where kid=@kid and status=0 and cardno=@cardno
				INSERT INTO SynInterface_CardBinding(kid,subno,userid,cardno,enrolnum,actiontype,SynStatus,ActionDateTime)
				VALUES(@kid,0,@userid,@cardno,@enrolnum,0,0,getdate())
				fetch next from childrs into @userid
			end
			close childrs
			deallocate childrs
	end	
END




GO
