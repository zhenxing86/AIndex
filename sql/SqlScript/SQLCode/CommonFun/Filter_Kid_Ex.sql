USE [CommonFun]
GO
/****** Object:  StoredProcedure [dbo].[Filter_Kid_Ex]    Script Date: 2014/11/24 22:58:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                  
-- Author:      xie                
-- Create date:                   
-- Description:                   
-- Memo:                    
                  
DECLARE  @provinceid int, @cityid int, @areaid int, @kname varchar(50), @kid int, @flag int                  
CREATE TABLE #kid(kid int)                  
EXEC @flag = CommonFun.DBO.Filter_Kid_Ex -1,'','','','',132,''                
SELECT * FROM #kid                  
SELECT @flag                  
drop table #kid       
    
select             
                
CREATE TABLE #kid(kid int)                 
                
*/                  
CREATE PROC [dbo].[Filter_Kid_Ex]                  
 @kid int,                  
 @kname varchar(100),                  
 @privince varchar(100),                  
 @city varchar(100),                  
 @area varchar(100),                    
 @cuid int,                   
 @developer varchar(100),
 @seeself int=0 --针对客服可以选择看自己跟进还是看所有幼儿园           
                 
AS                  
BEGIN                 
                
 SET NOCOUNT ON                  
 SET @kname = CommonFun.dbo.FilterSQLInjection(@kname)                  
 SET @privince = CommonFun.dbo.FilterSQLInjection(@privince)                  
 SET @city = CommonFun.dbo.FilterSQLInjection(@city)                  
 SET @area = CommonFun.dbo.FilterSQLInjection(@area)                  
 --SET @developer = CommonFun.dbo.FilterSQLInjection(@developer)                   
 set @developer=''           
 set @kid=case when @kid<=0 then -1 else @kid end        
         
 IF ISNULL(@privince,'') = '' AND ISNULL(@city,'') = '' AND ISNULL(@area,'') = '' AND ISNULL(@kname,'') = '' and ISNULL(@kid,-1) = -1                  
 and ISNULL(@cuid,-1) = -1  AND ISNULL(@developer,'') = ''                 
  BEGIN                  
   RETURN -1                    
  END                  
                 
 declare @usertype int, @bid int, @duty varchar(20), @jxsid int,@dutyname varchar(100)                
                  
  select @usertype = usertype,                   
   @bid = bid, @duty = duty, @jxsid = jxsid ,@dutyname=r.name                  
   from ossapp..users u                  
    inner join ossapp..[role] r                   
  on u.roleid = r.ID                  
   where u.ID = @cuid                  
                  
 create table #ulist(puid int)                  
                   
 if(@jxsid <> '' and @jxsid > 0)--begin经销商                  
 BEGIN                  
  insert into #ulist(puid) values (@cuid)                  
  insert into #ulist(puid)                  
   select ID                   
    from ossapp..users                   
    where seruid = @cuid                  
  insert into #ulist(puid)                  
   select cuid                   
    from ossapp..users_belong                   
    where puid = @cuid                   
     and deletetag = 1                  
                       
  if(@bid > 0 and @duty = '客服部')                  
   BEGIN                  
    insert into #ulist(puid)                  
    SELECT DISTINCT u.ID FROM ossapp..users u                  
     where                   
      u.bid = @bid and jxsid=@jxsid                  
      and not exists (select 1 from #ulist where puid = u.ID)                  
   END                   
   --代理商管理员                  
   if(@bid > 0 and @usertype = 0)                  
   BEGIN                  
    insert into #ulist(puid)                  
    SELECT DISTINCT u.ID FROM ossapp..users u                  
     where                   
      u.bid = @bid and jxsid=@jxsid                  
      and not exists (select 1 from #ulist where puid = u.ID)                      
   END                  
                   
 END --end 经销商                 
 ELSE                  
 BEGIN                  
  if (@bid > 0 or @duty <> '客服部')                  
  BEGIN               
   insert into #ulist(puid) values (@cuid)                  
   insert into #ulist(puid)                  
    select ID                   
     from ossapp..users                   
     where seruid = @cuid     
   insert into #ulist(puid)                  
    select cuid                   
     from ossapp..users_belong                   
     where puid = @cuid                   
      and deletetag = 1               
                        
   if(@bid > 0 and @duty = '客服部')                  
   BEGIN               
    insert into #ulist(puid)                    
    SELECT DISTINCT u.ID FROM ossapp..agentjxs bj                   
     inner join ossapp..users u                   
      on bj.ID = u.jxsid                   
     where                   
      (bj.bid = @bid or u.bid=@bid)                  
      and not exists (select 1 from #ulist where puid = u.ID)                  
                                  
    insert into #ulist(puid)                    
    SELECT DISTINCT u.ID FROM ossapp..users u                   
     where                   
      u.bid=@bid                  
      and not exists (select 1 from #ulist where puid = u.ID)                   
   END                   
   --代理商管理员                  
   if(@bid > 0 and @usertype = 0)                  
   BEGIN                  
    insert into #ulist(puid)                  
    SELECT DISTINCT u.ID FROM ossapp..users u                  
     where                   
     u.bid = @bid                  
      and not exists (select 1 from #ulist where puid = u.ID)             
   END                  
  END            
 END                  
    
 IF @bid=0    
  BEGIN    
 insert into #ulist(puid)  SELECT @cuid    
  END      
        
 declare @pcount int, @Condition varchar(2000),                   
     @filter varchar(1000), @tempMain nvarchar(4000)                  
                       
 SET @Condition =                   
 ' WHERE 1=1'                  
 if ISNULL(@kid,-1) <> -1 SET @Condition = @Condition + CHAR(13) + CHAR(10) + '   AND kb.kid = '+convert(varchar,@kid)                  
 if ISNULL(@kname,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '   AND kb.kname like ''%'+@kname+'%'''                  
 if ISNULL(@privince,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '   AND kb.privince = '''+@privince+''''                  
 if ISNULL(@city,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '   AND kb.city = '''+@city+''''                  
 if ISNULL(@area,'') <> '' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '    AND kb.area = '''+@area+''''                  
 if @bid=0 and @duty='客服部' set @Condition = @Condition                   
 ELSE                 
 begin                
 SET @Condition = @Condition + CHAR(13) + CHAR(10) + '   AND kb.status <> ''待删除'''                  
 if ISNULL(@developer,'') <> '' and ISNULL(@developer,'') <> '-2' SET @Condition = @Condition + CHAR(13) + CHAR(10) + '   AND kb.developer = '''+@developer+''''                  
 end                
                 
--查询家长学校                  
 if (@developer='-2' or @dutyname = '家长学校客服')                  
 begin                  
  SET @Condition = @Condition + CHAR(13) + CHAR(10) + ' AND kb.remark like ''%创典%'''                  
 end                  
                   
 --if(@bid=0 and @duty='客服部' and @dutyname='管理员')    
 if(@bid=0 and @duty='客服部' and @seeself=0)                    
  SET @filter = ''                  
 else                   
  --SET @filter = ' AND (EXISTS(SELECT * FROM #ulist u WHERE (u.puid = kb.developer )) or kb.uid='+convert(varchar,@cuid)+' ) '                  
  SET @filter = ' AND (EXISTS(SELECT * FROM #ulist u WHERE (u.puid = kb.developer ))) '     
                  
 SET @tempMain =                   
 'INSERT INTO #kid                
   SELECT kb.kid FROM ossapp..kinbaseinfo kb                    
 ' + @Condition +  @filter                  
                
 PRINT @tempMain                 
 EXECUTE (@tempMain)                  
return 1                
                
END 
GO
