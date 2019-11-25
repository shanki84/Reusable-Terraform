module "my_ecs" {
  source                = "../modules/source"
  region                = "${var.region}"
  env                   = "${var.env}"
  cidr-vpc              = "${var.cidr-vpc}"
  cidr-subnet           = "${var.cidr-subnet}"
  image-id              = "${var.image-id}"
  number_of_instances   = "${var.number_of_instances}"
  instance-type         = "${var.instance-type}"
  desired-capacity      = "${var.desired-capacity}"
  max_size              = "${var.max_size}"
  min_size              = "${var.min_size }"
  }
