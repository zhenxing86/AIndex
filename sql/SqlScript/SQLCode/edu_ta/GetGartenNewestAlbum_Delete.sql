USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[GetGartenNewestAlbum_Delete]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：是否屏蔽精彩瞬间
--项目名称：gartenlist
------------------------------------
create PROCEDURE [dbo].[GetGartenNewestAlbum_Delete]
	@contentid int,
	@uid int
	 AS
	 
	 declare @pcount int
	select @pcount=count(1) from dbo.PhotoState where contentid=@contentid
if(@pcount>0)
begin
delete dbo.PhotoState where contentid=@contentid
end
else
begin
insert into dbo.PhotoState(contentid,ishow,uid,uptime)
values (@contentid,1,@uid,getdate())

end





GO
