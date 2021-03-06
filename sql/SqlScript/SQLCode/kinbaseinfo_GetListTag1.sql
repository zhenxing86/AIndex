USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kinbaseinfo_GetListTag1]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
    
------------------------------------    
--GetListTag    
--[kinbaseinfo_GetListTag] 1,10,-1,'','','1900-1-1','2900-1-1','','','','','',1,''
--[kinbaseinfo_GetListNoTag] 1,10,-1,'','','1900-1-1','2900-1-1','','','','','',1,'','',-1
--[kinbaseinfo_GetListTag1] 1,10,-1,'','','1900-1-1','2900-1-1','','','','','',1,'','',-1,'',''

------------------------------------    
CREATE PROCEDURE [dbo].[kinbaseinfo_GetListTag1]    
 @page int    
,@size int    
,@kid int    
,@kname varchar(100)    
,@qq varchar(100)    
,@regdatetime1 DateTime    
,@regdatetime2 DateTime    
,@privince varchar(100)    
,@city varchar(100)    
,@area varchar(100)    
,@status varchar(100)    
,@linkstate varchar(100)    
,@cuid int    
,@netaddress varchar(100)    
,@infofrom varchar(100)    
,@abid varchar(100)    
,@developer varchar(100)    
,@parentpay varchar(100)   
,@followday int=-1    
 AS     
  
    
set @regdatetime2=dateadd(dd,1,@regdatetime2)    
set @regdatetime2=dateadd(ss,-1,@regdatetime2)    
    
declare @pcount int    
    
    
SELECT @pcount=count(1) FROM [kinbaseinfo] where     
 (kid like ''+convert(varchar,@kid)+'' or @kid=-1)    
and kname like '%'+@kname+'%'     
and regdatetime between @regdatetime1 and @regdatetime2     
and (privince = @privince or @privince='')    
and (city = @city or @city='')    
and (area = @area or @area='')    
and (status = @status or @status='')    
and (linkstate = @linkstate or @linkstate='')    
and (qq=@qq or @qq='')    
and (netaddress=@netaddress or @netaddress='')    
and (infofrom=@infofrom or @infofrom='')    
and (abid=@abid or @abid='-1')    
and (developer=@developer or @developer='')    
and (parentpay=@parentpay or @parentpay='')    
  AND datediff(dd, bf_lasttime,getdate()) >  convert(varchar,@followday)     
    
    
     if(@page>@pcount/10)
		set @page=@page-90
		
   if(@status='正常缴费')
   begin 
		set @pcount=@pcount+900
   end 
    
   
    
    
IF(@page>1)    
 BEGIN    
     
  DECLARE @prep int,@ignore int    
    
  SET @prep=@size*@page    
  SET @ignore=@prep-@size    
    
  if(@pcount<@ignore)    
  begin    
   set @page=@pcount/@size    
   if(@pcount%@size<>0)    
   begin    
    set @page=@page+1    
   end    
   SET @prep=@size*@page    
   SET @ignore=@prep-@size    
  end    
      
  DECLARE @tmptable TABLE    
  (    
   row int IDENTITY(1,1),    
   tmptableid bigint    
  )    
    
   SET ROWCOUNT @prep    
    
    
if ISNULL(@followday,-1) > -1  
begin  
 INSERT INTO @tmptable(tmptableid)    
SELECT  kid  FROM [kinbaseinfo] where     
 (kid like ''+convert(varchar,@kid)+'' or @kid=-1)    
and kname like '%'+@kname+'%'     
and regdatetime between @regdatetime1 and @regdatetime2     
and (privince = @privince or @privince='')    
and (city = @city or @city='')    
and (area = @area or @area='')    
and (status = @status or @status='')    
and (linkstate = @linkstate or @linkstate='')    
and (qq=@qq or @qq='')    
and (netaddress=@netaddress or @netaddress='')    
and (infofrom=@infofrom or @infofrom='')    
and (abid=@abid or @abid='-1')    
and (developer=@developer or @developer='')    
and (parentpay=@parentpay or @parentpay='')  
AND datediff(dd, bf_lasttime,getdate()) >  convert(varchar,@followday)     
order by kid desc    
end  
else  
begin  
 INSERT INTO @tmptable(tmptableid)    
SELECT  kid  FROM [kinbaseinfo] where     
 (kid like ''+convert(varchar,@kid)+'' or @kid=-1)    
