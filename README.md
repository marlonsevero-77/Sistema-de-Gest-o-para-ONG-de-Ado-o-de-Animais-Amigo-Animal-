# 🐾   Sistema de Gestão para ONG de Adoção de Animais “Amigo Animal”

Sistema de apoio ao resgate, avaliação e adoção de animais.

Este projeto faz parte da disciplina **Modelagem e Desenvolvimento de Banco de Dados**, incluindo:

* Modelagem lógica
* Criação do banco no MySQL
* Manipulação de dados com DML (INSERT, SELECT, UPDATE, DELETE)
* Boas práticas de versionamento com Git e GitHub

---

# 📌 **1. Tecnologias Utilizadas**

* **MySQL Server 8.x**
* **MySQL Workbench 8.x**
* **Git + GitHub**

---

# 📂 **2. Estrutura dos Arquivos no Repositório**

```
/banco-dados-amigo-animal
│
├── README.md                     → Este arquivo
├── amigo_animal_mysql.sql        → Script completo (DDL + DML + consultas)
│
├── inserts.sql                   → Somente INSERTs para povoar tabelas
├── selects.sql                   → Consultas (WHERE, JOIN, ORDER, LIMIT)
├── updates_deletes.sql           → Comandos UPDATE e DELETE
│
└── /prints                       → Capturas de tela das execuções
```

---

# 🗄️ **3. Como Executar o Projeto**

## **1) Instalar o MySQL**

Baixe o MySQL Server + Workbench:
[https://dev.mysql.com/downloads/](https://dev.mysql.com/downloads/)

## **2) Abrir o MySQL Workbench**

* Clique na conexão local
* Abra uma nova aba SQL

## **3) Executar o script principal**

No Workbench:

1. File → Open SQL Script
2. Abrir `amigo_animal_mysql.sql`
3. Rodar em blocos:

### **A) Criar banco**

```sql
CREATE DATABASE IF NOT EXISTS amigo_animal;
USE amigo_animal;
```

### **B) Criar tabelas**

Execute todos os `CREATE TABLE` em sequência.

### **C) Povoar o banco usando INSERT**

Execute os INSERTs (arquivo `inserts.sql`).

### **D) Executar SELECTs, UPDATEs e DELETEs**

Use os scripts correspondentes.

---

# 🧱 **4. Script de INSERTs (povoamento)**

Arquivo: `inserts.sql`

```sql
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
```

---

# 🔍 **5. Consultas SQL (SELECT)**

Arquivo: `selects.sql`

```sql
-- 1. Listar todos os animais ordenando pelo resgate (ORDER BY)
SELECT * FROM Animal
ORDER BY data_resgate DESC;

-- 2. Animais filtrados por espécie (WHERE)
SELECT nome, especie, porte
FROM Animal
WHERE especie = 'Cachorro';

-- 3. Adoções com JOIN entre Animal e Adotante
SELECT ad.adocao_id, an.nome AS animal, at.nome AS adotante, ad.status_processo
FROM Adocao ad
JOIN Animal an ON an.animal_id = ad.animal_id
JOIN Adotante at ON at.adotante_id = ad.adotante_id;

-- 4. Listar doações por tipo
SELECT tipo, COUNT(*) AS quantidade, SUM(valor) AS total
FROM Doacao
GROUP BY tipo;

-- 5. Limitar resultados (LIMIT)
SELECT nome, especie
FROM Animal
LIMIT 2;
```

---

# ✏️ **6. UPDATE e DELETE**

Arquivo: `updates_deletes.sql`

## ✔ **UPDATE**

```sql
UPDATE Animal
SET condicao_saude = 'Recuperado - sem sequelas'
WHERE animal_id = 1;

UPDATE Adocao
SET status_processo = 'aprovado'
WHERE adocao_id = 1;

UPDATE Adotante
SET telefone = '11977776666'
WHERE adotante_id = 2;
```

---

## ❌ **DELETE**

```sql
DELETE FROM Doacao
WHERE doacao_id = 2;

DELETE FROM Avaliacao
WHERE avaliacao_id = 1;

DELETE FROM Animal
WHERE animal_id = 3;
```

---

# 🧪 **7. Prints no Repositório**


# 🎉 **8. Autor**

Marlon Severo
Curso / Análise e Desenvolvimento de Sistemas - UNICSUL
Disciplina: Modelagem e Banco de Dados
