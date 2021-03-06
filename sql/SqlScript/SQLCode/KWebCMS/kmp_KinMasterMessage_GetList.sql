USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_KinMasterMessage_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:  xie            
-- Create date: 2013-11-04            
-- Description: 获取园长信箱            
            
/*            
memo: exec kmp_KinMasterMessage_GetList 12511,2,6,0,0,-1,0
*/            
-- =============================================            
CREATE PROCEDURE [dbo].[kmp_KinMasterMessage_GetList]                  
@kid int,                  
@page int,                  
@size int,              
@ParentId int=0,            
@flag int =0,   --0:网站后台，1：网站前台  2手机网站          
@userid int=0,          
@id int=0          
AS                  
BEGIN                
  DECLARE @fromstring NVARCHAR(2000)                  
  SET @fromstring =                   
  'kmp..KinMasterMessage                     
   where kid=@D1 '             
                  
   IF @ParentId =0             
  SET @fromstring = @fromstring + ' and (parentid=0 or parentid is null)'              
   else            
  SET @fromstring = @fromstring + ' and parentid=@D2'             
             
   if @flag=0 SET @fromstring = @fromstring + ' and (status=0 or status=1 or status is null)'            
   else if @flag=1 set @fromstring = @fromstring + ' and status=1'            
     else if (@flag=2 )          
     begin           
  if(@id<1)          
  begin          
        
   if(@userid>0)      
   begin      
  set @fromstring = @fromstring + ' and userid=@D3' --手机网站        
   end            
  end          
   else          
       begin          
        set @fromstring = @fromstring + ' and id=@D4' --手机网站              
       end          
              
     end           
              
  --分页查询                  
  exec sp_MutiGridViewByPager                  
   @fromstring = @fromstring,      --数据集                  
   @selectstring =                   
   ' [id],[kid],[content],isnull(title,'''') title,[createdate],[ip],[status],[username],isnull([e_mail],'''') e_mail,isnull([contractphone],'''') contractphone,[address],[parentid],[userid]',      --查询字段                  
   @returnstring =                   
   ' [id],[kid],[content], title ,[createdate],[ip],[status],[username],[e_mail],[contractphone],[address],[parentid],[userid]',      --返回字段                  
   @pageSize = @Size,                 --每页记录数                  
   @pageNo = @page,                     --当前页                  
   @orderString = ' createdate DESC ',          --排序条件                  
   @IsRecordTotal = 0,             --是否输出总记录条数                  
   @IsRowNo = 0,           --是否输出行号                  
   @D1 = @kid,            
   @D2 = @ParentId  ,          
   @D3=@userid  ,          
   @D4=@id           
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_KinMasterMessage_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
