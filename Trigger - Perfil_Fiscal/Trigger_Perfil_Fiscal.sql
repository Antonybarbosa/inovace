create or replace TRIGGER SANKHYA.TRG_UPD_INS_TGFPAR_PERFIL_FISCAL BEFORE UPDATE OR INSERT ON SANKHYA.TGFPAR FOR EACH ROW


DECLARE
     
BEGIN

    
	IF :NEW.CLASSIFICMS <> '' THEN 
    
        
        RAISE_APPLICATION_ERROR(-20101, 'Não é possível adicionar desconto, contacte o supervisor comercial');
        
        
    END IF;
 END;