USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[testpapercategory_Delete]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  proc [dbo].[testpapercategory_Delete]
@id int
as 
begin
--如果push表里面有用到则不允许删除
if exists(select *from push where categoryid=@id)
begin
return -5
end
--如果testpaper有则不允许删除
declare @icount int,@qcount int
select @icount=count(1) from TestPager p left join SubCategory s on p.id=s.testid left join Category c on s.categoryid=c.id where c.id=@id
select @qcount=count(1) from  Questions where categoryid=@id and deletetag=1
if(@icount>0) or (@qcount>0)
begin	
	return -4
end
update  Category set  deletetag=0 where id=@id
 
if(@@ERROR<>0)
return -1
else
return 1
end

GO
