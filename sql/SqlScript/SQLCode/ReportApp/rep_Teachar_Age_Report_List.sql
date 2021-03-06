USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_Teachar_Age_Report_List]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-04-27  
-- Description: 
-- Memo:  
 EXEC  rep_Teachar_Age_Report_List 12511,'未设置出生日期',1,13,'','',''    
 EXEC  rep_Teachar_Age_Report_List 12511,'未设置出生日期',2,13,'','',''    
*/    
CREATE PROCEDURE [dbo].[rep_Teachar_Age_Report_List]   
 @kid int,  
 @age varchar(30),  
 @page int,  
 @size int,  
 @na varchar(30),  
 @mobile varchar(30),  
 @job varchar(50)  
AS  
BEGIN  
	SET NOCOUNT ON
	
	declare @f int, @l int  
  
if(@age='20岁以下')  
begin  
	set @f=0  
	set @l=21  
end  
else if (@age='21-25岁')  
begin  
	set @f=21  
	set @l=25  
end  
else if (@age='26-30岁')  
begin  
	set @f=25  
	set @l=30  
end  
else if (@age='31-35岁')  
begin  
	set @f=30  
	set @l=35  
end  
else if (@age='36-40岁')  
begin  
	set @f=35  
	set @l=40  
end  
else if (@age='40-45岁')  
begin  
	set @f=40  
	set @l=45  
end  
else if (@age='45-50岁')  
begin  
	set @f=45  
	set @l=50  
end  
else if (@age='50岁以上')  
begin  
	set @f=50  
	set @l=100  
end  
else if (@age='未设置出生日期')  
begin  
	set @f=-1  
	set @l=-1  
end  
else if(@age='合计')  
begin  
	set @f=-1  
	set @l=200  
end  
  
create table #tempList  
(  
	row int IDENTITY(1,1),  
	na varchar(30),  
	sex varchar(30),  
	mobile varchar(30),  
	education varchar(30),  
	age varchar(30),  
	title varchar(30),  
	userid int  
)  
    
 DECLARE @Condition nvarchar(1000), @sql nvarchar(2000)     
 DECLARE @tempCount NVARCHAR(1000)      
 DECLARE @beginRow INT  
    DECLARE @endRow INT  
    DECLARE @recordTotal INT  
    DECLARE @tempLimit VARCHAR(200)  
 SET @Condition = ' r.deletetag = 1 and r.usertype=1 and r.kid = '+ CAST(@kid AS NVARCHAR(20))    
 IF ISNULL(@na,'') <> ''  SET @Condition = @Condition + ' AND r.[name] LIKE %'+@na+'%'''     
 IF @mobile <> '' SET @Condition = @Condition + ' AND r.mobile LIKE ''%'+@mobile+',%'''      
 IF @job <> '' SET @Condition = @Condition + ' AND t.title LIKE ''%'+@job+',%'''  
 IF @age='未设置出生日期'  SET @Condition = @Condition + ' AND nullif(r.birthday,''1900-01-01 00:00:00.000'') is NULL'   
 ELSE IF @age = '合计' SET @Condition = @Condition    
 ELSE SET @Condition = @Condition + ' AND commonfun.dbo.fn_age(r.birthday) >=  ' + CAST(@f AS NVARCHAR(20)) +   
 ' and commonfun.dbo.fn_age(r.birthday) < ' + CAST(@l AS NVARCHAR(20))   
  
    BEGIN  
   SET @tempCount =   
   ' SELECT @recordTotal = COUNT(1)   
     FROM basicdata..teacher t    
      inner join BasicData..[user] r on r.userid=t.userid       
     WHERE '+@Condition  
   EXECUTE sp_executesql @tempCount,N'@recordTotal INT OUTPUT',@recordTotal OUTPUT  
    END  
  
if (@page>1 )  
begin  
    SET @beginRow = (@page - 1) * @Size    + 1  
    SET @endRow = @page * @Size  
    SET @tempLimit = 'rows BETWEEN ' + CAST(@beginRow AS VARCHAR) +' AND '+CAST(@endRow AS VARCHAR)  
 SET @sql = '  
 ;with cet as  
 (  
   select ROW_NUMBER() OVER(order by r.name) AS rows,   
   r.[name] na,case when r.gender = 2 then ''女'' else ''男'' end sex, r.mobile, t.education,  
commonfun.dbo.fn_age(birthday) age,t.title,r.userid,CONVERT(varchar(10),r.birthday,120),headpic, headpicupdate   
   from basicdata..teacher t   
      inner join BasicData..[user] r on r.userid=t.userid       
     WHERE '+@Condition  
 +' 
 ) select ' + CAST(@recordTotal AS NVARCHAR(20)) + ' as pcount,na,sex,mobile,education,age,title,userid from cet  
   WHERE '+@tempLimit  
end  
else  
begin  
  
 SET @sql = '  
  
   select  TOP('+ CAST(@size AS NVARCHAR(20)) + ')  ' + CAST(@recordTotal AS NVARCHAR(20)) + ' as pcount,     
   r.[name] na,case when r.gender = 2 then ''女'' else ''男'' end sex, r.mobile, t.education,  
commonfun.dbo.fn_age(birthday) age, t.title,r.userid,CONVERT(varchar(10),r.birthday,120),headpic, headpicupdate
   from basicdata..teacher t   
      inner join BasicData..[user] r on r.userid=t.userid       
     WHERE '+@Condition  
 +' order by r.[name]'  
    
  
end   
--print @sql  
EXEC(@sql) 

END   


GO
