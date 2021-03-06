USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_child_checked_detail_GetList]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
     
--exec rep_mc_child_checked_detail_GetList @page=1,@size=6,@kid=12511,@gradeid=-1,@cid=-1,@checktime1=N'2014-08-24 00:00:00',@checktime2=N'2014-08-24 23:59:59',@result=N'%',@status=N'-1',@uname=N'',@uid=-1

CREATE PROCEDURE [dbo].[rep_mc_child_checked_detail_GetList]       
  @page int      
 ,@size int      
 ,@kid int      
 ,@gradeid int      
 ,@cid int      
 ,@checktime1 datetime      
 ,@checktime2 datetime      
 ,@result nvarchar(30)      
 ,@status int      
 ,@uname nvarchar(50)      
 ,@uid int
 ,@isnormal int = 0
 AS       
BEGIN      
--SET NOCOUNT ON    

--正常&异常
if @isnormal = 1 
begin 
  Declare @detail Table (pcount Int, cname NVarchar(100), userid Int, uname NVarchar(100), checktime Datetime, temperature Varchar(50), result Varchar(50), outtime Datetime, cid Int,
                         Isweak bit, smsid Int, gender Int, headpic Varchar(50), headpicupdate Varchar(50))
  if @page > 1
    with cte as (
    Select Count(*) Over() pcount, rm.cname, rm.userid, rm.uname, rm.checktime, rm.temperature, rm.result, rm.outtime, rm.cid, 
           Cast(0 as bit) Isweak, Cast(0 as int) smsid, Cast(3 as int) gender, Cast('' as Varchar(50)) headpic, Cast('' as Varchar(50)) headpicupdate,
           Row_number() Over(Order by rm.classorder asc, rm.checktime desc) RowNo
      From dbo.rep_mc_child_checked_detail rm
      Where rm.kid = @kid and (@gradeid = -1 Or rm.gradeid = @gradeid) and (@cid = -1 Or rm.cid = @cid) and (@uid = -1 or rm.userid = @uid) and rm.dotime between @checktime1 and @checktime2
        and (@result = '' Or (@result = '%' and (rm.[temperature] <> '0' Or rm.result <> '')) Or '%,' + rm.result LIKE '%,' + @result + ',%')
        and (@status = -1 Or rm.[status] = @status)
    )
    Insert Into @detail(pcount, cname, userid, uname, checktime, temperature, result, outtime, cid, Isweak, smsid, gender, headpic, headpicupdate)
      Select pcount, cname, userid, uname, checktime, temperature, result, outtime, cid, Isweak, smsid, gender, headpic, headpicupdate
        From cte Where RowNo between (@page - 1) * @Size + 1 and @page * @Size Order by RowNo
  else
    Insert Into @detail(pcount, cname, userid, uname, checktime, temperature, result, outtime, cid, Isweak, smsid, gender, headpic, headpicupdate)
      Select Top (@size) Count(*) Over() pcount, rm.cname, rm.userid, rm.uname, rm.checktime, rm.temperature, rm.result, rm.outtime, rm.cid, 
             Cast(0 as bit) Isweak, Cast(0 as int) smsid, Cast(3 as int) gender, Cast('' as Varchar(50)) headpic, Cast('' as Varchar(50)) headpicupdate
        From dbo.rep_mc_child_checked_detail rm
        Where rm.kid = @kid and (@gradeid = -1 Or rm.gradeid = @gradeid) and (@cid = -1 Or rm.cid = @cid) and (@uid = -1 or rm.userid = @uid) and rm.dotime between @checktime1 and @checktime2
          and (@result = '' Or (@result = '%' and (rm.[temperature] <> '0' Or rm.result <> '')) Or '%,' + rm.result LIKE '%,' + @result + ',%')
          and (@status = -1 Or rm.[status] = @status)
        Order by rm.classorder asc, rm.checktime desc
  
  Update a Set Isweak = b.Isweak
    From @detail a, mcapp.dbo.zz_counter b 
    Where a.userid = b.userid
 
  Update a Set smsid = b.smsid
    From @detail a, (Select recuserid, convert(varchar(10),sendtime,120) sendtime, Count(*) smsid From sms_mc Group by recuserid, convert(varchar(10),sendtime,120)) b
    Where a.userid = b.recuserid and convert(varchar(10), a.checktime, 120) = b.sendtime

  Select * From @detail
end

--异常
else begin
  Select Top (@size) checkdate checktime, kid, stuid userid, str(tw,5,2) temperature, zz + ',' result, Cast(0 as bit) Isweak, cdate
    Into #zz
    From stu_mc_day_zz
    Where kid = @kid and checkdate between convert(varchar,@checktime1,120) and convert(varchar,@checktime2,120) 
      and '%,'+ zz + ',%' Like '%,'+ @result + ',%'

  if @cid <> -1
    Delete #zz Where userid not In (Select userid From basicdata.dbo.user_class Where cid = @cid)

  if @gradeid <> -1
    Delete #zz Where userid not In (Select userid From basicdata.dbo.user_child Where grade = @gradeid and kid = @kid)

  if @uid <> -1
    Delete #zz Where userid <> @uid

  Update a Set Isweak = b.Isweak
    From #zz a, mcapp.dbo.zz_counter b 
    Where a.userid = b.userid

  Select @size pcount, b.cname, a.userid, b.name uname, cdate checktime, a.temperature, a.result, CAST(null AS DATETIME) outtime, b.cid, a.Isweak, Cast(0 as int) smsid, 
         b.gender, b.headpic, headpicupdate
    From #zz a, BasicData..User_Child b
    Where a.userid = b.userid 
    Order by a.cdate desc
