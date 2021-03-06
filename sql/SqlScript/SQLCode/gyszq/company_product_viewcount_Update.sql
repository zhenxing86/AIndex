USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_product_viewcount_Update]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商家和商品自动增加查看数 
--项目名称：ServicePlatform
--说明：
--时间：2010-03-29 11:48:26
------------------------------------
CREATE PROCEDURE [dbo].[company_product_viewcount_Update]
AS
			declare @companyid int
			declare @productid int
			declare rs2 insensitive cursor for 
			select companyid From company where status=1
			open rs2
			fetch next from rs2 into @companyid
			while @@fetch_status=0
			begin
					update company set viewcount=viewcount+cast(floor(rand()*3) as int) where companyid=@companyid
					declare rs3 insensitive cursor for
					select productid from product where status=1 and companyid=@companyid
					open rs3
					fetch next from rs3 into @productid
					while @@fetch_status=0
					begin
						update product set viewcount=viewcount+cast(floor(rand()*2) as int) where productid=@productid
						fetch next from rs3 into @productid
					end
					close rs3
					deallocate rs3
				fetch next from rs2 into @companyid
			end
			close rs2
			deallocate rs2
GO
