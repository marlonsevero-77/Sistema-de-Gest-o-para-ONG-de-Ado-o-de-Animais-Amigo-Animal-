-- amigo_animal_mysql.sql
-- Cria banco, tabelas, índices, dados de exemplo e exemplos de SELECT/UPDATE/DELETE

-- 0) Criar database e usar
CREATE DATABASE IF NOT EXISTS amigo_animal;
USE amigo_animal;

-- 1) Tabelas (engine InnoDB para suporte a FK)
CREATE TABLE IF NOT EXISTS Veterinario (
    veterinario_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    crmv VARCHAR(20) UNIQUE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Animal (
    animal_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120),
    especie VARCHAR(60) NOT NULL,
    idade_aproximada INT,
    porte VARCHAR(30),
    data_resgate DATE NOT NULL,
    condicao_saude TEXT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Adotante (
    adotante_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf CHAR(11) UNIQUE,
    endereco VARCHAR(255),
    telefone VARCHAR(30),
    email VARCHAR(150)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Avaliacao (
    avaliacao_id INT AUTO_INCREMENT PRIMARY KEY,
    animal_id INT NOT NULL,
    veterinario_id INT NOT NULL,
    data_avaliacao DATE NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (animal_id) REFERENCES Animal(animal_id) ON DELETE CASCADE,
    FOREIGN KEY (veterinario_id) REFERENCES Veterinario(veterinario_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Campanha (
    campanha_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    data_inicio DATE,
    data_fim DATE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Doacao (
    doacao_id INT AUTO_INCREMENT PRIMARY KEY,
    campanha_id INT,
    valor DECIMAL(12,2),
    data_doacao DATE NOT NULL,
    tipo VARCHAR(30),
    descricao TEXT,
    FOREIGN KEY (campanha_id) REFERENCES Campanha(campanha_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Adocao (
    adocao_id INT AUTO_INCREMENT PRIMARY KEY,
    animal_id INT NOT NULL,
    adotante_id INT NOT NULL,
    data_adocao DATE NOT NULL,
    status_processo VARCHAR(50),
    FOREIGN KEY (animal_id) REFERENCES Animal(animal_id) ON DELETE RESTRICT,
    FOREIGN KEY (adotante_id) REFERENCES Adotante(adotante_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Índices úteis
CREATE INDEX idx_animal_especie ON Animal(especie);
CREATE INDEX idx_doacao_data ON Doacao(data_doacao);


-- 2) Dados de exemplo (INSERTs)
INSERT INTO Veterinario (nome, crmv) VALUES
('Dr. Paulo Almeida', 'CRMV-SP-12345'),
('Dra. Fernanda Costa', 'CRMV-SP-98765');

INSERT INTO Animal (nome, especie, idade_aproximada, porte, data_resgate, condicao_saude) VALUES
('Bidu', 'Cachorro', 3, 'Médio', '2025-09-01', 'Coxo na pata traseira'),
('Mia', 'Gato', 2, 'Pequeno', '2025-10-15', 'Leve desnutrição'),
('Rex', 'Cachorro', 5, 'Grande', '2025-08-20', 'Boa saúde');

INSERT INTO Adotante (nome, cpf, endereco, telefone, email) VALUES
('Lucas Pereira', '11122233344', 'Rua A, 123', '11999990000', 'lucas@example.com'),
('Mariana Silva', '55566677788', 'Av. B, 45', '11988887777', 'mari@example.com');

INSERT INTO Avaliacao (animal_id, veterinario_id, data_avaliacao, observacoes) VALUES
(1, 1, '2025-09-02', 'Radiografia confirmada; precisa de imobilização'),
(2, 2, '2025-10-16', 'Vacinação e vermifugação realizadas');

INSERT INTO Campanha (nome, descricao, data_inicio, data_fim) VALUES
('Outubro de Castração', 'Campanha para castração de animais de rua', '2025-10-01', '2025-10-31');

INSERT INTO Doacao (campanha_id, valor, data_doacao, tipo, descricao) VALUES
(1, 150.00, '2025-10-05', 'financeira', 'Doação online'),
(NULL, NULL, '2025-11-01', 'insumos', 'Ração doada');

INSERT INTO Adocao (animal_id, adotante_id, data_adocao, status_processo) VALUES
(1, 1, '2025-11-10', 'concluído');

-- 3) Exemplos de consultas (SELECT)
-- a) Listar todos os animais
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

-- 4) Exemplos de UPDATE
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

-- 6) Consultas úteis para verificação de integridade
-- Verificar se existem animais sem avaliações
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

-- FIM do script
