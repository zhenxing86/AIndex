USE [PayAppDemo]
GO
/****** Object:  StoredProcedure [dbo].[GetCurrentUserInfo]    Script Date: 2014/11/24 23:24:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE PROCEDURE [dbo].[GetCurrentUserInfo]  
@userid int  
 AS   
  
select account,[name] from basicdata..[user] 
where userid=@userid  
  
  
  
  
GO
