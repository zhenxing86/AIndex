USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[cardinfo_GetList_All]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- Author:      Master谭        
-- Create date: 2013-07-02        
-- Description:         
-- Memo:          
exec cardinfo_GetList_All 12511,1,10,'1303001626',0        
exec cardinfo_GetList_All 11061,1,10,'1303000751','1303000751',-3,'2013-1-2','2014-3-2'        
*/        
CREATE PROCEDURE [dbo].[cardinfo_GetList_All]        
@kid int        
,@page int        
,@size int        
,@bgncard nvarchar(50) 
,@endcard nvarchar(50)        
,@usest int,        
@bgndate datetime=null,        
@enddate datetime=null,      
@flag int=0,  
@username nvarchar(10)=null               
 AS         
begin     

 if( @endcard='' ) set @endcard = @bgncard
 DECLARE @fromstring NVARCHAR(2000)        
 SET @fromstring =         
 '[cardinfo] g         
 left join basicdata..[user] u on u.userid=g.userid         
 left join basicdata..[user] u0 on g.Douserid = u0.userid   
 left join ossapp..users u1 on g.Douserid = u1.ID   
 where g.kid=@D1 '        
  --IF @bgncard <> '' SET @fromstring = @fromstring + ' AND g.[cardno] like @S1 + ''%'''    
  IF @bgncard <> '' SET @fromstring = @fromstring + ' AND cast(g.[cardno] as int)>= cast(@S1 as int) and cast(g.[cardno] as int)<= cast (@S2 as int)'           
  IF @usest <> -3 SET @fromstring = @fromstring + ' AND g.usest = @D2'        
  if @flag =1 SET @fromstring = @fromstring + ' and udate>=@T1 and udate<=@T2'        
  --IF @cardno <> '' SET @fromstring = @fromstring + ' AND @S2 in (s.card1,s.card2,s.card3,s.card4)'  
   IF @username <> '' SET @fromstring = @fromstring + ' AND u.name like @S3 + ''%'''                   
 --分页查询        
 exec sp_MutiGridViewByPager        
  @fromstring = @fromstring,      --数据集        
  @selectstring =         
  ' g.[cardno],udate,usest,cardtype,u.name, ISNULL(u1.name,u0.name) DoName,g.DoWhere, g.memo,opencarddate,g.kid',      --查询字段        
  @returnstring =         
  ' [cardno],udate,usest,cardtype,name,DoName,DoWhere, memo,opencarddate,kid',      --返回字段        
  @pageSize = @Size,                 --每页记录数        
  @pageNo = @page,                     --当前页        
  @orderString = ' g.[cardno] ',          --排序条件        
  @IsRecordTotal = 1,             --是否输出总记录条数        
  @IsRowNo = 0,           --是否输出行号        
  @D1 = @kid,        
  @D2 = @usest,        
  @S1 = @bgncard, 
  @S2 = @endcard,   
  @S3 = @username,      
  @T1 = @bgndate,        
  @T2 = @enddate        
end 
GO
