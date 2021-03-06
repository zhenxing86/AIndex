USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetWorkNo]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_GetWorkNo]
@KindergartenCode varchar(10)
  AS
declare @OldWorkNo as varchar(20)
declare @Id as varchar(3)
declare @WorkNo as varchar(20)
select @OldWorkNo=(select max(WorkNo) from T_Staffer  where substring(WorkNo,1,3)=@KindergartenCode)
if @OldWorkNo is Null
   select @WorkNo=@KindergartenCode+'0001'
else
    begin
        select @Id=convert(varchar(4),convert(int,substring(@OldWorkNo,4,4)+1))
        select @WorkNo=@KindergartenCode+REPLICATE('0', 4-datalength(@Id))+@Id        
    end
select @WorkNo
GO
