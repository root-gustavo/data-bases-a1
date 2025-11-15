-- ============================================================
-- AVALIAÇÃO A1 - BANCO DE DADOS
-- ============================================================

-- (1) Criar a base de dados
CREATE DATABASE Estacionamento;
USE Estacionamento;

-- ============================================================
-- (2) Criar as tabelas com constraints
-- ============================================================

CREATE TABLE Marca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE Carro (
    placa VARCHAR(10) PRIMARY KEY,
    marcaId INT NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    FOREIGN KEY (marcaId) REFERENCES Marca(id)
);

CREATE TABLE Permanencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    carroPlaca VARCHAR(10) NOT NULL,
    entrada DATETIME NOT NULL,
    saida DATETIME NOT NULL,
    valorPago DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (carroPlaca) REFERENCES Carro(placa)
);

-- ============================================================
-- (3) Inserir registros nas tabelas
-- ============================================================

INSERT INTO Marca (id, nome) VALUES
(1, 'FIAT'),
(2, 'Volkswagen');

INSERT INTO Carro (placa, marcaId, descricao) VALUES
('ABC1234', 1, 'Argo'),
('DEF5678', 1, 'Palio'),
('GHI4321', 2, 'Gol'),
('JKL9999', 2, 'Polo');

INSERT INTO Permanencia (id, carroPlaca, entrada, saida, valorPago) VALUES
(1, 'ABC1234', '2022-10-14 12:00', '2022-10-14 12:50', 11.00),
(2, 'DEF5678', '2022-10-14 09:00', '2022-10-14 10:00', 11.00),
(3, 'GHI4321', '2023-10-14 08:30', '2023-10-14 18:00', 20.00),
(4, 'GHI4321', '2023-10-16 08:40', '2023-10-16 18:15', 20.00),
(5, 'DEF5678', '2023-10-20 09:30', '2023-10-20 10:30', 12.00),
(6, 'ABC1234', '2023-11-20 12:10', '2023-11-20 13:00', 12.00);

-- ============================================================
-- (4) Alterar a placa do carro Polo
-- ============================================================
UPDATE Carro
SET placa = 'JKL8765'
WHERE descricao = 'Polo';

-- ============================================================
-- (5) Listar todos os dados de todos os carros cadastrados
-- ============================================================
SELECT * FROM Carro;

-- ============================================================
-- (6) Listar descricao e placa de todos os carros ordenando pela descricao
-- ============================================================
SELECT descricao, placa
FROM Carro
ORDER BY descricao;

-- ============================================================
-- (7) Listar marca, descricao e placa dos carros
-- ============================================================
SELECT m.nome AS marca, c.descricao, c.placa
FROM Carro c
JOIN Marca m ON c.marcaId = m.id;

-- ============================================================
-- (8) Listar a placa dos carros que não tiveram nenhuma permanencia
-- ============================================================
SELECT c.placa
FROM Carro c
LEFT JOIN Permanencia p ON c.placa = p.carroPlaca
WHERE p.id IS NULL;

-- ============================================================
-- (9) Listar descricao e placa de cada carro, contando quantas vezes permaneceu
-- ============================================================
SELECT c.descricao, c.placa, COUNT(p.id) AS quantidade_permanencias
FROM Carro c
LEFT JOIN Permanencia p ON c.placa = p.carroPlaca
GROUP BY c.descricao, c.placa;

-- ============================================================
-- (10) Listar o ano de permanencia (considerando a entrada)
--      e a soma dos valores pagos (totalPago), agrupando por ano
-- ============================================================
SELECT YEAR(entrada) AS ano, SUM(valorPago) AS totalPago
FROM Permanencia
GROUP BY YEAR(entrada)
ORDER BY ano;
