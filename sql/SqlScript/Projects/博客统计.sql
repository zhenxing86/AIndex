
select *from BasicData..[user] where account='13975811186'

select b.userid,u.account,u.password,b.* from blogapp..blog_baseconfig b
inner join BasicData..user_bloguser ub on b.userid=ub.bloguserid
inner join  BasicData..[user] u on ub.userid = u.userid and u.kid= 21775 and usertype>0 and u.deletetag=1


where ub.userid in (select userid from BasicData..[user] u where u.kid= 21775 and usertype>0 and u.deletetag=1--account='13975811186'
)

select * from blogapp..blog_baseconfig where userid=793734
select * from blogapp..album_categories where userid=793734 and deletetag=1
select COUNT(1) from blogapp..album_categories c
 inner join blogapp..album_photos p
  on c.categoriesid=p.categoriesid and p.deletetag=1 and c.deletetag=1
   where userid=793734
   
--update blogapp..blog_baseconfig set visitscount=605 where userid=909411
