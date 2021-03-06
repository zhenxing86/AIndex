USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[getTNB_Books_List]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTNB_Books_List]    
@teachId int,    
@exquisite int,    
@booktype int,    
@userId int,    
@kid int,     
@term varchar(50)    
AS   
	if(@kid=0)
	begin
		select @kid=isnull(kid,0) from BasicData..[user] where userid=@userId
	end 
  if(@exquisite = 0)    
  begin    
     select t1.chapterid,t1.chaptertitle,t1.subject,t1.grade,t1.createdate,t1.exquisite from EBook..TNB_Chapter t1     
     left join tnb_teachingnotebook t2 on t1.teachingnotebookid=t2.teachingnotebookid     
     left join basicdata..[user] t3 on t2.userid=t3.userid     
     where t1.teachingnotebookid = @teachId and t1.deletetag = 1  
  end    
  if(@exquisite =1)    
  begin    
    select  t1.chapterid,t1.chaptertitle,t1.subject,t1.grade,t1.createdate,t1.exquisite    
    FROM EBook..TNB_Chapter t1     
    left join EBook..tnb_teachingnotebook t2 on t1.teachingnotebookid=t2.teachingnotebookid     
    left join basicdata..[user] t3 on t2.userid = t3.userid    
     where t2.booktype=@booktype and t1.exquisite=1 and t3.kid=@kid and t2.term=@term   and t1.deletetag = 1  
  end    
GO
