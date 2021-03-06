USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[growthbook_rep_GetList_Detail]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[growthbook_rep_GetList_Detail]   
@kid int  
,@kname nvarchar(100)  
,@applytime1 datetime  
,@applytime2 datetime  
,@status int  
,@page int  
,@size int  
,@cuid int =0
,@uname varchar(50)=''  
AS  
  
  
  
  
  
declare @usertype int, @bid int, @duty varchar(20), @jxsid int  
  
 select @usertype = usertype,   
     @bid = bid, @duty = duty, @jxsid = jxsid   
  from users u  
   inner join [role] r   
    on u.roleid = r.ID  
  where u.ID = @cuid  
  
  
  
  
  
 create table #ulist(puid int)  
   
   
 if(@jxsid <> '' and @jxsid > 0)--经销商  
 begin  
  insert into #ulist(puid) values (@cuid)  
  insert into #ulist(puid)  
   select ID   
    from users   
    where seruid = @cuid  
  insert into #ulist(puid)  
   select cuid   
    from users_belong   
    where puid = @cuid   
     and deletetag = 1  
       
  if(@bid > 0 and @duty = '客服部')  
   BEGIN  
    insert into #ulist(puid)  
    SELECT DISTINCT u.ID FROM users u  
     where   
      u.bid = @bid and jxsid=@jxsid  
      and not exists (select 1 from #ulist where puid = u.ID)  
   END   
   --代理商管理员  
   if(@bid > 0 and @usertype = 0)  
   BEGIN  
    insert into #ulist(puid)  
    SELECT DISTINCT u.ID FROM users u  
     where   
      u.bid = @bid and jxsid=@jxsid  
      and not exists (select 1 from #ulist where puid = u.ID)  
     
   END  
   
 END  
 else  
 BEGIN  
  if (@bid > 0 or @duty <> '客服部')  
  BEGIN  
    
   insert into #ulist(puid) values (@cuid)  
   insert into #ulist(puid)  
    select ID   
     from users   
     where seruid = @cuid  
   insert into #ulist(puid)  
    select cuid   
     from users_belong   
     where puid = @cuid   
      and deletetag = 1   
        
   if(@bid > 0 and @duty = '客服部')  
   BEGIN  
     
    insert into #ulist(puid)    
    SELECT DISTINCT u.ID FROM agentjxs bj   
     inner join users u   
      on bj.ID = u.jxsid   
     where   
      (bj.bid = @bid or u.bid=@bid)  
      and not exists (select 1 from #ulist where puid = u.ID)  
        
        
    insert into #ulist(puid)    
    SELECT DISTINCT u.ID FROM users u   
     where   
      u.bid=@bid  
      and not exists (select 1 from #ulist where puid = u.ID)  
        
   END   
   --代理商管理员  
   if(@bid > 0 and @usertype = 0)  
   BEGIN  
    insert into #ulist(puid)  
    SELECT DISTINCT u.ID FROM users u  
     where   
      u.bid = @bid  
      and not exists (select 1 from #ulist where puid = u.ID)  
     
   END  
      
  END  
 END  
  
  
  
  
  
  
declare @pcount int  
  
SELECT @pcount=count(1) FROM gbapp..archives_apply aa  
   inner join kinbaseinfo  kb   
    on kb.kid= aa.kid  
   where   ((EXISTS(SELECT * FROM #ulist u WHERE (u.puid = kb.developer )) or kb.uid=convert(varchar,@cuid)) or (@bid=0 and @duty='客服部'))  
   and (aa.kid=@kid or @kid=-1)  
   and (aa.kname like @kname+'%')  
   and (aa.applytime >=@applytime1 or @applytime1<'1950-1-1')  
   and (aa.applytime <=@applytime2 or @applytime2<'1950-1-1')  
   and (aa.[status]=@status or @status=-100)  
  
    
  
IF(@page>1)  
 BEGIN  
   
  DECLARE @prep int,@ignore int  
  
  SET @prep=@size*@page  
  SET @ignore=@prep-@size  
  
  DECLARE @tmptable TABLE  
  (  
   row int IDENTITY(1,1),  
   tmptableid bigint  
  )  
  
   SET ROWCOUNT @prep  
   INSERT INTO @tmptable(tmptableid)  
   SELECT  archivesapplyid  FROM gbapp..archives_apply aa  
   inner join kinbaseinfo  kb   
    on kb.kid= aa.kid  
   where   ((EXISTS(SELECT * FROM #ulist u WHERE (u.puid = kb.developer )) or kb.uid=convert(varchar,@cuid)) or (@bid=0 and @duty='客服部'))  
   and (aa.kid=@kid or @kid=-1)  
   and (aa.kname like @kname+'%')  
   and (applytime >=@applytime1 or @applytime1<'1950-1-1')  
   and (applytime <=@applytime2 or @applytime2<'1950-1-1')  
   and (aa.[status]=@status or @status=-100)  
   and (aa.username like @uname+'%') 
  order by aa.archivesapplyid desc
  
   SET ROWCOUNT @size  
   SELECT   
    @pcount ,userid,cname,username,applytime,[status],handletime,kname,telephone,kid ,g.archivesapplyid,g.term 
     FROM   
    @tmptable AS tmptable    
   INNER JOIN gbapp..archives_apply g  
   ON  tmptable.tmptableid=g.archivesapplyid    
   WHERE  
    row>@ignore   
  
end  
else  
begin  
SET ROWCOUNT @size  
  
select @pcount,aa.userid,aa.cname,aa.username,aa.applytime,aa.[status],aa.handletime,aa.kname,aa.telephone,aa.kid,aa.archivesapplyid,aa.term from gbapp..archives_apply aa  
inner join kinbaseinfo  kb   
on kb.kid= aa.kid  
where   ((EXISTS(SELECT * FROM #ulist u WHERE (u.puid = kb.developer )) or kb.uid=convert(varchar,@cuid)) or (@bid=0 and @duty='客服部'))  
and (aa.kid=@kid or @kid=-1)  
and (aa.kname like @kname+'%')  
and (applytime >=@applytime1 or @applytime1<'1950-1-1')  
and (applytime <=@applytime2 or @applytime2<'1950-1-1')  
and (aa.[status]=@status or @status=-100)  
and (aa.username like @uname+'%')  
order by aa.archivesapplyid desc
end  
  
  
  
drop table #ulist  
  
GO
