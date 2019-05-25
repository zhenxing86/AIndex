ALTER PROCEDURE [dbo].[updateheight]  
@bid int,  
@h1 varchar(50),  
@w1 varchar(50),  
@h2 varchar(50),  
@w2 varchar(50),  
@jms varchar(1000),  
@gms varchar(1000),  
@yfjz varchar(1000)  
AS  
   update BaseInfo set h1=@h1,w1=@w1,h2=@h2,w2=@w2,jibing=@jms,guomin=@gms,yfzj=@yfjz where id = @bid  
   select @@ROWCOUNT