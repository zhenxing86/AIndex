USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[beforefollow_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[beforefollow_Update]
 @ID int,
 @kid int,
 @kname varchar(200),
 @nature varchar(100),
 @classcount int,
 @provice int,
 @city int,
 @area int,
 @linebus varchar(1000),
 @address varchar(300),
 @linkname varchar(100),
 @title varchar(200),
 @tel varchar(200),
 @qq varchar(30),
 @email varchar(200),
 @netaddress varchar(200),
 @remark varchar(3000),
 @uid int,
 @bid int,
 @mobile varchar(200),
 @ismaterkin int,
 @parentbfid int,
 @childnum int,
 @childnumre int,
 @intime datetime,
 @deletetag int
 
 AS 


	UPDATE [beforefollow] SET 
  [kid] = @kid,
 [kname] = @kname,
 [nature] = @nature,
 [classcount] = @classcount,
 [provice] = @provice,
 [city] = @city,
 [area] = @area,
 [linebus] = @linebus,
 [address] = @address,
 [linkname] = @linkname,
 [title] = @title,
 [tel] = @tel,
 [qq] = @qq,
 [email] = @email,
 [netaddress] = @netaddress,
 [remark] = @remark,
 [uid] = @uid,
 [bid] = @bid,
 [mobile] = @mobile,
 [ismaterkin] = @ismaterkin,
 [parentbfid] = @parentbfid,
  [childnum] = @childnum,
 [childnumre] = @childnumre
 	 WHERE ID=@ID 

if(@kid<>0)
begin
update dbo.kinbaseinfo set 
privince=@provice
,city=@city
,area=@area
where kid=@kid

end



GO
