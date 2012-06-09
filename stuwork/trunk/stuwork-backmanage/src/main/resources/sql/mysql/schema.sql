       create table IF NOT EXISTS acct_role (
        id bigint not null auto_increment,
        name varchar(255) not null unique,
        primary key (id)
    ) ENGINE=InnoDB;


    create table IF NOT EXISTS acct_authority (
        id int not null auto_increment,
        name varchar(255) not null unique,
        primary key (id)
    ) ENGINE=InnoDB;

    create table IF NOT EXISTS acct_role (
        id bigint not null auto_increment,
        name varchar(255) not null unique,
        primary key (id)
    ) ENGINE=InnoDB;

    create table IF NOT EXISTS acct_role_authority (
        role_id bigint not null,
        authority_id bigint not null
    ) ENGINE=InnoDB;

    create table IF NOT EXISTS acct_user (
        id bigint not null auto_increment,
        email varchar(255),
        login_name varchar(255) not null unique,
        name varchar(255),
        password varchar(255),
        primary key (id)
    ) ENGINE=InnoDB;

    create table IF NOT EXISTS acct_user_role (
        user_id bigint not null,
        role_id bigint not null
    ) ENGINE=InnoDB;

   CREATE TABLE IF NOT EXISTS bm_schoolarea (
	  `id` int(10) unsigned NOT NULL auto_increment COMMENT '主键\r\n',
	  `code` varchar(10) NOT NULL,
	  `name` varchar(30) NOT NULL,
	  `address` varchar(50) NOT NULL,
	  PRIMARY KEY  (`id`),
	  UNIQUE KEY `ndexi_code` (`code`)
	) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
