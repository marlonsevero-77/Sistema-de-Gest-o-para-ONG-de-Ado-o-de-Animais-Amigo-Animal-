SELECT * FROM Animal;

-- b) Buscar produtos com filtro (exemplo de filtro)
SELECT animal_id, nome, especie, data_resgate
FROM Animal
WHERE especie = 'Cachorro'
ORDER BY data_resgate DESC;

-- c) Adoções com dados do adotante
SELECT ad.adocao_id, ad.data_adocao, ad.status_processo,
       an.nome AS nome_animal, adt.nome AS nome_adotante, adt.telefone
FROM Adocao ad
JOIN Animal an ON ad.animal_id = an.animal_id
JOIN Adotante adt ON ad.adotante_id = adt.adotante_id
ORDER BY ad.data_adocao DESC;

-- d) Quantidade e total de doações por tipo
SELECT tipo, COUNT(*) AS qtd, SUM(valor) AS total_valor
FROM Doacao
GROUP BY tipo;

-- e) Última avaliação por animal (MySQL compatible)
SELECT a.animal_id, a.nome,
       av.data_avaliacao, av.observacoes
FROM Animal a
LEFT JOIN Avaliacao av ON av.avaliacao_id = (
    SELECT av2.avaliacao_id
    FROM Avaliacao av2
    WHERE av2.animal_id = a.animal_id
    ORDER BY av2.data_avaliacao DESC, av2.avaliacao_id DESC
    LIMIT 1
)
ORDER BY a.data_resgate DESC;



SELECT a.animal_id, a.nome
FROM Animal a
LEFT JOIN Avaliacao av ON a.animal_id = av.animal_id
WHERE av.avaliacao_id IS NULL;

-- Verificar referências quebradas (não deveria haver com FK habilitado)
-- (caso seu SGBD esteja com checagem desabilitada)
SELECT d.doacao_id
FROM Doacao d
LEFT JOIN Campanha c ON d.campanha_id = c.campanha_id
WHERE d.campanha_id IS NOT NULL AND c.campanha_id IS NULL;