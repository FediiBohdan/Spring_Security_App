DROP TABLE IF EXISTS users;
CREATE TABLE users (
                       username varchar(50) NOT NULL,
                       password varchar(50) NOT NULL,
                       enabled SMALLINT NOT NULL,
                       PRIMARY KEY (username));

INSERT INTO users
VALUES
('john','{noop}test123',1),
('mary','{noop}test123',1),
('susan','{noop}test123',1);

DROP TABLE IF EXISTS authorities;
CREATE TABLE authorities (
                             username varchar(50) NOT NULL,
                             authority varchar(50) NOT NULL,
                             FOREIGN KEY (username) REFERENCES users (username)
);

create index authorities_idx_1 on authorities (username,authority);

INSERT INTO authorities
VALUES
('john','ROLE_EMPLOYEE'),
('mary','ROLE_EMPLOYEE'),
('mary','ROLE_MANAGER'),
('susan','ROLE_EMPLOYEE'),
('susan','ROLE_ADMIN');