end

/*
 DECLARE @Condition nvarchar(1000), @sql nvarchar(2000)         
 DECLARE @tempCount NVARCHAR(1000)          
 DECLARE @beginRow INT      
 DECLARE @endRow INT      
 DECLARE @recordTotal INT      
 DECLARE @tempLimit VARCHAR(200)      
 DECLARE @order VARCHAR(200)    
 set @order='order by rm.classorder asc, rm.checktime desc'   
        
SET @Condition =     
  ' rm.kid = '+ CAST(@kid AS NVARCHAR(20))       
  + ' AND rm.dotime between '''+ convert(varchar,@checktime1,120) + ''' and ''' + convert(varchar,@checktime2,120)+''''      
IF @gradeid <> -1 SET @Condition = @Condition + ' AND rm.gradeid = ' + CAST(@gradeid AS NVARCHAR(20))         
IF @cid <> -1 SET @Condition = @Condition + ' AND rm.cid = ' + CAST(@cid AS NVARCHAR(20))        
IF ISNULL(@uname,'') <> ''  SET @Condition = @Condition + ' AND rm.uname LIKE '''+@uname+'%'''         
IF @result = '%' SET @Condition = @Condition + ' AND (rm.[temperature] <> ''0'' or result<>'''')'    
else if(@result <> '' and @result <> '%')
SET @Condition = @Condition + ' AND '',''+rm.result LIKE ''%,'+@result+',%'''     
 
IF @status <> -1 SET @Condition = @Condition + ' AND rm.[status] = ' + CAST(@status AS NVARCHAR(20))   
 
 
 
IF @uid <> -1 
begin
SET @Condition = @Condition + ' AND rm.userid = ' + CAST(@uid AS NVARCHAR(20)) 
SET @order='order by rm.checktime desc'  
end  
      
 BEGIN      
  SET @tempCount =       
   ' SELECT @recordTotal = COUNT(1)       
     FROM  dbo.rep_mc_child_checked_detail rm          
     WHERE '+@Condition      
  EXECUTE sp_executesql @tempCount,N'@recordTotal INT OUTPUT',@recordTotal OUTPUT      
 END      
        
      
if (@page>1 )      
begin      
    SET @beginRow = (@page - 1) * @Size    + 1      
    SET @endRow = @page * @Size 
        
    SET @tempLimit = 'rows BETWEEN ' + CAST(@beginRow AS VARCHAR) +' AND '+CAST(@endRow AS VARCHAR)
    
       print   @tempLimit
 SET @sql = '      
 ;with cet as      
 (      
   select ROW_NUMBER() OVER('+@order+') AS rows,       
    rm.cname, rm.userid, rm.uname, rm.checktime,     
    rm.temperature, rm.result, rm.outtime, rm.cid, zc.Isweak, count(s.smsid) smsid ,u.gender,u.headpic, u.headpicupdate     
   from dbo.rep_mc_child_checked_detail rm  
    left join mcapp.dbo.zz_counter zc  
   on rm.userid = zc.userid 
   left join sms_mc s
	on s.recuserid=rm.userid 
		and convert(varchar(10),s.sendtime,120)=convert(varchar(10),rm.checktime,120)
	inner join BasicData..[user] u 
				on u.userid=rm.userid               
   WHERE '+@Condition    
 +'       
 group by cname, rm.userid, uname, checktime, temperature,result,outtime,rm.cid,Isweak,rm.classorder,rm.checktime,u.gender,u.headpic, u.headpicupdate 
 )     
 select ' + CAST(@recordTotal AS NVARCHAR(20)) + ' as pcount,  
   cname, userid, uname, checktime, temperature, result, outtime, cid, Isweak ,smsid,gender,headpic, headpicupdate   
  from cet      
  WHERE '+@tempLimit+' '      
end      
else      
begin        
 SET @sql = '      
  select  TOP('+ CAST(@size AS NVARCHAR(20)) + ')  ' + CAST(@recordTotal AS NVARCHAR(20)) + ' as pcount,         
    rm.cname, rm.userid, rm.uname, rm.checktime,     
    rm.temperature, rm.result, rm.outtime, rm.cid, zc.Isweak,count(s.smsid),u.gender,u.headpic, u.headpicupdate     
   from dbo.rep_mc_child_checked_detail rm   
    left join mcapp.dbo.zz_counter zc  
    on rm.userid = zc.userid 
	left join sms_mc s
	on s.recuserid=rm.userid 
		and convert(varchar(10),s.sendtime,120)=convert(varchar(10),rm.checktime,120)  
	inner join BasicData..[user] u 
				on u.userid=rm.userid             
    WHERE '+@Condition +' group by rm.cname, rm.userid, rm.uname, rm.checktime,     
    rm.temperature, rm.result, rm.outtime, rm.cid,zc.Isweak,rm.classorder,u.gender,u.headpic, u.headpicupdate ' +@order        
      
end       
      
print @sql      
EXEC(@sql)      
*/    
END     

GO
