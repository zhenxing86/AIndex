USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetKindergartenCode]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetKindergartenCode]
  AS
declare @OldKindergartenCode as varchar(10)
declare @Id as varchar(3)
declare @KindergartenCode as varchar(8)
select @OldKindergartenCode=(select max(Code) from T_Kindergarten)
if @OldKindergartenCode is Null
   select @KindergartenCode='001'
else
    begin
        select @Id=convert(varchar(3),convert(int,@OldKindergartenCode+1))
        select @KindergartenCode=REPLICATE('0', 3-datalength(@Id))+@Id        
    end
select @KindergartenCode
GO
