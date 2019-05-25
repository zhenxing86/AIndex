USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_GraduateMessage_UpdateContent]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		lx
-- Create date: 2010-9-2
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[kmp_GraduateMessage_UpdateContent]
@userid int,@content varchar(300),@id int 
AS
BEGIN
	 update kmp..GraduateMessage set [content]=@content where userid=@userid  and parentid=@id 
  
 if @@error<>0
     return 0
 else
    return 1
END


--select * from kmp..GraduateMessage where parentid=16535
GO
