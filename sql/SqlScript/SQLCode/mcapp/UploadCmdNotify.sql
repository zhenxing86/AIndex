USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[UploadCmdNotify]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      xie  
-- Create date:  2014-11-06 
-- Description:  更新远程指令状态
-- Memo:    
UploadCmdNotify 12511,'001251100',9
  
*/  
CREATE Proc [dbo].[UploadCmdNotify]
@kid int
,@devid nvarchar(10)
,@querytag int
as
BEGIN
	update querycmd 
	 set status=2 
	 where kid=@kid and devid = @devid 
	  and querytag=@querytag and status=0
END

--select *from mcapp..querycmd where kid = 12511 and devid='001251100' and status=2

GO
