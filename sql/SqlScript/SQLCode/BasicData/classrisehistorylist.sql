USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[classrisehistorylist]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*              
-- Author:                 
-- Create date:  2014-8-22      
-- Description: 获取升班历史记录           
-- Paradef:               
-- Memo: exec classrisehistorylist 2625,0,1,10      
*/           
CREATE proc [dbo].[classrisehistorylist]      
@kid int,      
@cid int,      
@page int,      
@size int      
as      
BEGIN      
declare @pcount int=0      
if(@kid>0) and @cid>0      
begin      
select @pcount=COUNT(1) from BasicData..class_changehistory where    cid=@cid and kid=@kid      
end      
else if(@kid>0)      
begin      
select @pcount=COUNT(1) from BasicData..class_changehistory where kid=@kid      
end      
 IF(@page>1)      
 BEGIN      
  DECLARE @count int      
  DECLARE @ignore int      
  SET @count=@page*@size      
  SET @ignore=@count-@size      
  DECLARE @tempTable TABLE      
  (      
   row int identity(1,1) primary key,      
   tempid int      
  )        
  SET ROWCOUNT @count      
  IF(@kid>0) AND (@cid>0)      
  BEGIN      
   INSERT INTO @tempTable SELECT t1.id FROM basicdata..class_changehistory t1      
  WHERE cid=@cid  AND kid=@kid       
  ORDER BY  t1.actiondate desc      
  END      
  ELSE IF(@kid>0)      
  BEGIN      
   INSERT INTO @tempTable SELECT t1.id FROM basicdata..class_changehistory t1      
  WHERE   kid=@kid       
  ORDER BY  t1.actiondate desc      
  END      
      
  SELECT  @pcount,t1.cid,t1.cname,t1.newgrade,t1.oldgrade,t1.douserid,t1.actiondate,t4.gname,t3.gname,u.name,t1.oldcname      
  FROM basicdata..class_changehistory t1      
  JOIN @tempTable t2 ON t1.id=t2.tempid      
  LEFT JOIN BasicData..[USER] U ON t1.douserid=u.userid and u.deletetag=1      
  LEFT JOIN BasicData..grade t3 ON t1.newgrade=t3.gid       
  LEFT JOIN BasicData..grade t4 ON t1.oldgrade=t4.gid       
  WHERE tempid=t1.id AND row>@ignore      
  ORDER BY  t1.actiondate desc      
 END      
 ELSE      
 BEGIN      
  SET ROWCOUNT @size      
  --SELECT t1.cid,t1.cname,t1.newgrade,t1.oldgrade,t1.douserid,t1.actiondate,t2.gname,t3.gname FROM  basicdata..class_changehistory t1      
  --LEFT JOIN BasicData..grade t2 ON t1.newgrade=t2.gid        
  --LEFT JOIN BasicData..grade t3 ON t1.oldgrade=t3.gid       
  --WHERE t1.cid=@cid and t1.kid=@kid      
  --ORDER BY t1.actiondate desc      
        
  DECLARE @strsql varchar(max)      
  set @strsql='       
  SELECT '+CAST (@pcount as varchar(50))+',t1.cid,t1.cname,t1.newgrade,t1.oldgrade,t1.douserid,t1.actiondate,t3.gname,t2.gname,u.name,t1.oldcname FROM  basicdata..class_changehistory t1      
  LEFT JOIN BasicData..[USER] U ON t1.douserid=u.userid and u.deletetag=1      
  LEFT JOIN BasicData..grade t2 ON t1.newgrade=t2.gid        
  LEFT JOIN BasicData..grade t3 ON t1.oldgrade=t3.gid where 1=1'      
        
  if(@kid>0)      
  begin      
  set @strsql=@strsql+' and  t1.kid='+cast(@kid as varchar(50))      
  end      
   if(@cid>0)      
  begin      
  set @strsql=@strsql+' and  t1.cid='+cast(@cid as varchar(50))      
  end      
        
  set @strsql=@strsql+' ORDER BY t1.actiondate desc'      
  exec (@strsql)      
 END      
END 
GO
