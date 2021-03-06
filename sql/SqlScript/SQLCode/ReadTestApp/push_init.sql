USE [ReadTestApp]
GO
/****** Object:  StoredProcedure [dbo].[push_init]    Script Date: 2014/11/25 11:35:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--初始化家长解读推送内容
CREATE proc [dbo].[push_init]
@month int,
@title nvarchar(100),
@categoryid int,
@grade int,
@issue varchar(50)
as 
begin
	declare @testid int,@subtit nvarchar(100),@url varchar(100)
	select  top 1 @testid=id  from TestPager where  grade=@grade and deletetag=1
	if(@testid<1)
	begin
		return -2
	end
	else
	begin
		if not  exists(select *from push   where [month]=@month and grade=@grade and categoryid=@categoryid)  
		begin
			set @url='http://pr.zgyey.com/assess/'+@issue+'/'+ case when @grade=37 then 'b_health' when @grade=36 then 'm_health' else  's_health' end
			insert into push(title,categoryid,describe,addtime,[month],grade,url)
			select @title,categoryid,s.subtit,GETDATE(),@month,@grade,@url from category c left join SubCategory s on c.id=s.categoryid 
			 where categoryid=@categoryid and s.testid=@testid and s.deletetag=1 and c.deletetag=1
		end 
	end
	if(@@ERROR<>0)
		return -1
	else
		return 1
end
GO
