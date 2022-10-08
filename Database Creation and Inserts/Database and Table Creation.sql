DROP DATABASE IF EXISTS brightsolid;
CREATE DATABASE IF NOT EXISTS brightsolid;
USE brightsolid;

CREATE TABLE platform (
	platform_id serial NOT NULL,
    platform_name varchar(255) NOT NULL,
    PRIMARY KEY (platform_id)
);

CREATE TABLE resource_type (
	resource_type_id serial NOT NULL,
    resource_type_name varchar(255) NOT NULL,
    platform_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (platform_id) REFERENCES platform(platform_id),
    PRIMARY KEY (resource_type_id)

);

CREATE TABLE customer (
	customer_id serial NOT NULL,
    customer_name varchar(255) NOT NULL,
    
    PRIMARY KEY (customer_id)
);

CREATE TABLE account (
	account_id serial NOT NULL,
    account_ref varchar(255) NOT NULL,
    platform_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY (platform_id) REFERENCES platform(platform_id),
    PRIMARY KEY (account_id)
);


CREATE TABLE resource (
	resource_id serial NOT NULL,
    resource_ref varchar(255) NOT NULL,
    account_id BIGINT UNSIGNED NOT NULL,
    resource_type_id BIGINT UNSIGNED NOT NULL,
    resource_name varchar(255) NOT NULL,
    last_updated timestamp NOT NULL,
    FOREIGN KEY (resource_type_id) REFERENCES resource_type(resource_type_id),
    FOREIGN KEY (account_id) REFERENCES account(account_id),
    PRIMARY KEY (resource_id)
	

);


CREATE TABLE user_role (
	user_role_id serial NOT NULL,
    user_role_name varchar(255) NOT NULL,
    
    PRIMARY KEY (user_role_id)
);

CREATE TABLE user (
	user_id serial NOT NULL,
    user_name varchar(255) NOT NULL UNIQUE,
    user_password varchar(255) NOT NULL,
    role_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (role_id) REFERENCES user_role(user_role_id),
	PRIMARY KEY (user_id)
     
);

CREATE TABLE rule (
	rule_id serial NOT NULL,
    rule_name varchar(255) NOT NULL,
    resource_type_id BIGINT UNSIGNED NOT NULL,
	rule_description varchar(1024) NOT NULL,
	FOREIGN KEY (resource_type_id) REFERENCES resource_type(resource_type_id),
	PRIMARY KEY (rule_id)
);

CREATE TABLE non_compliance (
	resource_id BIGINT UNSIGNED NOT NULL,
    rule_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (resource_id) REFERENCES resource(resource_id),
	FOREIGN KEY (rule_id) REFERENCES rule(rule_id)
);

CREATE TABLE non_compliance_audit (
	non_compliance_audit_id serial NOT NULL,
    non_compliance_id int(4) NOT NULL,
    resource_id BIGINT UNSIGNED NOT NULL,
    rule_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    action varchar(255) NOT NULL,
    action_dt timestamp NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(user_id),
	FOREIGN KEY (resource_id) REFERENCES resource(resource_id),
    FOREIGN KEY (rule_id) REFERENCES rule(rule_id),
    PRIMARY KEY (non_compliance_audit_id)
);

CREATE TABLE exception (
	exception_id serial NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    resource_id BIGINT UNSIGNED NOT NULL,
    last_updated_by BIGINT UNSIGNED NOT NULL,
    exception_value varchar(255) NOT NULL,
    justification varchar(255) NOT NULL,
    review_date timestamp NOT NULL,
    last_updated timestamp NOT NULL,
	 FOREIGN KEY (last_updated_by) REFERENCES user(user_id), /* unsure */
	FOREIGN KEY (resource_id) REFERENCES resource(resource_id),
	 FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
     PRIMARY KEY (exception_id)
);

