USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[checkpwd]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	
-- Create date: <Create Date,,>
-- Description:	判断密码是否存在并且修改密码
-- =============================================
CREATE PROCEDURE [dbo].[checkpwd]
@pwd varchar(100),@userid int,
@newpwd varchar(500)
AS
BEGIN
 declare @returnvalue int
 if not exists(select * from  [user] where  userid=@userid AND [password]=@pwd  and deletetag=1)
 begin
   set @returnvalue=0
 end
 else
 begin
    update [user] set [password]=@newpwd where userid=@userid
    set @returnvalue=1
 end
 
 return @returnvalue
END







GO
