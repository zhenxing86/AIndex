USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[cardinfo_GetList_All]    Script Date: 2014/11/24 23:19:15 ******/
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
exec cardinfo_GetList_All 12511,1,10,'',-3  
*/  
CREATE PROCEDURE [dbo].[cardinfo_GetList_All]  
@kid int  
,@page int  
,@size int  
,@cardno nvarchar(50)  
,@usest int  
 AS   
begin  
 DECLARE @fromstring NVARCHAR(2000)  
 SET @fromstring =   
 '[cardinfo] g   
 left join basicdata..[user] u on u.userid=g.userid   
 left join basicdata..[user] u0 on g.Douserid = u0.userid and g.DoWhere = 1  
 left join ossapp..users u1 on g.Douserid = u1.ID and g.DoWhere = 0   
 where g.kid=@D1 '  
  IF @cardno <> '' SET @fromstring = @fromstring + ' AND g.[cardno] like @S1 + ''%'''     
  IF @usest <> -3 SET @fromstring = @fromstring + ' AND g.usest = @D2'  
  --IF @cardno <> '' SET @fromstring = @fromstring + ' AND @S2 in (s.card1,s.card2,s.card3,s.card4)'          
 --分页查询  
 exec sp_MutiGridViewByPager  
  @fromstring = @fromstring,      --数据集  
  @selectstring =   
  ' g.[cardno],udate,usest,cardtype,u.name, ISNULL(u0.name,u1.name) DoName,g.DoWhere, g.memo',      --查询字段  
  @returnstring =   
  ' [cardno],udate,usest,cardtype,name,DoName,DoWhere, memo',      --返回字段  
  @pageSize = @Size,                 --每页记录数  
  @pageNo = @page,                     --当前页  
  @orderString = ' g.[cardno] ',          --排序条件  
  @IsRecordTotal = 1,             --是否输出总记录条数  
  @IsRowNo = 0,           --是否输出行号  
  @D1 = @kid,  
  @D2 = @usest,  
  @S1 = @cardno  
end  
GO
