USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[tcf_setting_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		xzx
-- Project: com.zgyey.ossapp
-- Create date: 2013-07-22
-- Description:	获取晨检枪参数设备信息

/*
tcf_setting_GetList 12511,2,5
*/
-- =============================================
CREATE PROCEDURE [dbo].[tcf_setting_GetList]
@kid int      
,@page int=1      
,@Size int=10        
 AS     
DECLARE @fromstring NVARCHAR(2000), @selectstring NVARCHAR(1000)    
begin      
     
 SET @fromstring = ' [tcf_setting] where kid=@D1 '     
 set @selectstring='[id],[serialno],[kid],[xmsj],[lsavesj],[gunnum]
		,[devid],[alarmt],[tox],[tax],[tx0A],[tx0B],[t5A]
		,[t5B],[t10A],[t10B],[t15A],[t15B],[t20A],[t20B]
		,[t25A],[t25B],[t30A],[t30B],[t35A],[t35B],[t40A]
		,[t40B],[td40A],[td40B],[tx0C],[tx0],[t5C]
		,[t5],[t10C],[t10],[t15C],[t15],[t20C],[t20]
		,[t25C],[t25],[t30C],[t30],[t35C],[t35],[t40C]
		,[t40],[td40C],[td40],[txMaxTW],[txMaxDif]
		,t25x1,t25x2,t25y1,t25y2'     
		    
 --分页查询      
 exec sp_MutiGridViewByPager      
  @fromstring = @fromstring,      --数据集      
  @selectstring = @selectstring,      --查询字段      
  @returnstring = @selectstring,      --返回字段      
  @pageSize = @Size,                 --每页记录数      
  @pageNo = @page,                     --当前页      
  @orderString = ' id desc ',          --排序条件      
  @IsRecordTotal = 1,             --是否输出总记录条数      
  @IsRowNo = 0,           --是否输出行号      
  @D1 = @kid      

end



GO
