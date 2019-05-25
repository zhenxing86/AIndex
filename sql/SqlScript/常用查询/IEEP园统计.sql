   
   use ieep
   go
   
    select k.kid,k.kname,sum(y.cnt) cnt,COUNT(1) ccnt from ossapp..kinbaseinfo k
       inner join classinfo c on c.kid=k.kid 
       inner join BasicData..class x on x.cid=c.cid
       left join service_ieep_apply p on p.kid=k.kid
       outer apply(select COUNT(1) cnt from BasicData..User_Child u where u.cid=c.cid) y
       where k.ctype='IEEP¿Í»§' and k.linkstate<>'ÑÝÊ¾ÍøÕ¾'
       --and (k.developer=@duid  )
       --and (isnull(p.apply_userid,0) in (@duid,@auid) )
       
       group by  k.kid,k.kname
       order by k.kid