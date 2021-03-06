USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_graduatemessage_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
-- =============================================  
-- Author:  hanbin  
-- alter date: 2009-06-11  
-- Description: 获取毕业留言总数  
--[kmp_graduatemessage_GetCount] 2308,1,0  
-- =============================================  
CREATE PROCEDURE [dbo].[kmp_graduatemessage_GetCount]   
@siteid int,  
@categorytype int,  
@parentid int  
AS  
BEGIN  
DECLARE @count int  
   IF (@siteid<>216)  
     begin   
      
   
-- SELECT @count=count(*) FROM kmp..GraduateMessage  
-- WHERE Kid=@siteid AND ((categorytype=0 OR categorytype IS NULL) OR (categorytype>0)) AND (categorytype=@categorytype or categorytype=0)  
-- AND ((parentid IS NULL AND @parentid=0) OR parentid=@parentid)  
-- RETURN @count  
  
 SELECT @count=count(*) FROM kmp..GraduateMessage  
 WHERE Kid=@siteid AND (categorytype=categorytype OR categorytype IS NULL or categorytype=1) and ((parentid IS NULL AND @parentid=0) OR parentid=@parentid)      
 --print @count  
    RETURN @count  
  
  end  
  else  
   begin  
     
-- SELECT @count=count(*) FROM kmp..GraduateMessage  
-- WHERE Kid=@siteid  AND categorytype=@categorytype  
-- AND   parentid=@parentid  
  
 SELECT @count=count(*) FROM kmp..GraduateMessage  
-- WHERE Kid=@siteid AND (categorytype=@categorytype AND Status>0) and ((parentid IS NULL AND @parentid=0) OR parentid=@parentid)  
WHERE Kid=@siteid AND ((categorytype=@categorytype OR categorytype IS NULL) OR (categorytype>0))   
AND ((parentid IS NULL or parentid=0) OR parentid=@parentid)  
 --print @count  
 RETURN @count  
  
 --RETURN @count  
   end  
END  
--  
  
  
--SELECT count(*) FROM kmp..GraduateMessage  
--WHERE Kid=10797 AND ((categorytype=0 OR categorytype IS NULL) OR (categorytype>0))   
--AND ((parentid IS NULL or parentid=0) OR parentid=0)  
--  
--SELECT * FROM kmp..GraduateMessage  
--WHERE Kid=58 AND ((categorytype=1 OR categorytype IS NULL) OR (categorytype>0))   
--AND ((parentid IS NULL or parentid=0) OR parentid=0)  
  
--update  kmp..GraduateMessage set categorytype=1 where kid=58


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_graduatemessage_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
