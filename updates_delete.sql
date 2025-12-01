4) Exemplos de UPDATE
-- Atualizar status de adoção
UPDATE Adocao
SET status_processo = 'aprovado'
WHERE adocao_id = 1;

-- Atualizar condição de saúde de um animal
UPDATE Animal
SET condicao_saude = 'Recuperado - sem sequelas'
WHERE animal_id = 1;

UPDATE Adotante 
SET telefone = '11977776666' 
WHERE adotante_id = 2;

-- 5) Exemplos de DELETE
DELETE FROM Animal 
WHERE animal_id = 3;

DELETE FROM Doacao
WHERE doacao_id = 2;

-- Excluir adotante (caso não exista adoção vinculada)
-- Observe que FOREIGN KEY restritiva impedirá remoção se houver vínculos.
DELETE FROM Adotante
WHERE adotante_id = 2;
