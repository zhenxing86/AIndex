USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_endterm_temp_GetList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:     xie
-- Create date: 2014-10-30    
-- Description: 手机客户端获取期末总评模板 
-- Memo:   
and_hb_endterm_temp_GetList 13747,1,10
   
   select *from basicdata..class where kid=13747
   
    Select top 7 1 pcount, hrt.id pagetplid, hrt.tmpcontent tplname,ct.* 
	   From zgyey_om..hb_remark_temp hrt 
	    inner join ebook..cid_temp ct 
	     on hrt.id=ct.tempid --and ct.classid=@cid
	   Where tmptype = '期末评语' and status = 1  and catid=1 
	   
*/    
create proc [dbo].[and_hb_endterm_temp_GetList]
@kid int
,@page int
,@size int
as
BEGIN
	if(not exists(select * from ossapp..kinbaseinfo where status='正常缴费' and kid=@kid))      
	 begin      
	  Select top 7 1 pcount, hrt.id pagetplid, hrt.tmpcontent tplname
	   From zgyey_om..hb_remark_temp hrt 
	   Where tmptype = '期末评语' and status = 1  
	end      
	else   
	begin   
	 DECLARE @fromstring NVARCHAR(2000)  
	                  
	 SET @fromstring = 'zgyey_om..hb_remark_temp hrt 
	   where tmptype = ''期末评语'' and status = 1 '       
	 --分页查询              
	 exec sp_MutiGridViewByPager              
	  @fromstring = @fromstring,      --数据集              
	  @selectstring =               
	  ' hrt.id pagetplid, tmpcontent tplname',      --查询字段              
	  @returnstring =               
	  ' pagetplid,tplname',      --返回字段              
	  @pageSize = @Size,                 --每页记录数              
	  @pageNo = @page,                     --当前页              
	  @orderString = ' id desc ',          --排序条件              
	  @IsRecordTotal = 1,             --是否输出总记录条数              
	  @IsRowNo = 0         --是否输出行号            
	end  
    
END 
   

GO
