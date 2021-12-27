DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users
(
    username varchar(50) NOT NULL,
    password char(68)    NOT NULL,
    enabled  SMALLINT    NOT NULL,
    PRIMARY KEY (username)
);

INSERT INTO users
VALUES ('john', '{bcrypt}$2a$10$CVTWxqzHL4z1PvKGBlT3F.Ql1d5inWK4yi5n53LoeLCJ3ToBtZRIG', 1),
       ('mary', '{bcrypt}$2a$10$lUsmvTfKJ3HuKvt8vpYT9eqCYfrELNML228a5K99nO./Z6A0Ux5S2', 1),
       ('susan', '{bcrypt}$2a$10$H20msxMeR.OEapfumENu2eX0xb3xMku5xS/W5qWulIhtDI9JPwAWC', 1);

DROP TABLE IF EXISTS authorities CASCADE;
CREATE TABLE authorities
(
    username  varchar(50) NOT NULL,
    authority varchar(50) NOT NULL,
    FOREIGN KEY (username) REFERENCES users (username)
);

create index authorities_idx_1 on authorities (username, authority);

INSERT INTO authorities
VALUES ('john', 'ROLE_EMPLOYEE'),
       ('mary', 'ROLE_EMPLOYEE'),
       ('mary', 'ROLE_MANAGER'),
       ('susan', 'ROLE_EMPLOYEE'),
       ('susan', 'ROLE_ADMIN');