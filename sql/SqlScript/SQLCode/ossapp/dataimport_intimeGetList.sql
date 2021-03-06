USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[dataimport_intimeGetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dataimport_intimeGetList]
@kid int,
@usertype int
 AS 
 
 


if(@usertype=0)
begin

	if(not exists(select 1 from excel_input_child where kid=@kid))	
	begin
	 select convert(datetime,'1900-01-01 00:00:00.000')
	end
	else
	begin

	;with 
	cet as
	(
	select distinct intime 
		from excel_input_child 
		where kid=@kid
	)
	
	select top 10 intime from cet order by intime desc
	end
end
else if(@usertype=1)
begin

	if(not exists(select 1 from excel_input_teacher where kid=@kid))	
	begin
	 select convert(datetime,'1900-01-01 00:00:00.000')
	end
	
	else
	begin

	;with 
	cet as
	(
	select distinct intime 
		from excel_input_teacher 
		where kid=@kid
	)

	select top 10 intime from cet order by intime desc
	
	end
end

 

GO
