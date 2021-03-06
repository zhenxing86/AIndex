USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[saleinfo_GetListTag]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                  
-- Author:      xie              
-- Create date: 2014-05-17                 
-- Description:                   
-- Memo:                          
exec saleinfo_GetListTag 1,10,-1,-1,'',-1,'2013-1-2','2014-6-2',-1,135,1        
        
exec saleinfo_GetListTag 1,10,-1,-1,'',-1,'2013-1-2','2014-6-2',-1,135,1          
        
select * from  saleinfo           
        
CREATE TABLE #kid(kid int)                      
  DECLARE @flag int                
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex -1,'','','','',1,''         
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex -1,'','','','',132,''          
  select @flag,* from #kid        
  drop table #kid        
          
  CREATE TABLE #kid(kid int)                      
  DECLARE @flag int                
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex -1,'','','','',132,''           
          
  select @flag,* from #kid        
  drop table #kid   update  saleinfo set deletetag=0   
*/                  
CREATE PROCEDURE [dbo].[saleinfo_GetListTag]              
@page int                  
,@size int            
,@userid int           
,@kid int                   
,@kname nvarchar(50)                  
,@jsstyle int,              
@bgndate datetime=null,                  
@enddate datetime=null,                
@reuserid int=0, --录入人        
@douserid int = -1,        
@type int =0           
            
 AS                   
begin                  
  CREATE TABLE #kid(kid int)                      
  DECLARE @flag int=-1              
  if(@type=1)        
  EXEC @flag = CommonFun.DBO.Filter_Kid_Ex @kid,@kname,'','','',@douserid,''            
          
 DECLARE @fromstring NVARCHAR(2000)          
 if @flag<=-1               
  SET @fromstring =                   
  '[saleinfo] s        
  left join ossapp..users u         
  on s.userid=u.id        
  left join ossapp..users u1         
  on s.reuserid=u1.id        
  where js_date>=@T1 and js_date <=@T2 and s.deletetag =1'           
else         
    SET @fromstring =                   
  '[saleinfo] s        
  inner join #kid k on s.kid =k.kid        
  left join ossapp..users u         
  on s.userid=u.id        
  left join ossapp..users u1         
  on s.reuserid=u1.id        
  where js_date>=@T1 and js_date <=@T2 and s.deletetag =1'              
                   
  IF @kid>0 SET @fromstring = @fromstring + ' AND s.kid = @D1'            
  IF @userid>0 SET @fromstring = @fromstring + ' AND s.userid = @D2'            
  IF @reuserid>0 SET @fromstring = @fromstring + ' AND s.reuserid = @D3'               
  IF @jsstyle>-1 SET @fromstring = @fromstring + ' AND s.js_style = @D4'             
  IF @kname <> '' SET @fromstring = @fromstring + ' AND s.kname like @S1 + ''%'''                   
                            
 --分页查询                  
 exec sp_MutiGridViewByPager                  
  @fromstring = @fromstring,      --数据集                  
  @selectstring =                   
  ' s.saleid,s.userid,s.reuserid,s.kid,s.kname,s.ytj_cnt,s.gun_cnt,s.pb_cnt,s.card_cnt,s.js_date,s.js_style,s.js_cnt,u.name username,u1.name dousername,    
  s.card_equ_cnt,s.js_cnt_kk,s.js_status,s.js_status_kk,s.price,s.totlemoney,s.term,s.salefrom,s.remark ',      --查询字段                  
  @returnstring =                   
  ' saleid,userid,reuserid,kid,kname,ytj_cnt,gun_cnt,pb_cnt,card_cnt,js_date,js_style,js_cnt,username,dousername,    
  card_equ_cnt,js_cnt_kk,js_status,js_status_kk,price,totlemoney,term,salefrom,remark ',      --返回字段                  
  @pageSize = @Size,                 --每页记录数                  
  @pageNo = @page,                     --当前页                  
  @orderString = ' s.kid ',          --排序条件                  
  @IsRecordTotal = 1,             --是否输出总记录条数                  
  @IsRowNo = 0,           --是否输出行号                  
  @D1 = @kid,                  
  @D2 = @userid,             
  @D3 = @reuserid,             
  @D4 = @jsstyle,                  
  @S1 = @kname,                  
  @T1 = @bgndate,                  
  @T2 = @enddate            
          
  --print @fromstring        
  drop table #kid              
end 
GO
