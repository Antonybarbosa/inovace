create or replace TRIGGER SANKHYA.TRG_UPD_INS_TGFPAR_PERFIL_FISCAL BEFORE UPDATE ON SANKHYA.TGFPAR FOR EACH ROW


DECLARE
         --ARMAZENO OS CODIGOS DE VENDEDORES QUE POSSUEM ESSE PARCEIRO.
        CURSOR C_CODVEND IS SELECT DISTINCT(RPV.CODVEND) FROM TGFRPV RPV WHERE RPV.CODPARC = :OLD.CODPARC;
	    T_CODREG INTEGER;
        T_NOMEREG VARCHAR(80);
        T_CONT INTEGER;
        T_DIA INTEGER;
        T_SEQUENCIA INTEGER := 0;
       
       

	/* BARRA ALTERAÇÃO NO DESCONTO DOS ITENS TERCA FEIRA - 41 */

BEGIN

    SELECT NOMEREG INTO T_NOMEREG FROM TSIREG REG WHERE REG.CODREG = :OLD.CODREG ;

	IF UPDATING ('CODREG') THEN 
        SELECT NOMEREG into T_NOMEREG FROM TSIREG REG WHERE REG.CODREG = :NEW.CODREG ;
        -- ATUALIZA O AGENDA DO VENDEDOR ATUALIZAR A REGIÃO DO PARCEIRO
        
        -- SEGUNDA 
        
        IF(T_NOMEREG like '%40%' OR T_NOMEREG LIKE '%SEGUNDA%' OR T_NOMEREG LIKE '%SEG%') THEN
            
                SELECT COUNT(1) INTO T_CONT FROM TGFVIS WHERE codparc = :OLD.CODPARC;
            
            IF( T_CONT > 0 ) THEN
            
                UPDATE TGFVIS SET VALOR = 2 WHERE CODPARC = :OLD.CODPARC;
            
            END IF;
            
       END IF;

        IF(T_NOMEREG like '%41%' OR T_NOMEREG LIKE '%TERCA%' OR T_NOMEREG LIKE '%TER%') THEN
            
                SELECT COUNT(1) INTO T_CONT FROM TGFVIS WHERE codparc = :OLD.CODPARC;
            
            IF( T_CONT > 0 ) THEN
            
                UPDATE TGFVIS SET VALOR = 3 WHERE CODPARC = :OLD.CODPARC;
            
                END IF;
            END IF;
            
            --QUARTA
            
            IF(T_NOMEREG like '%42%' OR T_NOMEREG LIKE '%QUARTA%' OR T_NOMEREG LIKE '%QUA%') THEN
            
                SELECT COUNT(1) INTO T_CONT FROM TGFVIS WHERE codparc = :OLD.CODPARC;
            
            IF( T_CONT > 0 ) THEN
            
                UPDATE TGFVIS SET VALOR = 4 WHERE CODPARC = :OLD.CODPARC;
            
                END IF;
            END IF;
            
            --QUINTA
            
            IF(T_NOMEREG like '%43%' OR T_NOMEREG LIKE '%QUINTA%' OR T_NOMEREG LIKE '%QUI%') THEN
            
                SELECT COUNT(1) INTO T_CONT FROM TGFVIS WHERE codparc = :OLD.CODPARC;
            
            IF( T_CONT > 0 ) THEN
            
                UPDATE TGFVIS SET VALOR = 5 WHERE CODPARC = :OLD.CODPARC;
            
                END IF;
            END IF;
            
            
            --SEXTA
            
             IF(T_NOMEREG like '%44%' OR T_NOMEREG LIKE '%SEXTA%' OR T_NOMEREG LIKE '%SEX%') THEN
            
                SELECT COUNT(1) INTO T_CONT FROM TGFVIS WHERE codparc = :OLD.CODPARC;
            
            IF( T_CONT > 0 ) THEN
            
                UPDATE TGFVIS SET VALOR = 6 WHERE CODPARC = :OLD.CODPARC;
            
                END IF;
            END IF;
            
            --sp_dia_semana(:old.codparc);
            --RAISE_APPLICATION_ERROR(-20101, 'Não é possível adicionar desconto, contacte o supervisor comercial');
            
            
	END IF;
   
   
    IF UPDATING ('AD_SEMANA1') OR UPDATING('AD_SEMANA2') OR UPDATING('AD_SEMANA3') OR UPDATING('AD_SEMANA4') OR UPDATING ('AD_SEMANA5') THEN
        
        --DELETO TODOS OS AGENDAMENTOS PARA O PARCEIRO, NA LINHA ABAIXO.
        
        DELETE FROM TGFVIS WHERE CODPARC = :OLD.CODPARC; 
        
       
        
        --CONTO A QUANTIDADE DE ITENS NO ARRAY
        
       
        
        -- AGORA VOU INSERIR OS AGENDAMENTOS A TODOS OS VENDEDORES COM O PARCEIRO NA CARTEIRA
        
        
         IF(T_NOMEREG like '%40%' OR T_NOMEREG LIKE '%SEGUNDAG%' OR T_NOMEREG LIKE '%SEG%') THEN
                
                T_DIA:= 2;
         
            ELSIF (T_NOMEREG like '%41%' OR T_NOMEREG LIKE '%TERCA%' OR T_NOMEREG LIKE '%TER%') THEN
                
                    T_DIA:= 3;
         
                ELSIF(T_NOMEREG like '%42%' OR T_NOMEREG LIKE '%QUARTA%' OR T_NOMEREG LIKE '%QUA%') THEN
                
                        T_DIA:= 4;
                    
                    ELSIF (T_NOMEREG like '%43%' OR T_NOMEREG LIKE '%QUINTA%' OR T_NOMEREG LIKE '%QUI%') THEN
                    
                            T_DIA:= 5;
                        
                        ELSE
                                T_DIA:= 6;
         
         END IF;
                
        IF  (:NEW.AD_SEMANA1 = 'S') THEN
            
            FOR T_CODVEND IN C_CODVEND LOOP                
                
                --SELECIONO A SEQUENCIA, DA AGENDA DO VENDEDOR, PARA INSERIR O NOVO PARECEIRO NA AGENDA
                select MAX(SEQVISITA) INTO T_SEQUENCIA FROM TGFVIS where CODVEND = T_CODVEND.CODVEND AND TIPO = 'P' AND VALOR = T_DIA;
                
                T_SEQUENCIA:= T_SEQUENCIA+1;
                -- INSIRO O NOVO PARCEIRO NA AGENDA DOS RESPECTIVOS VENDEDORES 
                INSERT INTO TGFVIS(CODVEND,CODREG,TIPO ,VALOR,SEQVISITA,CODPARC)  
                       VALUES  (T_CODVEND.CODVEND,0,'P',T_DIA,T_SEQUENCIA,:OLD.CODPARC);
        
            END LOOP;
         END IF;       
                IF (:NEW.AD_SEMANA2 = 'S') THEN
            
                        FOR T_CODVEND IN C_CODVEND LOOP 
            
                            INSERT INTO TGFVIS(CODVEND,CODREG,TIPO ,VALOR,SEQVISITA,CODPARC)  
                                    VALUES  (T_CODVEND.CODVEND,0,'E',T_DIA,0,:OLD.CODPARC);
        
                        END LOOP;  
                END IF;        
                        IF (:NEW.AD_SEMANA3 = 'S') THEN
            
                                FOR T_CODVEND IN C_CODVEND LOOP 
            
                                     INSERT INTO TGFVIS(CODVEND,CODREG,TIPO ,VALOR,SEQVISITA,CODPARC)  
                                                VALUES  (T_CODVEND.CODVEND,0,'3',T_DIA,0,:OLD.CODPARC);
        
                        END LOOP;
                        END IF;
                                IF (:NEW.AD_SEMANA4 = 'S') THEN
            
                                        FOR T_CODVEND IN C_CODVEND LOOP 
            
                                            INSERT INTO TGFVIS(CODVEND,CODREG,TIPO ,VALOR,SEQVISITA,CODPARC)  
                                             VALUES  (T_CODVEND.CODVEND,0,'4',T_DIA,0,:OLD.CODPARC);
        
                                         END LOOP;
                                END IF;         
                                       IF (:NEW.AD_SEMANA5 = 'S') THEN
            
                                                FOR T_CODVEND IN C_CODVEND LOOP 
            
                                                     INSERT INTO TGFVIS(CODVEND,CODREG,TIPO ,VALOR,SEQVISITA,CODPARC)  
                                                             VALUES  (T_CODVEND.CODVEND,0,'5',T_DIA,0,:OLD.CODPARC);
        
            END LOOP;
                                        END IF;
    END IF;
 END;