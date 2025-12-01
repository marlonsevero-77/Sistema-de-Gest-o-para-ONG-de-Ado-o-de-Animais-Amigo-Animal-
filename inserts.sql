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