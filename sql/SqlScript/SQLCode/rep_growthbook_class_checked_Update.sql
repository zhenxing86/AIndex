USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_growthbook_class_checked_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rep_growthbook_class_checked_Update]
 @kid int,
 @cid int,
 @term varchar(20),
 @remark varchar(max)
 
 AS 
 
 declare @pcount int
 select @pcount=COUNT(1) from [rep_growthbook_class_checked] where [kid] = @kid and [cid] = @cid  and [term] = @term
 
 if(@pcount>0)
 begin
	UPDATE [rep_growthbook_class_checked] SET [remark] = @remark WHERE   [kid] = @kid and [cid] = @cid  and [term] = @term
 end
 else
 begin
	INSERT INTO [rep_growthbook_class_checked]([kid],[cid],[term],[remark]) VALUES (@kid,@cid,@term,@remark)
 end




GO
