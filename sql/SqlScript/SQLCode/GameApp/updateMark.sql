USE [GameApp]
GO
/****** Object:  StoredProcedure [dbo].[updateMark]    Script Date: 2014/11/24 23:07:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
author: xzx   
datetime: 2014-03-14  
des: 更新乐奇分数  
  
memo：   
  
exec updateMark 295765,1,1,0  
  
*/  
create PROCEDURE [dbo].[updateMark]    
@userid int,  
@termtype int,  
@skill nvarchar(20),  
@mark int   
as  

if not exists(select 1 from lq_game_mark where userid = @userid and termtype=@termtype)
begin
	insert into lq_game_mark(userid,termtype,s1,s2,s3,s4,s5,s6,s7,s8,s9,deletetag)
	 values(@userid,@termtype,0,0,0,0,0,0,0,0,0,1) 
end
if @skill='s1'  
 update lq_game_mark  
  set s1=@mark  
  where userid=@userid and termtype=@termtype   
else if @skill='s2'  
 update lq_game_mark  
  set s2=@mark  
  where userid=@userid and termtype=@termtype   
else if @skill='s3'  
 update lq_game_mark  
  set s3=@mark  
  where userid=@userid and termtype=@termtype   
else if @skill='s4'  
 update lq_game_mark  
  set s4=@mark  
  where userid=@userid and termtype=@termtype   
else if @skill='s5'  
 update lq_game_mark  
  set s5=@mark  
  where userid=@userid and termtype=@termtype   
else if @skill='s6'  
 update lq_game_mark  
  set s6=@mark  
  where userid=@userid and termtype=@termtype   
else if @skill='s7'  
 update lq_game_mark  
  set s7=@mark  
  where userid=@userid and termtype=@termtype   
else if @skill='s8'  
 update lq_game_mark  
  set s8=@mark  
  where userid=@userid and termtype=@termtype   
else if @skill='s9'  
 update lq_game_mark  
  set s9=@mark  
  where userid=@userid and termtype=@termtype 
GO
