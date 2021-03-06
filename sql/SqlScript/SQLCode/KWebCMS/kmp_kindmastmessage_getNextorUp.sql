USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_kindmastmessage_getNextorUp]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  xie  
-- Create date:2013-11-01  
-- Description: 查找上一封信箱或者下一封  
-- =============================================  
CREATE PROCEDURE [dbo].[kmp_kindmastmessage_getNextorUp]  
@id int,@isnext bit,@kid int  
AS  
BEGIN  
    if @isnext=1  
       BEGIN  
     SELECT top 1 id  
 FROM kmp..KinMasterMessage a   
 WHERE  id>@id and Kid=@kid  AND
  (a.Status=0 or a.Status=1 OR a.Status is null) and
  (parentid=0 or parentid is null) ORDER BY ID ASC  
       end  
     else   
         BEGIN  
        SELECT top 1 id  
 FROM kmp..KinMasterMessage a   
 WHERE   id<@id and (a.Status=0  or a.Status=1 OR a.Status is null)
	and (parentid=0 or parentid is null) and Kid=@kid  ORDER BY ID DESC  
   
     end  
end  
  
GO
