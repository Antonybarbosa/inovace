
SELECT
cdrepresentante,
CDCLIENTE,
dtvisita,
(dtchegadavisita ||' '|| hrchegadavisita) as entrada,
(dtsaidavisita ||' '|| hrsaidavisita) as saida,
--hrsaidavisita,
--hrchegadavisita,
--to_number(substr(hrsaidavisita,1,2)) as saida_h,
--to_number(substr(hrchegadavisita,1,2)) as entrada_h,
case when (to_number(substr(hrsaidavisita,1,2))  - to_number(substr(hrchegadavisita,1,2))) < 0 then 
lpad(mod((to_number(substr(hrchegadavisita,1,2))  - to_number(substr(hrsaidavisita,1,2))),60),2,'0') else
lpad(mod((to_number(substr(hrsaidavisita,1,2))  - to_number(substr(hrchegadavisita,1,2))),60),2,'0') end ||':'||
case when (to_number(substr(hrsaidavisita,4,2))  - to_number(substr(hrchegadavisita,4,2))) < 0 then 
lpad(mod((to_number(substr(hrchegadavisita,4,2))  - to_number(substr(hrsaidavisita,4,2))),60),2,'0') else
lpad(mod((to_number(substr(hrsaidavisita,4,2))  - to_number(substr(hrchegadavisita,4,2))),60),2,'0') end as minutos


FROM

NNPESSOAWVWEBPRD.tblvwvisita 

WHERE 

DTVISITA = :dtini 
and cdempresa = 2
AND cdrepresentante = 58
--and CDCLIENTE = 6088
ORDER BY CDCLIENTE
--group by cdrepresentante, dtvisita,(dtchegadavisita ||' '|| hrchegadavisita),(dtsaidavisita ||' '|| hrsaidavisita)