USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[subcategory_copy]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/    
     
CREATE  proc [dbo].[subcategory_copy]    
@targettestid int, --要复制的测评    
@totestid int   --执行复制的测评    
as    
begin    
 if(@targettestid=0 or @totestid=0)  
 begin  
  return -1  
 end  
   if exists( select * from SubCategory where testid=@totestid and deletetag=1)
   begin
   --更新存在的子分类
		update a set a.subtit=b.subtit from SubCategory a left join SubCategory b 
		on a.categoryid=b.categoryid and b.testid=@targettestid 
		where  a.testid=@totestid and a.deletetag=1 and b.subid>0  and b.deletetag=1
		--添加不存在的分类
		 insert into SubCategory(testid,subtit,categoryid,deletetag)     
		select  @totestid,a.subtit,a.categoryid,1 from SubCategory  a
		 
		where   a.deletetag=1 and a.testid=@targettestid    and categoryid not in(
		select  categoryid from SubCategory where testid=@totestid  and deletetag=1
		)
		
   end
   else
   begin
 insert into SubCategory(testid,subtit,categoryid,deletetag)     
 select @totestid,subtit,categoryid,1 from SubCategory where testid=@targettestid and deletetag=1  
 end  
 if(@@ERROR<>0)    
 return -1    
else    
 return 1    
end 
GO
