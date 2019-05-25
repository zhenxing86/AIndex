USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[UP_Sms_smsmessage_Getdep]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UP_Sms_smsmessage_Getdep] 
@kid int ,
@userid int
AS
declare @tempint int

				if @kid<>0
					select a.id,a.name,1 as flag from t_class a where a.kindergartenid=@kid and status=1  order by flag,id
				else
					begin
						
						select @tempint=kindergartenid from t_users a,T_Staffer b where a.id=b.userid and b.status=1 and a.id=@userid

						select a.id,a.name  from t_class a where a.kindergartenid=@tempint  and status=1 order by id
					end

GO
