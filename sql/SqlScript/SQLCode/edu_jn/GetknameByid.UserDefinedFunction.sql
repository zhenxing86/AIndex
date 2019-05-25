USE [edu_jn]
GO
/****** Object:  UserDefinedFunction [dbo].[GetknameByid]    Script Date: 08/10/2013 10:16:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE    function [dbo].[GetknameByid]
(
   @kids varchar(3000)  --出生日期
)
returns varchar(max)
as
begin
declare @str varchar(max),@kname varchar(200),@kid int,@j int,@kidst varchar(max)
set @str=''

set @kids=@kids+','

set @kidst=@kids


set @j=1 
while(charindex(',',@kids)<>0)   
begin   
		
	set @kid=(substring(@kids,1,charindex(',',@kids)-1))
	
	select @kname=kname from BasicData..kindergarten where kid=@kid

	set @str=@str+','+@kname

	set @kids = stuff(@kids,1,charindex(',',@kids),'')   
set @j=@j+1
end 

if(len(@str)>2)
begin
set @str=Substring(@str,2,len(@str))
end


if(@str is null)
begin

set @str=''
set @kids=@kidst
set @j=1 
while(charindex(',',@kids)<>0)   
begin   
		
	set @kid=(substring(@kids,1,charindex(',',@kids)-1))
	
	select @kname=username from group_user where userid=@kid

	set @str=@str+','+@kname

	set @kids = stuff(@kids,1,charindex(',',@kids),'')   
set @j=@j+1
end 

if(len(@str)>2)
begin
set @str=Substring(@str,2,len(@str))
end



end

return @str;

End
GO
