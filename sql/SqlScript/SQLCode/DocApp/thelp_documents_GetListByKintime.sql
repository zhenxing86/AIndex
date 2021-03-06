USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetListByKintime]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
------------------------------------    
--用途：查询共享幼儿园文档列表    
--项目名称：ZGYEYBLOG    
--说明：    
--时间：2009-6-30 21:00:07    
--select *from kin_doc_category where kid=18289
-- exec [thelp_documents_GetListByKintime] 33626,2,10,'1900-01-01','2900-01-01','',18289

------------------------------------    
CREATE PROCEDURE [dbo].[thelp_documents_GetListByKintime]    
@categoryid int,    
@page int,    
@size int,    
@firsttime datetime,    
@lasttime datetime,    
@title varchar(100),    
@kid int,
@getsubcategory int=1  
 AS    
if(@firsttime = '')    
BEGIN    
set @firsttime=convert(datetime,'1900-01-01')    
End    
    
    
if(@lasttime = '')    
BEGIN    
set @lasttime=convert(datetime,'2090-01-01')    
End    
    
--and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%'       
  DECLARE @categorytb TABLE        
 (        
  --定义临时表        
  row int IDENTITY (1, 1),        
  kincategoryid int,    
  [Level] int    
 )      
 declare @categoryLevel int=1      
 -- 获取本身和下级分类列表 开始          
 INSERT @categorytb SELECT @categoryid,@categoryLevel   
 if(@getsubcategory=1)
 begin 
 WHILE @@ROWCOUNT>0    
 BEGIN    
  SET @categoryLevel=@categoryLevel+1    
  INSERT @categorytb SELECT a.kincategoryid,@categoryLevel    
  FROM kin_doc_category a,@categorytb b    
  WHERE a.parentid=b.kincategoryid and a.[status]=1 and a.kid=@kid    
   AND b.Level=@categoryLevel-1    
   END 
  end   
 --获取本身和下级分类列表 结束    
IF(@page>1)    
BEGIN    
 DECLARE @prep int,@ignore int    
     
 SET @prep = @size * @page    
 SET @ignore=@prep - @size    
    
 DECLARE @documents TABLE    
 (    
  --定义临时表    
  row int IDENTITY (1, 1),    
  docid bigint    
 )    
------------------------------------------------------------     
  SET ROWCOUNT @prep     
IF(@categoryid>0)    
 BEGIN    
  INSERT INTO @documents(docid)    
  SELECT    
   docid    
  FROM    
   thelp_documents    
  WHERE       
   deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%' and kid=@kid  and kindisplay=1 
    and ( kindoccategoryid in(select categoryid from @categorytb) or kindoccategoryid=@categoryid)
  ORDER BY    
   createdatetime DESC    
END    
 ELSE IF(@categoryid<0)    
 BEGIN    
 INSERT INTO @documents(docid)    
  SELECT    
   docid    
  FROM    
   thelp_documents    
  WHERE       
   deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%' and kid=@kid  and kindisplay=1     
  ORDER BY    
   createdatetime DESC    
    
END    
--------------------------------------------    
  SET ROWCOUNT @size    
  SELECT    
   t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,t1.userid,t1.author,    
   (select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,    
   (select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount,    
    (select title  from kin_doc_category where kincategoryid= kindoccategoryid) as Kindoccategorytitle    
  FROM    
   @documents as predocuments    
  INNER JOIN    
   thelp_documents t1    
  ON    
   predocuments.docid = t1.docid      
  WHERE    
   row > @ignore   
END    
ELSE    
BEGIN    
----------------------------------------------------------------    
 SET ROWCOUNT @size    
IF(@categoryid>0)    
 BEGIN    
   SELECT    
    t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,    
    (select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,    
    (select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount,    
    (select title  from kin_doc_category where kincategoryid= kindoccategoryid) as Kindoccategorytitle    
   FROM        
    thelp_documents t1     
   where deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%' and kid=@kid and  t1.kindoccategoryid in (select kincategoryid from @categorytb) and t1.kindisplay=1     
  order by t1.createdatetime desc    
    
END    
 ELSE IF(@categoryid<0)    
 BEGIN    
 SELECT    
    t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,    
    (select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,    
    (select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount,    
    (select title  from kin_doc_category where kincategoryid= kindoccategoryid) as Kindoccategorytitle     FROM    
    thelp_documents t1    
   where deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%' and kid=@kid and t1.kindisplay=1     
  order by t1.createdatetime desc    
    
End    
--------------------------------------------------------    
END 
GO
