USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[kindergarten_Base_ADD]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[kindergarten_Base_ADD]
@kid int,
@area1 varchar(50),
@area2 varchar(50),
@area3 varchar(50),
@area4 varchar(50),
@book varchar(50),
@econtent varchar(50),
@inuserid int,
@intime datetime,
@unitcode varchar(100),
@postcode varchar(100),
@officetel varchar(100),
@email varchar(100),
@inputmail varchar(100),
@inputname varchar(100),
@fixtel varchar(100),
@master varchar(100),
--幼儿园
@kname varchar(100),
@area int,
@residence int,
@citytype int,                 
@kintype int,
@opentype int,
@address varchar(1000)
 AS 
declare @p int
set @p=0
select @p=count(1) from  [kindergarten_condition] where kid=@kid


update BasicData..kindergarten 
set kname=@kname,area=@area,residence=@residence
,citytype=@citytype,kintype=@kintype,opentype=@opentype
,address=@address
	WHERE [kid] = @kid

if @p>0
begin

	UPDATE [kindergarten_condition] SET 
	[area1] = @area1,[area2] = @area2,[area3] = @area3,[area4] = @area4,[book] = @book,[econtent] = @econtent,[inuserid] = @inuserid,[intime] = @intime,[unitcode] = @unitcode,[postcode] = @postcode,[officetel] = @officetel,[email] = @email,[inputmail] = @inputmail,[inputname] = @inputname,[fixtel] = @fixtel,[master] = @master
	WHERE [kid] = @kid

end
else
begin
	INSERT INTO [kindergarten_condition](
	[kid],[area1],[area2],[area3],[area4],[book],[econtent],[inuserid],[intime],[unitcode],[postcode],[officetel],[email],[inputmail],[inputname],[fixtel],[master]
	)VALUES(
	@kid,@area1,@area2,@area3,@area4,@book,@econtent,@inuserid,@intime,@unitcode,@postcode,@officetel,@email,@inputmail,@inputname,@fixtel,@master
	)
end
	








GO
