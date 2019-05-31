create or replace TRIGGER SANKHYA.TRG_UPD_INC_TGFPPAR_CODREG BEFORE UPDATE OR INSERT ON SANKHYA.TGFPAR FOR EACH ROW
DECLARE
	
	   
    V_CODREG                INT:= 0;
    P_TITULO                TSIAVI.TITULO%TYPE;
    P_DESCRICAO             TSIAVI.DESCRICAO%TYPE;
    P_NUAVISO               TSIAVI.NUAVISO%TYPE;
    P_USUARIO               INTEGER;
    P_EMAIL_CODUSUSOLICIT   TSIUSU.EMAIL%TYPE;
	/* BARRA ATUALIZAR CADASTRO DO PARCEIRO CASO, 
    O CAMPO SEJA INFORMADO 0 OU UM VALOR QUE 
    N�O TENHA NA TABELA DE REGI�O */

BEGIN

	--IF UPDATING ('CODREG') OR INSERTING('CODREG') THEN 
    IF (:NEW.CLIENTE = 'S' OR :OLD.CLIENTE  = 'S') THEN --caso n�o seja um cliente que esteja sendo cadastrado n�o verifica o campo regi�o

        IF (:OLD.CODREG = 0 AND :NEW.CODREG = 0) THEN

            RAISE_APPLICATION_ERROR(-20101, 'Codigo da REGI�O n�o pode ser igual a ZERO');

            END IF;
        IF(:OLD.CODREG <> :NEW.CODREG) THEN

                SELECT COUNT(1) INTO V_CODREG FROM TSIREG REG WHERE REG.CODREG = :NEW.CODREG;

                IF(V_CODREG=0) THEN

                RAISE_APPLICATION_ERROR(-20101, 'Codigo da regi�o n�o Exite! Pesquise a regi�o.');

                END IF;
            END IF;

    END IF;

    --BLOQUEIA O CADASTRO DE PESSOA FISICA DIFERENTE DE CONSUMIDOR N�O CONTRIBUINTE 
IF UPDATING('CLASSIFICMS') OR INSERTING THEN

    IF INSERTING THEN
    
        P_USUARIO := :new.codusu;
        
        FOR A IN 4 .. 6 LOOP 
        
        SELECT NVL(MAX(NUAVISO),0) + 1 INTO P_NUAVISO FROM TSIAVI;
         
         SELECT EMAIL INTO P_EMAIL_CODUSUSOLICIT FROM TSIUSU WHERE CODUSU=:P_USUARIO;
         
         P_TITULO    := 'Lembrete Cadastro Tabelas Parceiro';
         P_DESCRICAO := ('Lembre-se de cadastrar as tabelas'|| chr(10)|| chr(13) || 'Para o cliente: ' || :NEW.CODPARC || ' - ' || :NEW.RAZAOSOCIAL);
         
            --envia Notific�o
         
         INSERT INTO TSIAVI (NUAVISO, TITULO, DESCRICAO, SOLUCAO, IDENTIFICADOR, IMPORTANCIA, CODUSU, CODGRUPO, TIPO, DHCRIACAO, CODUSUREMETENTE, NUAVISOPAI)
                VALUES      (P_NUAVISO, P_TITULO, P_DESCRICAO, P_DESCRICAO,'PERSONALIZADO',3, P_USUARIO, null,'P', SYSDATE, -1,null);
                
                --Envia e-mail
         
         INSERT INTO TMDFMG (CODFILA, ASSUNTO, CODMSG, DTENTRADA, STATUS, CODCON, TENTENVIO, MENSAGEM, TIPOENVIO, MAXTENTENVIO, EMAIL, NUANEXO, MIMETYPE) 
                VALUES      (P_CODFILA, P_TITULO, NULL, SYSDATE, 'Pendente', 0, 0, P_DESCRICAO, 'E', 3, P_EMAIL_CODUSUSOLICIT, NULL, NULL);       
                
                
         P_USUARIO := A + 1;
        
        END LOOP;
    END IF;
    
    
    
    
    
    
    
    IF(:NEW.TIPPESSOA = 'F' )THEN

        IF( :NEW.CLASSIFICMS <> 'C' ) THEN

            RAISE_APPLICATION_ERROR(-20101, 'Parceiro pessoa FISICA deve possuir classifica��o icms IGUAL � CONSUMIDOR FISCAL N�O CONSTRINUINTE');

        END IF;
    END IF;
    
    
    
    IF(:NEW.TIPPESSOA = 'J' )THEN

        IF( :NEW.CLASSIFICMS <> 'C' and :NEW.CLASSIFICMS <> 'R' ) THEN

            RAISE_APPLICATION_ERROR(-20101, 'Parceiro pessoa JURIDICA deve possuir classifica��o icms igual � CONSUMIDOR FISCAL N�O CONSTRINUINTE ou REVENDEDOR');

        END IF;

    END IF;    

END IF;

	--END IF;
 END;