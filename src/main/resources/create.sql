--
-- Table structure for table `client_account`
--

DROP TABLE IF EXISTS client_account;
CREATE TABLE client_account (
  id serial,
  user_id int NOT NULL,
  amount decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (id)
)  ;

--
-- Dumping data for table `client_account`
--

--
-- Table structure for table `client_info`
--

DROP TABLE IF EXISTS client_info;
CREATE TABLE client_info (
  id serial,
  full_name varchar(255) NOT NULL,
  fin varchar(255) NOT NULL,
  date_of_birth date NOT NULL,
  occupation varchar(255) DEFAULT NULL,
  mobile_number varchar(255) NOT NULL,
  address varchar(255) NOT NULL,
  email varchar(255) DEFAULT NULL,
  user_id int DEFAULT NULL,
  PRIMARY KEY (Id)
  ,
  CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES "user" (id) ON DELETE NO ACTION ON UPDATE NO ACTION
)  ;

CREATE INDEX user_id_idx ON client_info (user_id);

--
-- Table structure for table `client_transaction`
--

DROP TABLE IF EXISTS client_transaction;

CREATE TABLE client_transaction (
  id serial,
  trans_code varchar(45) NOT NULL,
  status varchar(45) DEFAULT NULL,
  datetime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  amount decimal(19,4) DEFAULT NULL,
  user_id int NOT NULL,
  to_account_num varchar(45) NOT NULL,
  PRIMARY KEY (id)
)  ;

--
-- Table structure for table `transaction_code`
--

DROP TABLE IF EXISTS transaction_code;
CREATE TABLE transaction_code (
  id serial,
  code varchar(45) NOT NULL,
  user_id int NOT NULL,
  used boolean NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT code_UNIQUE UNIQUE  (code)
);

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS "user";
CREATE TABLE "user" (
  id serial,
  user_name varchar(45) NOT NULL,
  password varchar(45) NOT NULL,
  status varchar(45) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT user_name_UNIQUE UNIQUE  (user_name)
);

INSERT INTO "user" VALUES (1,'staff_1','123456','APPROVED'),(2,'staff_2','123456','APPROVED');

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS user_role;

CREATE TABLE user_role (
  id serial,
  user_name varchar(45) NOT NULL,
  role varchar(45) NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO user_role VALUES (1,'staff_1','staff'),(3,'staff_2','staff');