CREATE TABLE exception_audit (
	exception_audit_id serial NOT NULL,
    exception_id int(4) NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    customer_id BIGINT UNSIGNED NOT NULL,
    rule_id BIGINT UNSIGNED NOT NULL,
    action varchar(255) NOT NULL,
    action_dt timestamp NOT NULL,
    old_exception_value varchar(255),
    new_exception_value varchar(255),
    old_justification varchar(255),
    new_justification varchar(255),
    old_review_date timestamp,
    new_review_date timestamp,
    FOREIGN KEY (user_id) REFERENCES user(user_id), 
    FOREIGN KEY (rule_id) REFERENCES rule(rule_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),

	PRIMARY KEY (exception_audit_id)
);

SET FOREIGN_KEY_CHECKS=0;
INSERT INTO account(account_id,account_ref,platform_id,customer_id) VALUES (1,011072135518,2,1);
INSERT INTO customer(customer_id,customer_name) VALUES (1,'brightsolid');
INSERT INTO exception(exception_id,customer_id,resource_id,last_updated_by,exception_value,justification,review_date,last_updated) VALUES (1,1,1144,1,'bs-quorum-dropbox','Enabled by system','2022-12-12 16:23:47','22-09-12 17:25:37');
INSERT INTO exception(exception_id,customer_id,resource_id,last_updated_by,exception_value,justification,review_date,last_updated) VALUES (3,1,1144,1,'bsol-dev-bakery-assets','Enabled by system','2022-12-12 16:23:47','22-09-12 17:25:37');


INSERT INTO non_compliance(resource_id,rule_id) VALUES (1269,1);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1151,1);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1152,1);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1153,1);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1323,2);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1139,2);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1140,2);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1325,2);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1328,2);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1141,2);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1142,2);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1143,2);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1144,3);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1319,4);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1320,4);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1321,4);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1325,4);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1324,4);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1145,4);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1329,4);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1330,4);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1335,4);
INSERT INTO non_compliance(resource_id,rule_id) VALUES (1138,4);


