USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[GetGartenmingyuan_Delete]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[GetGartenmingyuan_Delete]
	@kid int,
	@uid int
	 AS

declare @pcount int 

if(@uid=0)--设置名园
begin

select @pcount=mingyuan from dbo.gartenlist where kid=@kid
if(@pcount>0)
begin
update gartenlist set mingyuan=0 where kid=@kid
end
else
begin

update gartenlist set mingyuan=1 where kid=@kid

end

end--设置名园


if(@uid=1)--设置置顶
begin

select @pcount=orderby from dbo.gartenlist where kid=@kid


if(@pcount>0)
begin
update gartenlist set orderby=0 where kid=@kid
end
else
begin

select @pcount=max(orderby) from dbo.gartenlist

if(@pcount>9999999)
begin
 
update gartenlist set orderby=(orderby-1000000)
end

update gartenlist set orderby=(@pcount+1) where kid=@kid

end

end--设置置顶

GO
