  select   
  count(dat)  as dat
  SELECT 
  from 
  (select 
   to_date(:dtini,'dd/mm/yyyy') + rownum-1 dat 
   from all_tables 
   where rownum <= ( to_date(:dtfim,'dd/mm/yyyy')-to_date(:dtini,'dd/mm/yyyy'))+1 )
   where to_char(dat, 'd') not in (1,7)