INSERT INTO platform(platform_id,platform_name) VALUES (2,'aws');
INSERT INTO platform(platform_id,platform_name) VALUES (3,'azure');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1128,'i-060476bb31df657e7',1,1,'vault test','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1129,'i-0e51ddd315580fd58',1,1,'Vault Auth Test','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1130,'i-08a220f9238167574',1,1,'vault','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1131,'i-018bd0211080b237d',1,1,'consul-eu-west-2c','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1132,'i-0a7f0da0406dde702',1,1,'vault','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1133,'i-0910faa3ec99dc39a',1,1,'BigLogger','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1134,'i-0cbb8d2103731104b',1,1,'dh-dc1','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1135,'i-035d70a9b8a87b517',1,1,'bp-inspec-test','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1136,'i-0f4a552c42763a347',1,1,'Martyn Windows Test - Member Server','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1137,'i-0d10914a605a86389',1,1,'MLP','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1138,'imustdestdeletions',1,12,'imustdestdeletions','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1139,'bs-website-scaling-test-webroot',1,12,'bs-website-scaling-test-webroot','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1140,'bs-website-test-blue-webroot',1,12,'bs-website-test-blue-webroot','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1141,'custodian-console-dev-serverlessdeploymentbucket-t1pcg5tyd3i',1,12,'CloudCustodian','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1142,'website-devtest-webroot-backup',1,12,'website-webroot-backup','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1143,'website-devtest-assets-backup',1,12,'website-assets-backup','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1144,'i-006d83e00aabe31d2',1,1,'DMZ Instance','2022-09-08 14:18:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1145,'bsol-dev-subnet-flowlogs',1,12,'bsol-dev-subnet-flowlogs','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1146,'vol-0336e11258dca1478',1,2,'vol-0336e11258dca1478','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1147,'vol-08cf5074b4b907376',1,2,'vault','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1148,'vol-02b32d9eaed805c78',1,2,'MLP','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1149,'vol-0cc8f799f2066ee69',1,2,'vol-0cc8f799f2066ee69','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1150,'vol-04e83966f6e9fd26f',1,2,'bp-inspec-test','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1151,'vol-0e181efd2ccb65947',1,2,'vol-0e181efd2ccb65947','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1152,'vol-0d589e5ded91a1aa2',1,2,'Vault Auth Test','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1153,'vol-0f1c53f6796a5fd3a',1,2,'dh-dc1','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1154,'vol-03207f2066a2ac8cd',1,2,'vault','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1155,'vol-0d1d1cb0a98322818',1,2,'consul-eu-west-2c','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1156,'arn:aws:autoscaling:eu-west-2:011072135518:autoScalingGroup:207ed52e-bc82-4020-a163-5a40719a9962:autoScalingGroupName/consul-eu-west-2c-asg',1,3,'consul-eu-west-2c','2022-09-08 14:36:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1157,'arn:aws:autoscaling:eu-west-2:011072135518:autoScalingGroup:a2ee3fb9-a1f3-4885-83f7-590242535715:autoScalingGroupName/gitlab-asg',1,3,'gitlab','2022-09-08 14:36:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1158,'arn:aws:autoscaling:eu-west-2:011072135518:autoScalingGroup:85a8da78-d820-40f4-b401-5fb4ac55d2e8:autoScalingGroupName/gitlab-dev-runner-asg',1,3,'gitlab-dev-runner','2022-09-08 14:36:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1159,'arn:aws:autoscaling:eu-west-2:011072135518:autoScalingGroup:0986b5ee-f56e-4d8c-b253-d2844d8b94d5:autoScalingGroupName/packer-asg-test',1,3,'arn:aws:autoscaling:eu-west-2:011072135518:autoScalingGroup:0986b5ee-f56e-4d8c-b253-d2844d8b94d5:autoScalingGroupName/packer-asg-test','2022-09-08 14:36:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1160,'eni-03b71db5c0114e362',1,6,'eni-03b71db5c0114e362','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1161,'arn:aws:autoscaling:eu-west-2:011072135518:autoScalingGroup:96b0e021-d03e-40de-aeb4-1b8d2e983c1c:autoScalingGroupName/vault-asg',1,3,'vault','2022-09-08 14:36:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1162,'fs-0f41cf03bee996d6f',1,4,'dh-unencrypted-efs-test2','2022-09-08 14:39:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1163,'fs-5014f9a0',1,4,'efs2api test EFS volume','2022-09-08 14:39:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1164,'fs-2bd54bda',1,4,'gitlab-efs','2022-09-08 14:39:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1165,'arn:aws:elasticloadbalancing:eu-west-2:011072135518:loadbalancer/app/consul-lb/84cc7f3969b5117f',1,5,'consul-lb','2022-09-08 14:43:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1166,'eni-0e2f472cde9bdfc16',1,6,'eni-0e2f472cde9bdfc16','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1167,'eni-01a691b1215fb9df1',1,6,'eni-01a691b1215fb9df1','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1168,'eni-0ba6b424f3dbe9dc7',1,6,'eni-0ba6b424f3dbe9dc7','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1169,'eni-0bd91b6c84d23623e',1,6,'eni-0bd91b6c84d23623e','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1170,'eni-0d7dba12f9897803d',1,6,'eni-0d7dba12f9897803d','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1171,'eni-0ee400a87fae1d9cf',1,6,'eni-0ee400a87fae1d9cf','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1172,'eni-00733fb541268b581',1,6,'eni-00733fb541268b581','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1173,'eni-0aa1501647f12ae7f',1,6,'eni-0aa1501647f12ae7f','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1174,'eni-090ea3f15462a487c',1,6,'Martyn Windows Test - Member Server','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1175,'eni-092687a0443fc5ae0',1,6,'eni-092687a0443fc5ae0','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1176,'eni-075533838de933707',1,6,'eni-075533838de933707','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1177,'eni-0267ceaa5c6f83954',1,6,'DMZ ENI','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1321,'bs-quorum-dropbox',1,12,'bs-quorum-dropbox','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1178,'eni-0778226d4a8bc5d7a',1,6,'dh-dc1','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1179,'eni-050815700548dc69c',1,6,'eni-050815700548dc69c','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1180,'eni-0cc091ed6a819490b',1,6,'eni-0cc091ed6a819490b','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1181,'eni-06a519e8f978a3851',1,6,'eni-06a519e8f978a3851','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1182,'eni-0f380c67b14b459a0',1,6,'eni-0f380c67b14b459a0','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1183,'eni-08e0af5fbc8186287',1,6,'MLP','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1184,'eni-049465dba8337b093',1,6,'eni-049465dba8337b093','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1185,'eni-0a65b1737d98a74b8',1,6,'bp-inspec-test','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1186,'eni-07452a19b944bb2fe',1,6,'eni-07452a19b944bb2fe','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1187,'eni-024f563a76a1ca1e7',1,6,'eni-024f563a76a1ca1e7','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1188,'eni-067f2df822c209992',1,6,'eni-067f2df822c209992','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1189,'eni-079efc6eccb103d88',1,6,'eni-079efc6eccb103d88','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1190,'eni-03eae416ef3b302b1',1,6,'eni-03eae416ef3b302b1','2022-09-08 14:45:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1191,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1192,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1193,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-customer-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-customer-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1194,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1195,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1328,'bsol-dev-tf-remotestate',1,12,'bsol-dev Terraform Remote State Bucket','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1196,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-unauthorised-public-eni',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-unauthorised-public-eni','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1197,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduled-instances-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduled-instances-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1198,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-unauthorised-public-function',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-unauthorised-public-function','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1199,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-unencrypted-volume',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-unencrypted-volume','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1200,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-ok-snapshots-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-ok-snapshots-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1329,'bsol-exception-test-no-customer-code2',1,12,'bsol-exception-test-no-customer-code2','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1201,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1202,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-scheduled-interfaces-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-scheduled-interfaces-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1203,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-customer-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-customer-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1204,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduled-instances-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduled-instances-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1205,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-ok-snapshots-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-ok-snapshots-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1330,'bsol-test-no-customer-code2',1,12,'bsol-test-no-customer-code2','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1206,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduled-instances-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduled-instances-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1207,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-unauthorised-public-load-balancer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-unauthorised-public-load-balancer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1208,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1209,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-unencrypted-instances',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-unencrypted-instances','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1210,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-functions-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-functions-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1331,'dh080622',1,12,'dh080622','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1211,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-inst-with-invalid-resource-owner-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-inst-with-invalid-resource-owner-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1212,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduler-optin-startup',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduler-optin-startup','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1213,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-inst-with-invalid-customer-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-inst-with-invalid-customer-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1214,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-scheduled-interfaces-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-scheduled-interfaces-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1215,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1332,'lgis-logging-bucket-1',1,12,'lgis-logging-bucket-1','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1216,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1217,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1218,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-project-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-project-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1219,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-instances-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-instances-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1220,'arn:aws:lambda:eu-west-2:011072135518:function:efs2api-test-api-frontend-lambda',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:efs2api-test-api-frontend-lambda','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1221,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-scheduler-optin-startup',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-scheduler-optin-startup','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1222,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-customer-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-customer-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1223,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-func-with-invalid-customer-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-func-with-invalid-customer-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1224,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-scheduled-interfaces-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-scheduled-interfaces-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1225,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-project-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-project-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1333,'lgis-spatialhub-docker-logs',1,12,'lgis-spatialhub-docker-logs','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1226,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-func-with-invalid-project-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-func-with-invalid-project-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1227,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-unauthorised-public-db-instance',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-unauthorised-public-db-instance','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1228,'arn:aws:lambda:eu-west-2:011072135518:function:brightsolid-dev-test-autoscaling-dns-lambda',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:brightsolid-dev-test-autoscaling-dns-lambda','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1229,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-unauthorised-public-autoscaling-group',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-unauthorised-public-autoscaling-group','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1230,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-customer-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-customer-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1231,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-inst-with-invalid-customer-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-inst-with-invalid-customer-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1232,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1233,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-remediate-snapshots-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-remediate-snapshots-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1234,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-functions-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-functions-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1235,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1236,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1237,'arn:aws:lambda:eu-west-2:011072135518:function:dddd',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:dddd','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1238,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduler-optin-shutdown',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduler-optin-shutdown','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1239,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1240,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-tag-snapshots-with-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-tag-snapshots-with-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1241,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-console-dev-app',1,7,'CloudCustodian','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1242,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-unencrypted-instances',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-unencrypted-instances','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1334,'mgn-staging-angus',1,12,'mgn-staging-angus','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1243,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-instances-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-instances-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1244,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1245,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1246,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-volumes-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-volumes-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1247,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-instances-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-instances-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1335,'dctdatarecovery',1,12,'dctdatarecovery','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1248,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-project-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-project-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1249,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-func-with-invalid-customer-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-func-with-invalid-customer-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1250,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-resource-owner-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-resource-owner-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1251,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-unauthorised-public-load-balancer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-unauthorised-public-load-balancer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1252,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-instances-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-instances-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1253,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-customer-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-customer-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1254,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-project-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-project-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1255,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-resource-owner-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-resource-owner-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1256,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-customer-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-customer-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1257,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-customer-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-customer-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1258,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-project-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-project-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1259,'arn:aws:lambda:eu-west-2:011072135518:function:efs2api-test-api-backend-lambda',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:efs2api-test-api-backend-lambda','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1260,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-remediate-snapshots-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-remediate-snapshots-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1261,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1262,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1263,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1264,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-unauthorised-public-instance',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-unauthorised-public-instance','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1265,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1266,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-tag-snapshots-with-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-tag-snapshots-with-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1267,'arn:aws:lambda:eu-west-2:011072135518:function:gitlab-external-api-test-website-rebuilder',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:gitlab-external-api-test-website-rebuilder','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1268,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-customer-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-customer-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1269,'vol-0467a9dc3638c8e61',1,2,'Martyn Windows Test - Member Server','2022-09-08 14:31:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1270,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-customer-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-customer-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1271,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-volumes-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-volumes-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1272,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-project-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-project-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1273,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-scheduled-interfaces-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-scheduled-interfaces-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1274,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-customer-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-customer-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1275,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-volumes-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-volumes-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1276,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1277,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-project-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-project-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1278,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduled-instances-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-scheduled-instances-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1279,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1280,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-scheduler-optin-shutdown',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-scheduler-optin-shutdown','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1281,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-functions-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-functions-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1282,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-efs-detect-unencrypted-filesystem',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-efs-detect-unencrypted-filesystem','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1283,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-console-dev-custom-resource-apigw-cw-role',1,7,'CloudCustodian','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1284,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-scheduler-optin-shutdown',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-scheduler-optin-shutdown','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1285,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-resource-owner-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-volumes-with-invalid-resource-owner-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1286,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-volumes-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-volumes-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1287,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1288,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-resource-owner-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-resource-owner-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1289,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-buckets-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1290,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-resource-owner-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-resource-owner-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1291,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-scheduler-optin-startup',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-scheduler-optin-startup','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1292,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-remediate-snapshots-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-remediate-snapshots-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1293,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-eni-detect-interfaces-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1294,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-resource-owner-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-resource-owner-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1295,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-unencrypted-bucket',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-unencrypted-bucket','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1296,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-unencrypted-volume',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-detect-unencrypted-volume','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1297,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1298,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-tag-snapshots-with-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-tag-snapshots-with-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1299,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1300,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-customer-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-customer-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1301,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-tag-snapshots-with-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-tag-snapshots-with-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1302,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1303,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-resource-owner',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-asg-detect-groups-with-invalid-resource-owner','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1304,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-functions-with-invalid-project-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-functions-with-invalid-project-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1305,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-customer-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-customer-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1306,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-resource-owner-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-rds-detect-instances-with-invalid-resource-owner-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1307,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-ok-snapshots-customer',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-ok-snapshots-customer','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1308,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-func-with-invalid-resource-owner-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-lambda-detect-func-with-invalid-resource-owner-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1309,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-customer-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ec2-detect-instances-with-invalid-customer-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1310,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-ok-snapshots-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-ok-snapshots-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1311,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-unauthorised-public-bucket',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-s3-detect-unauthorised-public-bucket','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1312,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-customer-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elb-detect-instances-with-invalid-customer-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1313,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-inst-with-invalid-project-code-user',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-elbv2-detect-inst-with-invalid-project-code-user','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1314,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-remediate-snapshots-customer-code',1,7,'arn:aws:lambda:eu-west-2:011072135518:function:custodian-ebs-scheduled-remediate-snapshots-customer-code','2022-09-08 14:47:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1315,'database-1',1,10,'database-1','2022-09-08 15:20:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1316,'internal-demoelb-1460921233.eu-west-2.elb.amazonaws.com',1,11,'tes-elb','2022-09-08 15:25:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1317,'280622bsolbadbucket',1,12,'280622bsolbadbucket','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1318,'aws-athena-query-results-eu-west-2-011072135518',1,12,'aws-athena-query-results-eu-west-2-011072135518','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1319,'billptemp',1,12,'billptemp','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1320,'brightsolid',1,12,'brightsolid','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1322,'bsol-dev-mdr-conversions',1,12,'bsol-dev-mdr-conversions','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1323,'brightsolid-website-infra-dev-ft-initial-dev-webroot',1,12,'brightsolid-website-infra-dev-ft-initial-dev-webroot','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1324,'bsol-dev-bakery-assets',1,12,'bsol-dev-bakery-assets','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1325,'bsol-contract-web-hosting-test',1,12,'bsol-contract-web-hosting-test','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1326,'bsol-mdr-conversions',1,12,'bsol-mdr-conversions','2022-09-08 15:27:00');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated) VALUES (1327,'cdk-hnb659fds-assets-011072135518-eu-west-2',1,12,'cdk-hnb659fds-assets-011072135518-eu-west-2','2022-09-08 15:27:00');

INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (1,'ec2',2);
INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (2,'ebs',2);
INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (3,'asg',2);
INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (4,'efs',2);
INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (5,'app-elb',2);
INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (6,'eni',2);
INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (7,'lambda',2);
INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (10,'rds',2);
INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (11,'elb',2);
INSERT INTO resource_type(resource_type_id,resource_type_name,platform_id) VALUES (12,'s3',2);

INSERT INTO rule(rule_id,rule_name,resource_type_id,rule_description) VALUES (1,'ebs-detect-unencrypted-volume',2,'If a developer creates an AWS EC2 Instance and the AWS EBS storage volume(s) attached to the instance are not encrypted then the the developer and compliance team are notified.');
INSERT INTO rule(rule_id,rule_name,resource_type_id,rule_description) VALUES (2,'s3-detect-unauthorised-public-bucket',12,'If a developer creates or updates AWS S3 Bucket to make it publically visible to anyone on the internet, then automatically change the S3 Bucket configuration to make it private and the developer and compliance team are notified.');
INSERT INTO rule(rule_id,rule_name,resource_type_id,rule_description) VALUES (3,'ec2-detect-unauthorised-public-instance',1,'If a developer creates an AWS EC2 Instance and attaches the instance to a public subnet (e.g. a subnet which is addressable to/from the internet) then the AWS EC2 instance is automatically terminated and the developer and compliance team are notified');
INSERT INTO rule(rule_id,rule_name,resource_type_id,rule_description) VALUES (4,'s3-detect-unencrypted-bucket',12,'If a developer creates or updates AWS S3 Bucket and sets the default encryption to unencrypted, then automatically change the S3 Bucket configuration to make the encryption default use the default S3 encryption key, and the developer and compliance team are notified.');
INSERT INTO rule(rule_id,rule_name,resource_type_id,rule_description) VALUES (5,'efs-detect-unencrypted-filesystem',4,'If a developer creates or updates an EFS Volume and sets the encryption setting to unencrypted, the developer and compliance team are notified.');
INSERT INTO rule(rule_id,rule_name,resource_type_id,rule_description) VALUES (6,'rds-detect-unauthorised-public-db-instance',10,'If a developer creates an AWS RDS Instance and attaches the instance to a public subnet (e.g. a subnet which is addressable to/from the internet) then the developer and compliance team are notified');
INSERT INTO rule(rule_id,rule_name,resource_type_id,rule_description) VALUES (7,'rds-detect-unencrypted-instances',10,'If a developer creates an AWS RDS Instance and the storage attached to the Instance is not encrypted then the the developer and compliance team are notified.');
INSERT INTO rule(rule_id,rule_name,resource_type_id,rule_description) VALUES (8,'lambda-detect-unauthorised-public-function',7,'If a developer creates an AWS Lambda function and attaches the instance to a public subnet (e.g. a subnet which is addressable to/from the internet) then the developer and compliance team are notified');

