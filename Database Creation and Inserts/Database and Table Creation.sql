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
    resource_metadata json NOT NULL,
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
    user_name varchar(255) NOT NULL,
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
    rule_id BIGINT UNSIGNED NOT NULL,
    last_updated_by BIGINT UNSIGNED NOT NULL,
    exception_value varchar(255) NOT NULL,
    justification varchar(255) NOT NULL,
    review_date timestamp NOT NULL,
    last_updated timestamp NOT NULL,
	 FOREIGN KEY (last_updated_by) REFERENCES user(user_id), /* unsure */
	FOREIGN KEY (rule_id) REFERENCES rule(rule_id),
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
INSERT INTO exception(exception_id,customer_id,rule_id,last_updated_by,exception_value,justification,review_date,last_updated) VALUES (1,1,4,1,'bs-quorum-dropbox','Enabled by system','2022-12-12 16:23:59','2022-09-12 17:25:36');
INSERT INTO exception(exception_id,customer_id,rule_id,last_updated_by,exception_value,justification,review_date,last_updated) VALUES (3,1,4,1,'bsol-dev-bakery-assets','Enabled by system','2022-12-12 16:23:59','2022-09-12 17:25:36');


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

INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated,resource_metadata) VALUES (1128,'i-060476bb31df657e7',1,1,'vault test','2022-09-08 14:18:00','{"AmiLaunchIndex": 0, "ImageId": "ami-0089b31e09ac3fffc", "InstanceId": "i-060476bb31df657e7", "InstanceType": "t2.micro", "KeyName": "pc-dev-keypair01", "LaunchTime": "2021-04-12T15:41:40+00:00", "Monitoring": {"State": "disabled"}, "Placement": {"AvailabilityZone": "eu-west-2a", "GroupName": "", "Tenancy": "default"}, "PrivateDnsName": "ip-10-184-0-18.eu-west-2.compute.internal", "PrivateIpAddress": "10.184.0.18", "ProductCodes": [], "PublicDnsName": "", "State": {"Code": 80, "Name": "stopped"}, "StateTransitionReason": "User initiated (2021-04-12 15:43:14 GMT)", "SubnetId": "subnet-0385927a7d61e8706", "VpcId": "vpc-05da5d22d7bd6f8cf", "Architecture": "x86_64", "BlockDeviceMappings": [{"DeviceName": "/dev/xvda", "Ebs": {"AttachTime": "2020-02-10T21:21:24+00:00", "DeleteOnTermination": true, "Status": "attached", "VolumeId": "vol-0e181efd2ccb65947"}}], "ClientToken": "", "EbsOptimized": false, "EnaSupport": true, "Hypervisor": "xen", "IamInstanceProfile": {"Arn": "arn:aws:iam::011072135518:instance-profile/vaultInstanceProfile", "Id": "AIPAQFE7TMFPMA6DXMOQM"}, "NetworkInterfaces": [{"Attachment": {"AttachTime": "2020-02-10T21:21:23+00:00", "AttachmentId": "eni-attach-0ab8f83f7f6acfb0a", "DeleteOnTermination": true, "DeviceIndex": 0, "Status": "attached", "NetworkCardIndex": 0}, "Description": "", "Groups": [{"GroupName": "launch-wizard-4", "GroupId": "sg-0072d99591e9b5afb"}], "Ipv6Addresses": [], "MacAddress": "06:70:52:26:68:62", "NetworkInterfaceId": "eni-0aa1501647f12ae7f", "OwnerId": "011072135518", "PrivateDnsName": "ip-10-184-0-18.eu-west-2.compute.internal", "PrivateIpAddress": "10.184.0.18", "PrivateIpAddresses": [{"Primary": true, "PrivateDnsName": "ip-10-184-0-18.eu-west-2.compute.internal", "PrivateIpAddress": "10.184.0.18"}], "SourceDestCheck": true, "Status": "in-use", "SubnetId": "subnet-0385927a7d61e8706", "VpcId": "vpc-05da5d22d7bd6f8cf", "InterfaceType": "interface"}], "RootDeviceName": "/dev/xvda", "RootDeviceType": "ebs", "SecurityGroups": [{"GroupName": "launch-wizard-4", "GroupId": "sg-0072d99591e9b5afb"}], "SourceDestCheck": true, "StateReason": {"Code": "Client.UserInitiatedShutdown", "Message": "Client.UserInitiatedShutdown: User initiated shutdown"}, "Tags": [{"Key": "customer", "Value": "brightsolid"}, {"Key": "customer_code", "Value": "16BSOT01"}, {"Key": "project_code", "Value": "08-BSOT-931"}, {"Key": "Name", "Value": "vault test"}, {"Key": "resource_owner", "Value": "109bb604.brightsolid.com@emea.teams.ms"}, {"Key": "c7n:FindingId:ec2-instance-with-invalid-customer", "Value": "eu-west-2/011072135518/10b41698007565e1d396787f129479ce/f2e74d392bf3eaf1359eb8e6c4530568:2020-09-10T16:10:14.602386+00:00"}], "VirtualizationType": "hvm", "CpuOptions": {"CoreCount": 1, "ThreadsPerCore": 1}, "CapacityReservationSpecification": {"CapacityReservationPreference": "open"}, "HibernationOptions": {"Configured": false}, "MetadataOptions": {"State": "applied", "HttpTokens": "optional", "HttpPutResponseHopLimit": 1, "HttpEndpoint": "enabled", "HttpProtocolIpv6": "disabled", "InstanceMetadataTags": "disabled"}, "EnclaveOptions": {"Enabled": false}, "PlatformDetails": "Linux/UNIX", "UsageOperation": "RunInstances", "UsageOperationUpdateTime": "2020-02-10T21:21:23+00:00", "PrivateDnsNameOptions": {}, "MaintenanceOptions": {"AutoRecovery": "default"}}');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated,resource_metadata) VALUES (1129,'i-0e51ddd315580fd58',1,1,'Vault Auth Test','2022-09-08 14:18:00','{"AmiLaunchIndex": 0, "ImageId": "ami-01a6e31ac994bbc09", "InstanceId": "i-0e51ddd315580fd58", "InstanceType": "t2.nano", "KeyName": "pc-dev-keypair01", "LaunchTime": "2020-04-16T09:44:16+00:00", "Monitoring": {"State": "disabled"}, "Placement": {"AvailabilityZone": "eu-west-2a", "GroupName": "", "Tenancy": "default"}, "PrivateDnsName": "ip-10-184-0-139.eu-west-2.compute.internal", "PrivateIpAddress": "10.184.0.139", "ProductCodes": [], "PublicDnsName": "", "State": {"Code": 80, "Name": "stopped"}, "StateTransitionReason": "User initiated (2020-07-31 15:40:10 GMT)", "SubnetId": "subnet-0385927a7d61e8706", "VpcId": "vpc-05da5d22d7bd6f8cf", "Architecture": "x86_64", "BlockDeviceMappings": [{"DeviceName": "/dev/xvda", "Ebs": {"AttachTime": "2020-04-16T09:44:17+00:00", "DeleteOnTermination": true, "Status": "attached", "VolumeId": "vol-0d589e5ded91a1aa2"}}], "ClientToken": "", "EbsOptimized": false, "EnaSupport": true, "Hypervisor": "xen", "IamInstanceProfile": {"Arn": "arn:aws:iam::011072135518:instance-profile/Vault_Client", "Id": "AIPAQFE7TMFPMBUAKVFGZ"}, "NetworkInterfaces": [{"Attachment": {"AttachTime": "2020-04-16T09:44:16+00:00", "AttachmentId": "eni-attach-017741bad6f8d893f", "DeleteOnTermination": true, "DeviceIndex": 0, "Status": "attached", "NetworkCardIndex": 0}, "Description": "Primary network interface", "Groups": [{"GroupName": "launch-wizard-4", "GroupId": "sg-0072d99591e9b5afb"}], "Ipv6Addresses": [], "MacAddress": "06:49:82:e3:89:c2", "NetworkInterfaceId": "eni-0ba6b424f3dbe9dc7", "OwnerId": "011072135518", "PrivateDnsName": "ip-10-184-0-139.eu-west-2.compute.internal", "PrivateIpAddress": "10.184.0.139", "PrivateIpAddresses": [{"Primary": true, "PrivateDnsName": "ip-10-184-0-139.eu-west-2.compute.internal", "PrivateIpAddress": "10.184.0.139"}], "SourceDestCheck": true, "Status": "in-use", "SubnetId": "subnet-0385927a7d61e8706", "VpcId": "vpc-05da5d22d7bd6f8cf", "InterfaceType": "interface"}], "RootDeviceName": "/dev/xvda", "RootDeviceType": "ebs", "SecurityGroups": [{"GroupName": "launch-wizard-4", "GroupId": "sg-0072d99591e9b5afb"}], "SourceDestCheck": true, "StateReason": {"Code": "Client.UserInitiatedShutdown", "Message": "Client.UserInitiatedShutdown: User initiated shutdown"}, "Tags": [{"Key": "c7n:FindingId:ec2-instance-with-invalid-customer", "Value": "eu-west-2/011072135518/10b41698007565e1d396787f129479ce/6d239a83b5c37cf6c9ebd4e28762e3fb:2020-09-10T16:10:14.602386+00:00"}, {"Key": "customer_code", "Value": "16BSOT01"}, {"Key": "customer", "Value": "brightsolid"}, {"Key": "Name", "Value": "Vault Auth Test"}, {"Key": "project_code", "Value": "08-BSOT-931"}, {"Key": "resource_owner", "Value": "109bb604.brightsolid.com@emea.teams.ms"}], "VirtualizationType": "hvm", "CpuOptions": {"CoreCount": 1, "ThreadsPerCore": 1}, "CapacityReservationSpecification": {"CapacityReservationPreference": "open"}, "HibernationOptions": {"Configured": false}, "MetadataOptions": {"State": "applied", "HttpTokens": "optional", "HttpPutResponseHopLimit": 1, "HttpEndpoint": "enabled"}, "EnclaveOptions": {"Enabled": false}, "PlatformDetails": "Linux/UNIX", "UsageOperation": "RunInstances", "UsageOperationUpdateTime": "2020-04-16T09:44:16+00:00", "PrivateDnsNameOptions": {}, "MaintenanceOptions": {"AutoRecovery": "default"}}');
INSERT INTO resource(resource_id,resource_ref,account_id,resource_type_id,resource_name,last_updated,resource_metadata) VALUES (1130,'i-08a220f9238167574',1,1,'vault','2022-09-08 14:18:00','{"AmiLaunchIndex": 0, "ImageId": "ami-0c137fe9258ba462b", "InstanceId": "i-08a220f9238167574", "InstanceType": "t4g.nano", "KeyName": "pc-dev-keypair01", "LaunchTime": "2021-03-31T18:46:40+00:00", "Monitoring": {"State": "disabled"}, "Placement": {"AvailabilityZone": "eu-west-2b", "GroupName": "", "Tenancy": "default"}, "PrivateDnsName": "ip-10-184-1-7.eu-west-2.compute.internal", "PrivateIpAddress": "10.184.1.7", "ProductCodes": [], "PublicDnsName": "", "State": {"Code": 16, "Name": "running"}, "StateTransitionReason": "", "SubnetId": "subnet-05b18ff772fd0d5ab", "VpcId": "vpc-05da5d22d7bd6f8cf", "Architecture": "arm64", "BlockDeviceMappings": [{"DeviceName": "/dev/xvda", "Ebs": {"AttachTime": "2021-03-31T18:46:41+00:00", "DeleteOnTermination": true, "Status": "attached", "VolumeId": "vol-08cf5074b4b907376"}}], "ClientToken": "9b15e226-6f97-f175-594b-cabef245ce9d", "EbsOptimized": false, "EnaSupport": true, "Hypervisor": "xen", "IamInstanceProfile": {"Arn": "arn:aws:iam::011072135518:instance-profile/vault-role", "Id": "AIPAQFE7TMFPGLBRKMLCO"}, "NetworkInterfaces": [{"Attachment": {"AttachTime": "2021-03-31T18:46:40+00:00", "AttachmentId": "eni-attach-01a275f0a65c70b16", "DeleteOnTermination": true, "DeviceIndex": 0, "Status": "attached", "NetworkCardIndex": 0}, "Description": "", "Groups": [{"GroupName": "vault-instance-sg", "GroupId": "sg-008f48ac5922b195d"}, {"GroupName": "consul-instance-sg", "GroupId": "sg-0325b525a6a969d73"}], "Ipv6Addresses": [], "MacAddress": "0a:ef:b0:c0:22:cc", "NetworkInterfaceId": "eni-0cc091ed6a819490b", "OwnerId": "011072135518", "PrivateDnsName": "ip-10-184-1-7.eu-west-2.compute.internal", "PrivateIpAddress": "10.184.1.7", "PrivateIpAddresses": [{"Primary": true, "PrivateDnsName": "ip-10-184-1-7.eu-west-2.compute.internal", "PrivateIpAddress": "10.184.1.7"}], "SourceDestCheck": true, "Status": "in-use", "SubnetId": "subnet-05b18ff772fd0d5ab", "VpcId": "vpc-05da5d22d7bd6f8cf", "InterfaceType": "interface"}], "RootDeviceName": "/dev/xvda", "RootDeviceType": "ebs", "SecurityGroups": [{"GroupName": "vault-instance-sg", "GroupId": "sg-008f48ac5922b195d"}, {"GroupName": "consul-instance-sg", "GroupId": "sg-0325b525a6a969d73"}], "SourceDestCheck": true, "Tags": [{"Key": "Name", "Value": "vault"}, {"Key": "aws:autoscaling:groupName", "Value": "vault-asg"}, {"Key": "customer", "Value": "brightsolid"}, {"Key": "aws:ec2launchtemplate:version", "Value": "4"}, {"Key": "customer_code", "Value": "16BSOT01"}, {"Key": "resource_owner", "Value": "operations@brightsolid.com"}, {"Key": "project_code", "Value": "08-BSOT-931"}, {"Key": "aws:ec2launchtemplate:id", "Value": "lt-0d666b51cb384f7cb"}], "VirtualizationType": "hvm", "CpuOptions": {"CoreCount": 2, "ThreadsPerCore": 1}, "CapacityReservationSpecification": {"CapacityReservationPreference": "open"}, "HibernationOptions": {"Configured": false}, "MetadataOptions": {"State": "applied", "HttpTokens": "optional", "HttpPutResponseHopLimit": 1, "HttpEndpoint": "enabled", "HttpProtocolIpv6": "disabled", "InstanceMetadataTags": "disabled"}, "EnclaveOptions": {"Enabled": false}, "BootMode": "uefi", "PlatformDetails": "Linux/UNIX", "UsageOperation": "RunInstances", "UsageOperationUpdateTime": "2021-03-31T18:46:40+00:00", "PrivateDnsNameOptions": {}, "MaintenanceOptions": {"AutoRecovery": "default"}}');

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



