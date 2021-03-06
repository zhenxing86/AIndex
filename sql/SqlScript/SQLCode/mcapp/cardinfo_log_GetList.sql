USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[cardinfo_log_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*          
-- Author:     xie     
-- Create date: 2014-04-30          
-- Description:  获取晨检卡操作记录         
-- Memo:            
exec cardinfo_log_GetList 12511,1,10,'1301200003'                 
*/          
CREATE PROCEDURE [dbo].[cardinfo_log_GetList]          
@kid int          
,@page int          
,@size int          
,@cardno nvarchar(50)          
 AS           
begin          
 DECLARE @fromstring NVARCHAR(2000)          
 SET @fromstring =           
 '[cardinfo_log] g           
 left join basicdata..[user] u on u.userid=g.userid           
 left join basicdata..[user] u0 on g.Douserid = u0.userid       
 left join ossapp..users u1 on g.Douserid = u1.ID       
 where g.kid=@D1 AND g.[cardno] =@S1'                                    
 --分页查询          
 exec sp_MutiGridViewByPager          
  @fromstring = @fromstring,      --数据集          
  @selectstring =           
  ' g.[cardno],udate,usest,cardtype,u.name, isnull(u1.name,u0.name) DoName,g.DoWhere, g.memo,opencarddate,g.ipaddr',      --查询字段          
  @returnstring =           
  ' [cardno],udate,usest,cardtype,name,DoName,DoWhere, memo,opencarddate,ipaddr',      --返回字段          
  @pageSize = @Size,                 --每页记录数          
  @pageNo = @page,                     --当前页          
  @orderString = ' g.udate desc ',          --排序条件          
  @IsRecordTotal = 1,             --是否输出总记录条数          
  @IsRowNo = 0,           --是否输出行号          
  @D1 = @kid,           
  @S1 = @cardno         
end 


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'<p>
	晨检卡操作日志信息表
</p>' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cardinfo_log_GetList'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'卡号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cardinfo_log_GetList', @level2type=N'PARAMETER',@level2name=N'@cardno'
GO
