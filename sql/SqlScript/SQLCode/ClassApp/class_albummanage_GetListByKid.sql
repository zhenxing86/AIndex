USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_albummanage_GetListByKid]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
  
  
  
  
  
  
------------------------------------  
--用途：分页取相册信息   
--项目名称：ClassHomePage  
--说明：  
--时间：2009-1-6 10:58:57  
  
--exec [class_albummanage_GetListByKid] 2395,1,12  
------------------------------------  
CREATE PROCEDURE [dbo].[class_albummanage_GetListByKid]  
@kid int,  
@page int,  
@size int  
 AS  
  
  DECLARE @pre int,@ignore  int  
  SET @pre=@page*@size  
  SET  @ignore=@pre-@size  
    
   DECLARE @temtable table(  
   row int identity(1,1),  
   temid int  
  )  
    
  SET ROWCOUNT @pre  
  INSERT INTO @temtable SELECT albumid FROM class_album   
  where kid=@kid AND [status]=1   
  ORDER BY albumid desc  
     
  IF(@page>1)   
  BEGIN  
    
       SET ROWCOUNT  @size  
       SELECT t2.albumid,t2.title,t2.author,'',t2.createdatetime,t2.classid,t2.net FROM class_album t2  
        inner join basicdata..class t3 on t2.classid=t3.cid   and t3.deletetag=1 
   inner join @temtable t4  
        ON   t2.albumid=t4.temid  
        WHERE t2.kid=@kid AND row>@ignore  
        ORDER BY   
   albumid DESC  
          
  END  
  ELSE  
  BEGIN  
       SET ROWCOUNT @size  
       SELECT albumid,title,author,'',createdatetime,t2.classid,t2.net FROM class_album t2   
  inner join basicdata..class t3  on t2.classid=t3.cid    and t3.deletetag=1 
       WHERE t2.kid=@kid  AND [status]=1  
        ORDER BY   
   albumid DESC  
  END   
  
  
  
  
  
  
  
  
  
GO
