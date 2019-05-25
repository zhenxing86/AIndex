select cs.bookcount,b.BOOK_COUNT,*
--update cs set bookcount=b.BOOK_COUNT
from [ossapp].[dbo].[company_storebook] cs
left join [ossapp].[dbo].[book_in] b
 on cs.ISBN=b.ISBN
where b.BOOK_COUNT>0 

and b.ISBN in(
'9787533271855',
'9787539191355',
'9787539198231',
'9787539421391'
)

title,cover,author,elected_reason,price,tip,store,ISBN,dotime,authorinfo
,publisher,summary,Theme,age,keyword,Remarks

封面   入选理由      主题   age         keyword  Remarks
Cover  ElectedReason Theme  适用年龄     关键词  备注

select * from  company_storebook where ISBN like'%-%'
select * from  company_storebook where isbn='9787544246729'
9787544246729/9787539198255
update company_storebook set Remarks='9787544246729/9787539198255' where isbn='9787544246729'
select * from  company_storebook where isbn='9787539180083'
--update   book4 set [入选理由]='' where isbn='9787539180083'

select * into company_storebook_0312 from [ossapp].[dbo].company_storebook where 
select * delete from [ossapp].[dbo].company_storebook where bookcount is null
select * from [ossapp].[dbo].company_storebook where dotime='2015-02-28 11:48:29.737' -- bookcount is null 

select COUNT(1) from [ossapp].[dbo].company_storebook where bookcount is null
--dotime=getdate(),

;With Data as (  
Select convert(nvarchar(50),[ISBN],120) [ISBN],[书名],[封面],[作者（译者)],[入选理由],[作者简介],[内容简介],[主题/基础],[适用年龄],[价格(元)],[出版社],[关键词],[备注] 
 from dbo.book0327 where [ISBN] is not null
)  
Merge [ossapp].[dbo].[company_storebook] a  
Using Data b On a.ISBN = b.ISBN and a.title=b.[书名]
When Matched Then  
Update Set cover=b.[书名]+'.jpg',author=b.[作者（译者)],
elected_reason = b.[入选理由],price=b.[价格(元)],authorinfo=b.[作者简介]
,publisher=b.[出版社],summary=b.[内容简介],Theme=b.[主题/基础],age=b.[适用年龄],keyword=b.[关键词],Remarks=b.[备注] 
When not Matched Then  
Insert (title,cover,author,elected_reason,price,ISBN,authorinfo
,publisher,summary,Theme,age,keyword,Remarks) 
 Values(b.[书名], b.[书名]+'.jpg', b.[作者（译者)], b.[入选理由], b.[价格(元)], b.ISBN,
 b.[作者简介],b.[出版社],b.[内容简介],b.[主题/基础],b.[适用年龄],b.[关键词],b.[备注]);  

select * into company_storebook_0314 from company_storebook
select * from
update company_storebook set ISBN='9787544246729/9787539198255' where Remarks like '%/%' and ISBN='9787544246729'
select 679 +236
--还然

update b  set store=sb.store,bookcount=sb.bookcount
from company_storebook b
 inner join company_storebook0327 sb
  on b.isbn=sb.isbn and b.title=sb.title