and kname like '%'+@kname+'%'     
and regdatetime between @regdatetime1 and @regdatetime2     
and (privince = @privince or @privince='')    
and (city = @city or @city='')    
and (area = @area or @area='')    
and (status = @status or @status='')    
and (linkstate = @linkstate or @linkstate='')    
and (qq=@qq or @qq='')    
and (netaddress=@netaddress or @netaddress='')    
and (infofrom=@infofrom or @infofrom='')    
and (abid=@abid or @abid='-1')    
and (developer=@developer or @developer='')    
and (parentpay=@parentpay or @parentpay='')     
order by kid desc    
end    


    
    
    
    
    
    
   SET ROWCOUNT @size    
   SELECT     
    @pcount      ,[ID]    ,[kid]    ,[kname]    ,[regdatetime]    ,[ontime]    ,[expiretime]    ,[privince]    ,[city]    ,[area]    ,[linkstate]    ,[ctype]    ,[cflush]    ,[clevel]    ,[parentpay]    ,[infofrom]    ,(select top 1 u.[name] from users  u
  
 where u.ID=developer) [developer]    ,[status]    ,[invoicetitle]    ,[netaddress]    ,[address]    ,[remark]    ,[deletetag],abid     FROM     
    @tmptable AS tmptable      
   INNER JOIN [kinbaseinfo] g    
   ON  tmptable.tmptableid=g.kid      
   WHERE    
    row>@ignore     
order by kid desc    
end    
else    
begin    
SET ROWCOUNT @size    
    
 if ISNULL(@followday,-1) > -1  
 begin  
 SELECT     
 @pcount      ,[ID]    ,[kid]    ,[kname]    ,[regdatetime]    ,[ontime]    ,[expiretime]    ,[privince]    ,[city]    ,[area]    ,[linkstate]    ,[ctype]    ,[cflush]    ,[clevel]    ,[parentpay]    ,[infofrom]    ,(select top 1 u.[name] from users  u   
 where u.ID=developer) [developer]    ,[status]    ,[invoicetitle]    ,[netaddress]    ,[address]    ,[remark]    ,[deletetag],abid    
 FROM [kinbaseinfo]  where     
 (kid like ''+convert(varchar,@kid)+'' or @kid=-1)    
and kname like '%'+@kname+'%'     
and regdatetime between @regdatetime1 and @regdatetime2     
and (privince = @privince or @privince='')    
and (city = @city or @city='')    
and (area = @area or @area='')    
and (status = @status or @status='')    
and (linkstate = @linkstate or @linkstate='')    
and (qq=@qq or @qq='')    
and (netaddress=@netaddress or @netaddress='')    
and (infofrom=@infofrom or @infofrom='')    
and (abid=@abid or @abid='-1')    
and (developer=@developer or @developer='')    
and (parentpay=@parentpay or @parentpay='')   
AND datediff(dd, bf_lasttime,getdate()) >  convert(varchar,@followday)     
order by kid desc    
 end  
 else  
 begin  
 SELECT     
 @pcount      ,[ID]    ,[kid]    ,[kname]    ,[regdatetime]    ,[ontime]    ,[expiretime]    ,[privince]    ,[city]    ,[area]    ,[linkstate]    ,[ctype]    ,[cflush]    ,[clevel]    ,[parentpay]    ,[infofrom]    ,(select top 1 u.[name] from users  u   
 where u.ID=developer) [developer]    ,[status]    ,[invoicetitle]    ,[netaddress]    ,[address]    ,[remark]    ,[deletetag],abid    
 FROM [kinbaseinfo]  where     
 (kid like ''+convert(varchar,@kid)+'' or @kid=-1)    
and kname like '%'+@kname+'%'     
and regdatetime between @regdatetime1 and @regdatetime2     
and (privince = @privince or @privince='')    
and (city = @city or @city='')    
and (area = @area or @area='')    
and (status = @status or @status='')    
and (linkstate = @linkstate or @linkstate='')    
and (qq=@qq or @qq='')    
and (netaddress=@netaddress or @netaddress='')    
and (infofrom=@infofrom or @infofrom='')    
and (abid=@abid or @abid='-1')    
and (developer=@developer or @developer='')    
and (parentpay=@parentpay or @parentpay='')      
order by kid desc    
 end   
  
    
    
    
end    
    
    
    
    
GO
