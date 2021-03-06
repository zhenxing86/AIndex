USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetCellsetMonAdv_ML]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                  
-- Author:     xie         
-- Create date: 2013-08-21                  
-- Description: (web 手机版)读取成长档案中幼儿表现，每月进步/观察评价的导航目录          
-- Memo:use ngbapp                  
select * from growthbook where userid=295765                  
[GetCellsetMonAdv_ML] 3065190,1                  
*/        
  
CREATE proc [dbo].[GetCellsetMonAdv_ML]  
@gbid int   
,@type nvarchar(10) --1:幼儿表现，2：每月进步/观察评价目录   
as  
begin  
 declare @kid int,@term nvarchar(6)  
 select @kid=kid,@term=term  
  from NGBApp..growthbook  
   where gbid=@gbid  
 if @type in('yebx')
 begin  
  --11、幼儿表现目录                
  select pos,title,1 from dbo.fn_GetCellsetList(@term,@kid)       
 end   
 else if @type in('myjb','gcpj')
 begin      
  --12、每月进步/观察评价目录            
  select pos,title,months from dbo.fn_GetMonAdvList(@term,@kid)     
 end   
end
GO
