USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_child_List]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[mc_sms_child_List]       
 @userid int 
 ,@checktime1 datetime      
 ,@checktime2 datetime      
       
 AS       
BEGIN      
SET NOCOUNT ON  

	select recmobile,content,sendtime from sms_mc s
		where 
		s.recuserid=@userid
		and s.sendtime between @checktime1 and @checktime2
		order by s.sendtime desc
end

GO
