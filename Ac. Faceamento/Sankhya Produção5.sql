select 
cdrepresentante, 
wcount(qtd), 


(select 

    cdrepresentante, 
    dtcadastro,
    sum(qtd) as qtd
    
from
(
SELECT
   fc.cdrepresentante, 
   fc.dtcadastro, 
   count(distinct(fc.dtcadastro)) as qtd 
FROM
    nnpessoawvwebprd.tblvwfaceamentoestoque fc,
    tgfven ven
WHERE
    ven.codvend = fc.cdrepresentante and 
    fc.dtcadastro BETWEEN :dtini AND :dtfim
    AND fc.cdempresa = :CODEMP
    AND fc.cdrepresentante = 1
GROUP BY
    fc.CDREPRESENTANTE, 
    fc.cdcliente,
    fc.dtcadastro
ORDER BY
    FC.CDREPRESENTANTE
    )
    group by
    cdrepresentante, 
    dtcadastro
    
    having sum(qtd)>=2)