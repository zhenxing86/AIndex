USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_notice_ADD]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
  
  
------------------------------------  
--用途：增加一条公告   
--项目名称：ClassHomePage  
--说明：  
--时间：2009-1-6 9:44:05  
------------------------------------  
CREATE PROCEDURE [dbo].[class_notice_ADD]  
@title nvarchar(100),  
@userid int,  
@author nvarchar(50),  
@kid int,  
@classid int,  
@content ntext,  
@classlist nvarchar(200)  
 AS   
 INSERT INTO class_notice(  
 [title],[userid],[author],[kid],[classid],[content],[createdatetime],[status]  
 )VALUES(  
 @title,@userid,@author,@kid,@classid,@content,getdate(),1)  
  
 DECLARE @objectid int,@LOGdescription nvarchar(300)  
 SET @objectid=SCOPE_IDENTITY()  
  
 DECLARE @next int   
 set @next=1  
 while @next<=dbo.Get_StrArrayLength(@classlist,',')  
 begin  
  DECLARE @cid int  
  SELECT @cid=dbo.Get_StrArrayStrOfIndex(@classlist,',',@next)  
  set @next=@next+1  
  INSERT INTO class_notice_class(noticeid,classid) VALUES(@objectid,@cid)  
 end  
 if(len(@title)>5)  
 begin  
  set @title=substring(@title,1,5)+'...'  
 end   
   
 IF @@ERROR <> 0   
 BEGIN    
    RETURN(-1)  
 END  
 ELSE  
 BEGIN  
  --  EXEC class_actionlogs_ADD @userid,@author,@LOGdescription,'23',@objectid,@userid,0,@classid    
    RETURN @objectid  
 END  
  
  
  
  
  
  
  
  
GO
