create or replace TRIGGER SANKHYA.TRG_UPD_INC_TGFPPAR_CODREG BEFORE UPDATE OR INSERT ON SANKHYA.TGFPAR FOR EACH ROW
DECLARE
	
	   
    V_CODREG INT:= 0;

	/* BARRA ATUALIZAR CADASTRO DO PARCEIRO CASO, 
    O CAMPO SEJA INFORMADO 0 OU UM VALOR QUE 
    NÃO TENHA NA TABELA DE REGIÃO */

BEGIN

	--IF UPDATING ('CODREG') OR INSERTING('CODREG') THEN 
    IF (:NEW.CLIENTE = 'S' OR :OLD.CLIENTE  = 'S') THEN --caso não seja um cliente que esteja sendo cadastrado não verifica o campo região

        IF (:OLD.CODREG = 0 AND :NEW.CODREG = 0) THEN

            RAISE_APPLICATION_ERROR(-20101, 'Codigo da REGIÃO não pode ser igual a ZERO');

            END IF;
        IF(:OLD.CODREG <> :NEW.CODREG) THEN

                SELECT COUNT(1) INTO V_CODREG FROM TSIREG REG WHERE REG.CODREG = :NEW.CODREG;

                IF(V_CODREG=0) THEN

                RAISE_APPLICATION_ERROR(-20101, 'Codigo da região não Exite! Pesquise a região.');

                END IF;
            END IF;

    END IF;

    --BLOQUEIA O CADASTRO DE PESSOA FISICA DIFERENTE DE CONSUMIDOR NÃO CONTRIBUINTE 

    IF(:NEW.TIPPESSOA = 'F' )THEN

        IF( :NEW.CLASSIFICMS <> 'C' ) THEN

            RAISE_APPLICATION_ERROR(-20101, 'Parceiro pessoa FISICA deve possuir classificação icms IGUAL Á CONSUMIDOR FISCAL NÃO CONSTRINUINTE');

        END IF;
    END IF;
    
        IF(:NEW.TIPPESSOA = 'J' )THEN

        IF( :NEW.CLASSIFICMS <> 'C' OR :NEW.CLASSIFICMS <> 'R') THEN

            RAISE_APPLICATION_ERROR(-20101, 'Parceiro pessoa JURIDICA deve possuir classificação icms igual á CONSUMIDOR FISCAL NÃO CONSTRINUINTE ou REVENDEDOR');

        END IF;

    END IF;    


	--END IF;
 END;