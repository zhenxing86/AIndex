USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_child_checked_detail_GetList]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



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
 AS       
BEGIN      
--SET NOCOUNT ON    
      
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
--IF ISNULL(@result,'') <> '' SET @Condition = @Condition + ' AND '',''+rm.result LIKE ''%,'+@result+',%'''        
--IF @result = '%' SET @Condition = @Condition + ' AND rm.[status] = 1'      
--IF @status <> -1 and @result <> '%' SET @Condition = @Condition + ' AND rm.[status] = ' + CAST(@status AS NVARCHAR(20))      
--IF @result = '%' SET @Condition = @Condition + ' AND rm.[temperature] <> ''0''' 
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
    rm.temperature, rm.result, rm.outtime, rm.cid, zc.Isweak, count(s.smsid) smsid      
   from dbo.rep_mc_child_checked_detail rm  
    left join mcapp.dbo.zz_counter zc  
   on rm.userid = zc.userid 
   left join sms_mc s
	on s.recuserid=rm.userid 
		and convert(varchar(10),s.sendtime,120)=convert(varchar(10),rm.checktime,120)          
   WHERE '+@Condition    
 +'       
 group by cname, rm.userid, uname, checktime, temperature,result,outtime,rm.cid,Isweak,rm.classorder,rm.checktime 
 )     
 select ' + CAST(@recordTotal AS NVARCHAR(20)) + ' as pcount,  
   cname, userid, uname, checktime, temperature, result, outtime, cid, Isweak ,smsid   
  from cet      
  WHERE '+@tempLimit+' '      
end      
else      
begin        
 SET @sql = '      
  select  TOP('+ CAST(@size AS NVARCHAR(20)) + ')  ' + CAST(@recordTotal AS NVARCHAR(20)) + ' as pcount,         
    rm.cname, rm.userid, rm.uname, rm.checktime,     
    rm.temperature, rm.result, rm.outtime, rm.cid, zc.Isweak,count(s.smsid)     
   from dbo.rep_mc_child_checked_detail rm   
    left join mcapp.dbo.zz_counter zc  
    on rm.userid = zc.userid 
	left join sms_mc s
	on s.recuserid=rm.userid 
		and convert(varchar(10),s.sendtime,120)=convert(varchar(10),rm.checktime,120)              
    WHERE '+@Condition +' group by rm.cname, rm.userid, rm.uname, rm.checktime,     
    rm.temperature, rm.result, rm.outtime, rm.cid,zc.Isweak,rm.classorder ' +@order        
      
end       
      
print @sql      
EXEC(@sql)      
    
END     
  


GO
