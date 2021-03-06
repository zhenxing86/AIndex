/*          
-- Author:      xie          
-- Create date: 2013-09-19          
-- Description:           
-- Paradef:           
-- Memo:          
stu_mc_day_highTw_GetList 12511,1,10          
go          
stu_mc_day_highTw_GetList 12511,1,10,'2014-12-15 00:00:00','2014-12-15 23:59:59','',-1          
stu_mc_day_highTw_GetList 11061,1,10,'2014-12-16 00:00:00','2014-12-16 23:59:59','',-1          
          
select *From  stu_mc_day where id in(2158512,        
2158513,        
2158498,        
2158519,        
2158568,        
2158569,        
2158534,        
2158584,        
2158552,        
2158523)          
        
update stu_mc_day set cdate = '2014-12-15 08:59:59',CheckDate='2014-12-15' where id in(2158512,        
2158513,        
2158498,        
2158519,        
2158568,        
2158569,        
2158534,        
2158584,        
2158552,        
2158523)          
          
          
*/          
alter procedure [dbo].[stu_mc_day_highTw_GetList]          
 @kid int,           
 @page int,           
 @size int,          
 @bgntime varchar(20),          
 @endtime varchar(20),          
 @uname varchar(20),          
 @ftype int          
AS          
BEGIN          
 SET NOCOUNT ON          
          
 DECLARE @fromstring NVARCHAR(2000)          
         
 select * into #data         
  from stu_mc_day smd        
  where smd.kid = @kid        
   and smd.CheckDate>= @bgntime         
    and smd.CheckDate<= @endtime        
            
 SET @fromstring =           
  ' #data smd          
   left join BasicData..User_Child uc          
    on smd.stuid = uc.userid          
   where ftype>0 and (smd.sms_tw >= 37.8 or smd.sms_zz like ''%11%'')'          
           
 IF @uname <> '' SET @fromstring = @fromstring + ' AND uc.name like @S1 + ''%'''             
 IF @ftype =1 SET @fromstring = @fromstring + ' AND smd.ftype =1'         
 else IF @ftype =2 SET @fromstring = @fromstring + ' AND smd.ftype >=2'          
 else SET @fromstring = @fromstring + ' AND smd.ftype >=1'  
          
 exec sp_MutiGridViewByPager          
  @fromstring = @fromstring,  --数据集            
  @selectstring =           
  ' uc.userid,uc.name uname,smd.cdate,smd.sms_tw tw,smd.sms_zz zz,uc.mobile,smd.ftype,uc.cname,smd.id,smd.commit_zz',      --查询字段          
  @returnstring =           
  ' userid, uname, cdate,tw,zz, mobile, ftype,cname,id,commit_zz',      --返回字段          
  @pageSize = @Size,                 --每页记录数          
  @pageNo = @page,                     --当前页          
  @orderString = ' smd.cdate desc,uc.cname',          --排序条件          
  @IsRecordTotal = 1,             --是否输出总记录条数          
  @IsRowNo = 0,           --是否输出行号             
  @S1 = @uname         
        
drop table #data        
           
END 