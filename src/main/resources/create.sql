--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id int NOT NULL AUTO_INCREMENT,
  user_name varchar(45) NOT NULL,
  password varchar(45) NOT NULL,
  status varchar(45) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT user_name_UNIQUE UNIQUE  (user_name)
);

INSERT INTO users VALUES (1,'staff_1','123456','APPROVED'),(2,'staff_2','123456','APPROVED');

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS user_role;

CREATE TABLE user_role (
  id int NOT NULL AUTO_INCREMENT,
  user_name varchar(45) NOT NULL,
  role varchar(45) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO user_role VALUES (1,'staff_1','staff'),(3,'staff_2','staff');

--
-- Table structure for table `client_account`
--

DROP TABLE IF EXISTS client_account;
CREATE TABLE client_account (
  id int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  amount decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES users (id)
);

--
-- Dumping data for table `client_account`
--

--
-- Table structure for table `client_info`
--

DROP TABLE IF EXISTS client_info;
CREATE TABLE client_info (
  id int NOT NULL AUTO_INCREMENT,
  full_name varchar(255) NOT NULL,
  fin varchar(255) NOT NULL,
  date_of_birth date NOT NULL,
  occupation varchar(255) DEFAULT NULL,
  mobile_number varchar(255) NOT NULL,
  address varchar(255) NOT NULL,
  email varchar(255) DEFAULT NULL,
  user_id int DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT ci_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE INDEX user_id_idx ON client_info (user_id);

--
-- Table structure for table `client_transaction`
--

DROP TABLE IF EXISTS client_transaction;

CREATE TABLE client_transaction (
  id int NOT NULL AUTO_INCREMENT,
  trans_code varchar(45) NOT NULL,
  status varchar(45) DEFAULT NULL,
  datetime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  amount decimal(19,4) DEFAULT NULL,
  user_id int NOT NULL REFERENCES users (id),
  from_account int NOT NULL REFERENCES client_account (id),
  to_account int NOT NULL REFERENCES client_account (id),
  PRIMARY KEY (id)
)  ;

--
-- Table structure for table `transaction_code`
--

DROP TABLE IF EXISTS transaction_code;
CREATE TABLE transaction_code (
  id int NOT NULL AUTO_INCREMENT,
  code varchar(45) NOT NULL,
  user_id int NOT NULL,
  used boolean NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT code_UNIQUE UNIQUE  (code)
);
