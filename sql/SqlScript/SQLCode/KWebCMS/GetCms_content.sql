USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[GetCms_content]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-12-5  
-- Description: 函数用于获取Categoryid  
-- Memo:    
EXEC GetCms_content 12511, 'yjym'  
EXEC GetCms_content 13307, 'ysjs'  
  
*/  
CREATE PROC [dbo].[GetCms_content]  
 @kid int=0,  
 @type varchar(10)='',  
 @conid int=0  
as  
BEGIN  
  declare @categoryid int  
  --班级公告
  if @type = 'bjgg'
  begin
    if @conid=0
    begin 
      Select top(1) noticeid contentid, title, content, createdatetime   
        From ClassApp..class_notice
        Where kid = @kid
    end
    else begin
      Select top(1) noticeid contentid, title, content, createdatetime   
        From ClassApp..class_notice
        Where noticeid = @conid
    end
  end
  
  --教学安排
  else if @type = 'jxap'
  begin
    if @conid=0
    begin 
      Select top(1) scheduleid contentid, title, content, createdatetime   
        From ClassApp..class_schedule
        Where kid = @kid
    end
    else begin
      Select top(1) scheduleid contentid, title, content, createdatetime   
        From ClassApp..class_schedule
        Where scheduleid = @conid
    end
  end
  
  --通知类
  else
  begin
    if(@conid=0)  
    begin  
	  if(@kid=13307)
	  begin
		if(@type='ysjs' or @type='ysjj')
			set	@type='jybj'
		if(@type='yjym')
			set	@type='byln'
	  end
			
		
      SELECT @categoryid = dbo.fn_GetCategoryid(@kid,@type)  
      select top(1) contentid, title, content, createdatetime   
        from cms_content   
        where categoryid = @categoryid  
          and siteid = @kid and deletetag = 1
        ORDER BY createdatetime DESC  
    end  
    else  
    begin  
      select top(1) contentid, title, content, createdatetime   
        from cms_content   
        where contentid=@conid and deletetag = 1
    end 
  end 
END 

GO
