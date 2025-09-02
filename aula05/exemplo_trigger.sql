CREATE OR REPLACE FUNCTION valida_supermercado_em_quadra()
RETURNS TRIGGER AS $$
DECLARE
    geometria_quadra GEOMETRY;
BEGIN
    -- 1. Verifica se um CÓDIGO de quadra foi fornecido
    IF NEW.cod_q IS NULL THEN
        RAISE EXCEPTION 'Um  código de quadra deve ser fornecido para o supermercado.';
    END IF;

    -- 2. Busca a geometria da quadra correspondente ao cod_q
    SELECT geom INTO geometria_quadra
    FROM quadra
    WHERE cod_q = NEW.cod_q;

    -- 3. Valida se a quadra existe e se a geometria do supermercado está dentro dela
    IF geometria_quadra IS NULL THEN
        RAISE EXCEPTION 'O código de quadra % não foi encontrado.', NEW.cod_q;
    ELSEIF NOT ST_Within(NEW.geom, geometria_quadra) THEN
        RAISE EXCEPTION 'A localização do supermercado não está contida no polígono da quadra %.', NEW.cod_q;
    END IF;

    -- Se todas as validações passarem, permite a operação
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_valida_supermercado_em_quadra
BEFORE INSERT OR UPDATE ON supermercado
FOR EACH ROW
EXECUTE FUNCTION valida_supermercado_em_quadra();


