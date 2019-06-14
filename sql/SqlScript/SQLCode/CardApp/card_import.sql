USE [CardApp]
GO
/****** Object:  StoredProcedure [dbo].[card_import]    Script Date: 2014/11/24 22:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--exec card_import 9803,'100000'
create PROCEDURE [dbo].[card_import]
@KID int,
@cardno nvarchar(10)
AS

declare @minenrolnum int
set @minenrolnum=65530

select @minenrolnum=min(enrolnum) from cardlist where kid=@kid

if(@minenrolnum is null)
begin
set @minenrolnum=65530
end



if(exists(select cardno from cardlist where cardno=@cardno and kid=@kid))
begin
	--update card where cardno=@cardno
	select 1
end
else
if NOT EXISTS(select kid from cardlist where kid=@kid and cardno=@cardno)
begin
	insert into Cardlist (kid,cardno,enrolnum,enrolsource,status,actiondate,issyn) 
	values(@kid,@cardno,@minenrolnum-1,1,0,getdate(),0)
end






GO
