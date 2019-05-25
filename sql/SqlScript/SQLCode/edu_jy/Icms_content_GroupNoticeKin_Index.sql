
------------------------------------  
--用途：查询记录信息   
--项目名称：  
--说明：  
--时间：2012/2/6 11:47:05  
------------------------------------  
  
CREATE PROCEDURE [dbo].[Icms_content_GroupNoticeKin_Index]  
@siteid int  
,@page int  
,@size int  
,@firsttime datetime  
,@lasttime datetime  
,@title varchar(100)  
  
 AS  
  
if(@firsttime = '')  
BEGIN  
set @firsttime=convert(datetime,'1900-01-01')  
End  
  
  
if(@lasttime = '')  
BEGIN  
set @lasttime=convert(datetime,'2090-01-01')  
End  
  
set @lasttime=dateadd(day,1,@lasttime)  
  
declare @pcount int,@p int  
  
  
  
select @pcount=count(contentid) from cms_content where   
siteid=@siteid  
and createdatetime >@firsttime   
and createdatetime <= @lasttime   
and title like '%'+@title+'%'  
and [status]=2  
  
  
  
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
select contentid  
  from cms_content   
  where   
   siteid=@siteid  
   and createdatetime >@firsttime   
   and createdatetime <= @lasttime   
   and title like '%'+@title+'%'  
   and [status]=2  
  order by createdatetime desc  
  
  
  
   SET ROWCOUNT @size  
  
   SELECT   
    @pcount,t1.contentid,title,content,createdatetime,author,a.ishow  
   FROM   
    @tmptable AS tmptable    
   INNER JOIN cms_content t1  
   ON  tmptable.tmptableid=t1.contentid    
   left join ActicleState a on a.contentid=t1.contentid    
   WHERE  
    row>@ignore   
  
end  
else  
begin  
SET ROWCOUNT @size  
  
select @pcount,c.contentid,title,content,createdatetime,author,a.ishow  
  from cms_content c  
  left join ActicleState a on a.contentid=c.contentid    
  where   
   siteid=@siteid  
   and createdatetime >@firsttime   
   and createdatetime <= @lasttime   
   and title like '%'+@title+'%'  
   and [status]=2  
  order by createdatetime desc  
  
end  
  
  