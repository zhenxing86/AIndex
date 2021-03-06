USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[enlistonline_exists]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
  author: xie    
  date: 2014-02-19    
  des: 判断是否已经报名     
  memo：  
  enlistonline_exists 12511,'志琳',0,'2004-10-01 00:00:00.000','小一班'    
*/    
CREATE PROCEDURE [dbo].[enlistonline_exists]    
@siteid int,      
@name nvarchar(50)='',      
@sex bit,      
@birthday datetime,      
@classname nvarchar(50)=''     
AS          
BEGIN      
    if exists (    
     select 1 from enlistonline    
      where siteid=@siteid and name=@name and sex=@sex and birthday=@birthday and isnull(classname,'')=@classname)    
    BEGIN      
        RETURN 1    
    END      
    ELSE      
    BEGIN     
        RETURN -1    
    END      
END   
  
--select  *from enlistonline  
--where siteid =12511 v5712
GO