INSERT INTO user(user_id,user_name,user_password,role_id,customer_id) VALUES (1,'system','password',1,1);

INSERT INTO user_role(user_role_id,user_role_name) VALUES (1,'system');


-- Login verifcation for users--
DELIMITER //
CREATE FUNCTION login(uName VARCHAR(255), uPassword VARCHAR(255)) RETURNS INT
BEGIN
	if EXISTS(select * from user where uName = user.user_name and uPassword = user.user_password)
		THEN
			return 1;

	ELSE 
		        return 0;
	END if;
END //
DELIMITER ;

--Gathers accounts based off userID--

DELIMITER //
CREATE PROCEDURE gather_accounts(uID int)
BEGIN

SELECT account.account_ref FROM account, customer, user WHERE account.customer_id = customer.customer_id AND user.user_ID = uID;

END //
DELIMITER ;

-- get resources based off rule id and customer id--

DELIMITER //
CREATE PROCEDURE get_resource_for_rules(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID;
END //
DELIMITER ;exception

-- gets non compliant resources for a rule -- 

DELIMITER //
CREATE PROCEDURE get_non_compliant_resource_for_rules(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name, resource.resource_id
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
    LEFT JOIN non_compliance ON non_compliance.resource_id = resource.resource_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID AND non_compliance.resource_id = resource.resource_id;
END //
DELIMITER ;

-- gets exception for a resource -- 

DELIMITER //
CREATE PROCEDURE get_exception_for_resource(resourceID int, cID int)
BEGIN
	SELECT exception.exception_value, exception.last_updated_by, exception.justification, exception.review_date, exception.last_updated
	FROM exception
    
	LEFT JOIN resource
    ON exception.resource_id = resource.resource_id 
    
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
	WHERE resource.resource_id = resourceID AND customer.customer_id = cID;
END //
DELIMITER ;

-- gets exceptions for a resource for a rule --

DELIMITER //
CREATE PROCEDURE get_exceptions_for_resource_for_a_rule(ruleID int, cID int)
BEGIN
	SELECT resource.resource_name, resource.resource_id
	FROM resource
	LEFT JOIN resource_type ON resource.resource_type_id = resource_type.resource_type_id
	LEFT JOIN rule ON resource_type.resource_type_id = rule.resource_type_id
    LEFT JOIN account ON account.account_id = resource.account_id
    LEFT JOIN customer ON customer.customer_id = account.account_id
    LEFT JOIN exception ON exception.resource_id = resource.resource_id
	WHERE rule.rule_id = ruleID AND customer.customer_id = cID AND exception.resource_id = resource.resource_id;
END //
DELIMITER ;




