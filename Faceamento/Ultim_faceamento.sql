SELECT

    ite.cdcliente,
    par.razaosocial,
    ite.cdproduto,
    pr.descrprod,
    pr.marca,
    ite.cdrepresentante ,
    ven.apelido,
    --fc.qtpontoequilibrio,
    max(ite.qtestoqueatual) as estoque
    --case when fc.qtpontoequilibrio <= ite.qtestoqueatual then 0 else fc.qtpontoequilibrio - ite.qtestoqueatual end as sugestao
FROM
    nnpessoawvwebprd.tblvwfaceamentoestoque ite,
    tgfpro pr,
    tgfpar par,
    tgfven ven,
    nnpessoawvwebprd.tblvwfaceamento fc
WHERE
     ite.cdrepresentante = ven.codvend and 
    ite.cdcliente = par.codparc and 
    fc.cdproduto = ite.cdproduto and 
    fc.cdcliente = ite.cdcliente and
	 ite.cdrepresentante = fc.cdrepresentante and
    fc.flativo = 'S' AND
    pr.marca = 'ROYALCANIN' 
    and qtestoqueatual > 0 
    AND ite.dtcadastro >='01/05/2019'
    AND pr.codprod = ite.cdproduto
    --AND ite.cdrepresentante = :a_codvend
   -- AND ite.cdcliente = :a_codparc
   -- AND ite.dtcadastro = :a_data
   group by
   ite.cdcliente,
    par.razaosocial,
    ite.cdrepresentante,
    ite.cdproduto,
    pr.descrprod,
    ven.apelido,
    pr.marca
   order by cdrepresentante, cdcliente asc