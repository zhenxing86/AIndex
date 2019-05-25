/*    
Author: xie    
DataTime: 2014-09-15    
Desitipation:获取模板    
    
[hb_Temp_GetListTag] '常用',560725,12511,1,10      
    
*/    
CREATE proc hb_Temp_GetListTag    
@tmptype nvarchar(50),      
@uid int,      
@kid int,    
@page int,    
@size int    
as    
BEGIN   
   
 if(not exists(select * from ossapp..kinbaseinfo where status='正常缴费' and kid=@kid))      
 begin      
  SELECT top 7 1 pcount,id,catid,tmptype,tmpcontent  
   from zgyey_om..hb_remark_temp ht  
 left join ebook..uid_temp ut on ht.id=ut.tempid and ut.userid=@uid      
   where tmptype=@tmptype and catid=0      
   ORDER BY ut.userid      
end      
else   
begin   
 DECLARE @fromstring NVARCHAR(2000)  
                  
 SET @fromstring = 'zgyey_om..hb_remark_temp ht   
  left join ebook..uid_temp ut on ht.id=ut.tempid and ut.userid=@D1  
   where ht.tmptype=@S1 and ht.catid=0   '       
 --分页查询              
 exec sp_MutiGridViewByPager              
  @fromstring = @fromstring,      --数据集              
  @selectstring =               
  ' id,catid,tmptype,tmpcontent',      --查询字段              
  @returnstring =               
  ' id,catid,tmptype,tmpcontent',      --返回字段              
  @pageSize = @Size,                 --每页记录数              
  @pageNo = @page,                     --当前页              
  @orderString = ' ut.userid  ',          --排序条件              
  @IsRecordTotal = 1,             --是否输出总记录条数              
  @IsRowNo = 0,           --是否输出行号              
  @D1 = @uid,  
  @S1 = @tmptype  
end  
    
END 
go

use NGBApp
go
/*        
Author: xie        
DataTime: 2014-09-15        
Desitipation:获取学期寄语模板        
        
[GetForewordTempListTag] 46144,12511,1,10      

GetInBoxByPageBlogMessageBox
GetInBoxByPageBlogMessageBox        
*/ 
ALTER PROCEDURE [dbo].[GetForewordTempListTag]  
@classid int,  
@kid int,  
@page int,  
@size int  
 AS   
BEGIN 
declare @catid int  
set @catid=1  
if(not exists(select * from ossapp..kinbaseinfo where status='正常缴费' and kid=@kid))          
 begin          
  SELECT top 7 1 pcount,id,catid,tmptype,tmpcontent      
   from zgyey_om..hb_remark_temp ht      
 inner join ebook..cid_temp ct on ht.id=ct.tempid        
   where ht.catid=1 and ct.classid=@classid   
   order by id desc      
end          
else       
begin       
 DECLARE @fromstring NVARCHAR(2000)      
                      
 SET @fromstring = 'zgyey_om..hb_remark_temp ht      
 inner join ebook..cid_temp ct on ht.id=ct.tempid        
   where ht.catid=1 and ct.classid=@D1 '           
 --分页查询                  
 exec sp_MutiGridViewByPager                  
  @fromstring = @fromstring,      --数据集                  
  @selectstring =                   
  ' id,catid,tmptype,tmpcontent',      --查询字段                  
  @returnstring =                   
  ' id,catid,tmptype,tmpcontent',      --返回字段                  
  @pageSize = @Size,                 --每页记录数                  
  @pageNo = @page,                     --当前页                  
  @orderString = 'id desc ',          --排序条件                  
  @IsRecordTotal = 1,             --是否输出总记录条数                  
  @IsRowNo = 0,           --是否输出行号                  
  @D1 = @classid     
end      
        
END 
GO

use NGBApp
go
/*        
-- Author:      xie    
-- Create date: 2014-10-24      
-- Description: 手机客户端获取观察与评价数据(Web)     
-- Memo:   BasicData.dbo.class where kid=12511    
and_hb_gcpj_GetListV2 46144,'2014-0',0       
*/         
alter Procedure and_hb_gcpj_GetListV2      
@cid Int,      
@term Varchar(50),       
@pos Int      
as      
      
;With Data as (      
Select a.gbid, c.diaryid, e.name username, e.userid, Case When c.diaryid > 0 Then 1 Else 0 End status,    
 isnull(c.TeaPoint,'0,0,0,0,0,0,0,0,0') TeaPoint, isnull(c.ParPoint,'0,0,0,0,0,0,0,0,0') ParPoint,      
       ROW_NUMBER() Over(Partition by a.gbid Order by c.diaryid Desc) RowNo      
  From NGBApp.dbo.growthbook a Left Join NGBApp.dbo.Diary_page_month_evl c On a.gbid = c.gbid and c.months = @pos,       
       BasicData.dbo.user_class b, BasicData.dbo.[user] e      
  Where a.userid = b.userid and b.cid = @cid and a.term = @term and b.userid = e.userid      
)      
Select diaryid, username, userid, status, TeaPoint, ParPoint From Data Where RowNo = 1 order by username
go

use ngbapp
go
/*    
-- Author:      xie
-- Create date: 2014-10-24  
-- Description: 手机客户端获取某个月的观察与评价的目录内容(Web) 
-- Memo:   BasicData.dbo.class where kid=12511
and_hb_gcpj_target_GetList 55906,'2014-0',0  

*/     
CREATE Procedure and_hb_gcpj_target_GetList
@cid Int,  
@term Varchar(50),   
@pos Int  
as  
Declare @kid Int  
Select @kid = kid From BasicData.dbo.class Where cid = @cid  

Select target From NGBApp.dbo.monthtarget   
  Where grade In (Select b.gtype From BasicData.dbo.class a, BasicData.dbo.grade b   
                    Where a.grade = b.gid and a.cid = @cid)   
    and months In (Select Months From NGBApp.dbo.fn_GetMonAdvList(@term, @kid) Where pos = @pos)  
  Order by orderno
go

use ngbapp
go

/*    
-- Author:      xie
-- Create date: 2014-04-15    
-- Description: 手机客户端发展评估用户列表(web)  
-- Memo:  
and_hb_dpg_GetList 46144,'2014-0'    
*/     
CREATE Procedure and_hb_dpg_GetListV2 
@cid Int,  
@term Varchar(50)  
as  
Select a.gbid, c.userid, c.name username, a.DevEvlPoint [desc]  
  From NGBApp.dbo.growthbook a, BasicData.dbo.user_class b, BasicData.dbo.[user] c  
  Where a.userid = b.userid and b.userid = c.userid and b.cid = @cid and a.term = @term  
go

use ngbapp
go

/*    
-- Author:      xie
-- Create date: 2014-04-15    
-- Description: 手机客户端获取发展评估内容及小朋友的发展评估得分(web)  
-- Memo:  
and_hb_dpg_child_GetModelV2 46144,'2014-0'    
*/     
CREATE Procedure and_hb_dpg_child_GetModelV2
@gbid Int    
as  
Select target, district From NGBApp.dbo.devetarget Where grade = 1 Order by orderno 

Select DevEvlPoint From NGBApp.dbo.growthbook a Where gbid = @gbid  
go
 
use ngbapp
go
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
create proc and_hb_endterm_temp_GetList
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
   
go



