USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetListBytime]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
------------------------------------      
--用途：查询文档列表记录信息       
--项目名称：ZGYEYBLOG      
--说明：      
--时间：2008-10-03 21:30:07      
--作者：along      
--exec  [thelp_documents_GetListBytime]  90156,2,10,-1,'1900-01-01','2900-1-1','',1    
------------------------------------      
CREATE PROCEDURE [dbo].[thelp_documents_GetListBytime]      
@categoryid int,      
@page int,      
@size int,      
@level int,      
@firsttime datetime,      
@lasttime datetime,      
@title varchar(100),
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
  categoryid int,      
  [Level] int      
 )        
 declare @categoryLevel int=1        
       
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
      
 SET ROWCOUNT @prep      
 IF(@Level=-1)      
 BEGIN      
  INSERT INTO @documents(docid)      
  SELECT top 12      
   docid      
  FROM      
   thelp_documents       
  WHERE        
   deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%'      
  ORDER BY      
   createdatetime DESC      
 END      
 ELSE IF(@Level=0)      
 BEGIN      
 -- 获取本身和下级分类列表 开始            
 INSERT @categorytb SELECT @categoryid,@categoryLevel      
 if(@getsubcategory=1)
 begin
 WHILE @@ROWCOUNT>0      
 BEGIN      
  SET @categoryLevel=@categoryLevel+1      
  INSERT @categorytb SELECT a.categoryid,@categoryLevel      
  FROM thelp_categories a,@categorytb b      
  WHERE a.parentid=b.categoryid       
   AND b.Level=@categoryLevel-1 and a.[status]=1      
   END     
  end 
 --获取本身和下级分类列表 结束      
    
      
 INSERT INTO @documents(docid)      
  SELECT      
   docid      
  FROM      
   thelp_documents      
  WHERE      
   deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%'  and       
   (categoryid in (select categoryid from @categorytb))      
  ORDER BY      
   createdatetime DESC      
 END      
 ELSE IF (@Level=1)      
 BEGIN      
  INSERT INTO @documents(docid)      
  SELECT      
   docid      
  FROM      
   thelp_documents      
  WHERE      
   deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%'  and categoryid=@categoryid      
  ORDER BY      
   createdatetime DESC      
 END      
 ELSE IF (@categoryid=-1)      
 BEGIN      
 INSERT INTO @documents(docid)      
  SELECT      
   docid      
  FROM      
   thelp_documents      
  WHERE      
   deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%'  and userid=@level      
   and categoryid in(select categoryid from thelp_categories where userid=@level and status=1)      
  ORDER BY      
   createdatetime DESC      
 END      
      
  SET ROWCOUNT @size      
  SELECT      
   t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,t1.userid,t1.author,      
   (select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,      
   (select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount,      
   isnull((select title  from kin_doc_category where kincategoryid= kindoccategoryid),'') as Kindoccategorytitle  ,    
    dbo.GetParentcategoryid(t1.categoryid) as doccategorytitle      
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
 SET ROWCOUNT @size      
 IF(@Level=-1)      
 BEGIN        
  SELECT top 12   
    t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,      
    (select count(*) from thelp_docattachs where docid=t1.docid) as attachscount,      
    (select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount,      
    isnull((select title  from kin_doc_category where kincategoryid= kindoccategoryid),'') as Kindoccategorytitle ,    
      dbo.GetParentcategoryid(t1.categoryid) as doccategorytitle      
   FROM      
    thelp_documents t1      
   where deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%'  and categoryid in (SELECT categoryid FROM thelp_categories WHERE parentid=@categoryid)      
  order by createdatetime desc      
 END      
      
 ELSE IF(@Level=0)      
 BEGIN      
  -- 获取本身和下级分类列表 开始            
 INSERT @categorytb SELECT @categoryid,@categoryLevel      
 if(@getsubcategory=1)
 begin
 WHILE @@ROWCOUNT>0      
 BEGIN      
  SET @categoryLevel=@categoryLevel+1      
  INSERT @categorytb SELECT a.categoryid,@categoryLevel      
  FROM thelp_categories a,@categorytb b      
  WHERE a.parentid=b.categoryid       
   AND b.Level=@categoryLevel-1 and a.[status]=1      
   END    
   end 
 --获取本身和下级分类列表 结束        
  SELECT      
    t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,      
    (select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,      
    (select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount,      
    isnull((select title    from kin_doc_category where kincategoryid= kindoccategoryid),'') as Kindoccategorytitle,    
    dbo.GetParentcategoryid(t1.categoryid) as doccategorytitle      
   FROM      
    thelp_documents t1      
   where deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%'  and (      
categoryid in (SELECT categoryid from @categorytb))      
  order by createdatetime desc      
  
  
 END      
 ELSE IF (@Level=1)      
 BEGIN      
   SELECT      
    t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,      
    (select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,      
    (select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount,      
    isnull((select title  from kin_doc_category where kincategoryid= kindoccategoryid),'') as Kindoccategorytitle ,    
      dbo.GetParentcategoryid(t1.categoryid) as doccategorytitle      
   FROM      
    thelp_documents t1      
   where deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%'  and categoryid=@categoryid      
  order by createdatetime desc      
 END      
      
      
ELSE IF (@categoryid=-1)      
 BEGIN      
   SELECT      
    t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,      
    (select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,      
    (select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount,      
    isnull((select title  from kin_doc_category where kincategoryid= kindoccategoryid),'') as Kindoccategorytitle  ,    
     dbo.GetParentcategoryid(t1.categoryid) as doccategorytitle      
   FROM      
    thelp_documents t1      
   where deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%' and userid=@level      
   and categoryid in(select categoryid from thelp_categories where userid=@level and status=1)      
  order by createdatetime desc      
 END      
END 
GO
