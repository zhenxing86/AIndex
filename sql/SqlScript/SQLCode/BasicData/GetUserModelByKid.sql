USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[GetUserModelByKid]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserModelByKid]   
@kid int  
AS  
BEGIN  
 select top 1 userid,account,[password],usertype,kid from [user]  
  where kid=@kid and usertype in(97,98) order by usertype desc,userid  
END  
GO
