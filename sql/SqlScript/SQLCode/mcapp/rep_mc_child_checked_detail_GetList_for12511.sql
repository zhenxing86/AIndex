USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mc_child_checked_detail_GetList_for12511]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[rep_mc_child_checked_detail_GetList_for12511] 2,10,12511,-1,-1,'2014-7-31','2014-8-1','',-1,'',-1  
  
CREATE PROCEDURE [dbo].[rep_mc_child_checked_detail_GetList_for12511]         
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
 DECLARE @beginRow INT        
 DECLARE @endRow INT        
 DECLARE @tempLimit VARCHAR(200)        
 DECLARE @order VARCHAR(200)      
 set @order='order by uc.corder asc, r.cdate desc'     
          
SET @Condition =       
  ' r.kid = '+ CAST(@kid AS NVARCHAR(20))         
  + ' AND r.cdate between '''+ convert(varchar,@checktime1,120) + ''' and ''' + convert(varchar,@checktime2,120)+''''        
IF @gradeid <> -1 SET @Condition = @Condition + ' AND uc.grade = ' + CAST(@gradeid AS NVARCHAR(20))           
IF @cid <> -1 SET @Condition = @Condition + ' AND uc.cid = ' + CAST(@cid AS NVARCHAR(20))          
IF ISNULL(@uname,'') <> ''  SET @Condition = @Condition + ' AND uc.name LIKE '''+@uname+'%'''           
IF @result = '%' SET @Condition = @Condition + ' AND (r.tw <> ''0'' or r.zz<>'''')'      
else if(@result <> '' and @result <> '%')  
SET @Condition = @Condition + ' AND '',''+r.zz+'','' LIKE ''%,'+@result+',%'''       
   
IF @status <> -1 SET @Condition = @Condition + ' AND len(isnull(r.zz,''''))>0 ' 
   
IF @uid <> -1   
begin  
SET @Condition = @Condition + ' AND c.userid = ' + CAST(@uid AS NVARCHAR(20))   
SET @order='order by r.cdate desc'    
end    
              
if (@page>1 )        
begin        
    SET @beginRow = (@page - 1) * @Size    + 1        
    SET @endRow = @page * @Size   
          
    SET @tempLimit = 'rows BETWEEN ' + CAST(@beginRow AS VARCHAR) +' AND '+CAST(@endRow AS VARCHAR)  
      
       print   @tempLimit  
  SET @sql = '        
  ;with cet as(         
  Select ROW_NUMBER() OVER('+@order+') AS rows, Count(*) Over(Partition by r.kid) pcount,uc.cname, c.userid, uc.name uname, r.cdate checktime,r.tw temperature,
         (case when len(isnull(r.zz,''''))>0 then r.zz+'','' else zz end )result, getdate() outtime, uc.cid, Isweak, smsid, gender, headpic, headpicupdate  
    From stu_mc_day_raw r
    inner join cardinfo c on r.card = c.cardno
    left join mcapp.dbo.zz_counter zc on c.userid = zc.userid   
    outer apply (select count(s.smsid) smsid from sms_mc s where s.recuserid=c.userid  and convert(varchar(10),s.sendtime,120)=convert(varchar(10),r.cdate,120)) ss
    inner join basicdata..user_child uc on uc.userid=c.userid
    WHERE '+ @Condition + '     
  )       
  Select pcount,   
         cname, userid, uname, checktime, temperature, result, outtime, cid, Isweak, smsid, gender, headpic, headpicupdate     
    From cet        
    WHERE '+ @tempLimit + ' '        
end        
else        
begin          
  SET @sql = '        
  Select TOP('+ CAST(@size AS NVARCHAR(20)) + ') Count(*) Over(Partition by r.kid) as pcount,    
         uc.cname, c.userid, uc.name uname, r.cdate checktime, r.tw temperature, 
         (case when len(isnull(r.zz,''''))>0 then r.zz+'','' else zz end )result,getdate() outtime, uc.cid, Isweak, smsid, gender, headpic, headpicupdate           
    from stu_mc_day_raw r
    inner join cardinfo c on r.card = c.cardno
    left join mcapp.dbo.zz_counter zc on c.userid = zc.userid   
    outer apply (select count(s.smsid) smsid from sms_mc s where s.recuserid=c.userid  and convert(varchar(10),s.sendtime,120)=convert(varchar(10),r.cdate,120)) ss
    inner join basicdata..user_child uc on uc.userid=c.userid
    WHERE '+ @Condition + @order          
end         
        
print @sql        
EXEC(@sql)        
      
END  



GO
