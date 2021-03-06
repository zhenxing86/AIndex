USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[GetHonoursByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie    
-- Create date:       
-- Description:       
-- Memo: GetHonoursByPage 629871 ,1, 10       
    
GetHonoursByPage 630553,'',1,100    
GetHonoursByPage 190123,'',1,100    
    
*/      
CREATE PROC [dbo].[GetHonoursByPage]       
 @userid int,     
 @hName varchar(100),    
 @page int,      
 @size int      
AS      
BEGIN      
 SET NOCOUNT ON      
     
 DECLARE @fromstring NVARCHAR(2000)        
 SET @fromstring =         
 'Honours h       
   WHERE DeleteTag = 1 '         
  IF @hName<>'' SET @fromstring = @fromstring + ' AND hName like @S1 + ''%'''     
  IF @userid>0 SET @fromstring = @fromstring + ' and userid =@D1'     
      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring =       
  'userid, kid, hName, hOwner, hRank, hGrade, hOrgan, hTime, hType, hUnit, hTeacher, hPic, rylei,hid ',      --查询字段      
  @returnstring =       
  'userid, kid, hName, hOwner, hRank, hGrade, hOrgan, hTime, hType, hUnit, hTeacher, hPic, rylei,hid ',      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' hName desc',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @userid,    
  @S1 = @hName    
      
END      
GO
