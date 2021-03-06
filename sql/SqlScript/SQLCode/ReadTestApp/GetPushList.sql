USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[GetPushList]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
-- =============================================            
       
/*       
BasicData..grade      
 select top 50 u.userid,  u.name,u.account,u.password,u.jzxxgrade from BasicData..[user] u       
          
   where     roletype=3 and deletetag=1      
        
  select *from basicdata..user_class where uid=87773          
        
memo: exec [GetPushList]  1,6,825150    
*/            
-- =============================================          
CREATE PROCEDURE [dbo].[GetPushList]  
 @page int,      
@size int,      
@uid int=0     
 AS   
  
       
 declare @pcount int,  @grade int            
     select  @grade=jzxxgrade from BasicData..[user] where userid=@uid  
     if(@grade<35) or (@grade>37)  
     begin  
     set @grade=35  
     end  
      
  SELECT @pcount=count(1) FROM push where grade=@grade  and   pushdatetime<=getdate()  
     
  
IF(@page>1)  
 BEGIN  
   
  DECLARE @prep int,@ignore int  
  
  SET @prep=@size*@page  
  SET @ignore=@prep-@size  
  
  --if(@pcount<@ignore)  
  --begin  
  -- set @page=@pcount/@size  
  -- if(@pcount%@size<>0)  
  -- begin  
  --  set @page=@page+1  
  -- end  
  -- SET @prep=@size*@page  
  -- SET @ignore=@prep-@size  
  --end  
  
  DECLARE @tmptable TABLE  
  (  
   row int IDENTITY(1,1),  
   tmptableid bigint  
  )  
  
   SET ROWCOUNT @prep  
   
    INSERT INTO @tmptable(tmptableid)  
   SELECT  ID  FROM push    
   where  pushdatetime<=getdate() and grade=@grade  
   order by  pushdatetime desc,categoryid asc  
     
   SET ROWCOUNT @size  
   SELECT   
   @pcount, g.title  , g.describe  ,c.categorytitle  ,g.pushdatetime,
   case when CHARINDEX('TestPaper/Index',g.url)>0 then  
 case when SUBSTRING(g.url,len(g.url),len(g.url))='/' then  g.url+  CAST(@uid as varchar(50))+'?pushid='+CAST(g.ID as varchar(50)) else g.url+ '/'+ CAST(@uid as varchar(50))+'?pushid='+CAST(g.ID as varchar(50)) end
 else
  g.url+'?uid='+cast(@uid as varchar(50))+'&pushid='+cast(g.ID as varchar(50)) end url,
     isnull(rc.[count],0) rcount
          FROM  
    @tmptable AS tmptable    
   INNER JOIN push g  
   ON  tmptable.tmptableid=g.ID   
   left join Category c on g.categoryid=c.id 
   left join ReadCount rc on rc.userid=@uid and rc.pushid=g.ID  
   WHERE  
    row>@ignore   
  
end  
else  
begin  
SET ROWCOUNT @size  
   
 SELECT @pcount  , g.title  , g.describe  ,c.categorytitle  ,g.pushdatetime, 
 case when CHARINDEX('TestPaper/Index',g.url)>0 then  
 case when SUBSTRING(g.url,len(g.url),len(g.url))='/' then  g.url+  CAST(@uid as varchar(50))+'?pushid='+CAST(g.ID as varchar(50)) else g.url+ '/'+ CAST(@uid as varchar(50))+'?pushid='+CAST(g.ID as varchar(50)) end
 else
  g.url+'?uid='+cast(@uid as varchar(50))+'&pushid='+cast(g.ID as varchar(50)) end url,
     isnull(rc.[count],0) rcount    
   FROM  
     push g left join Category c on g.categoryid=c.id  
      left join ReadCount rc on rc.userid=@uid and rc.pushid=g.ID    
     where  pushdatetime<=getdate()  and grade=@grade order by g.pushdatetime desc,g.categoryid asc  
       
       
     
end  
  
GO
