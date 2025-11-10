# Dashboard body as JSON 
locals {
  dashboard_body = jsonencode (
{
    "widgets": [
        {
            "type": "metric",
            "x": 5,
            "y": 5,
            "width": 6,
            "height": 5,
            "properties": {
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "InstanceId", "${var.private_server_id}" ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "ap-southeast-2",
                "title": "EC2 - Private Server - CPU Utilization",
                "period": 300,
                "stat": "Maximum",
                "legend": {
                    "position": "bottom"
                }
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 5,
            "width": 5,
            "height": 5,
            "properties": {
                "metrics": [
                    [ "AWS/EC2", "CPUUtilization", "InstanceId", "${var.public_server_id}" ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "ap-southeast-2",
                "title": "EC2 - Public Server - CPU Utilization",
                "period": 300,
                "stat": "Maximum"
            }
        },
        {
            "type": "metric",
            "x": 17,
            "y": 5,
            "width": 6,
            "height": 5,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/EC2", "NetworkIn", "InstanceId", "${var.private_server_id}"],
                    [ ".", "NetworkOut", ".", "." ]
                ],
                "region": "ap-southeast-2",
                "title": "EC2 - Private Server - Network In\\Out"
            }
        },
        {
            "type": "metric",
            "x": 11,
            "y": 5,
            "width": 6,
            "height": 5,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/EC2", "NetworkIn", "InstanceId", "${var.public_server_id}" ],
                    [ ".", "NetworkOut", ".", "." ]
                ],
                "region": "ap-southeast-2",
                "title": "EC2 - Public Server - Network In\\Out"
            }
        },
        {
            "type": "metric",
            "x": 5,
            "y": 0,
            "width": 6,
            "height": 5,
            "properties": {
                "metrics": [
                    [ "AWS/RDS", "FreeableMemory", "DBInstanceIdentifier", "${var.rds_id}" ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "ap-southeast-2",
                "title": "RDS - Freeable Memory",
                "period": 300,
                "stat": "Maximum"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 5,
            "height": 5,
            "properties": {
                "metrics": [
                    [ "AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "${var.rds_id}" ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "ap-southeast-2",
                "title": "RDS - CPU Utilization",
                "period": 300,
                "stat": "Maximum"
            }
        },
        {
            "type": "metric",
            "x": 17,
            "y": 0,
            "width": 6,
            "height": 5,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", "${var.rds_id}" ]
                ],
                "region": "ap-southeast-2",
                "title": "RDS - Free Storage Space"
            }
        },
        {
            "type": "metric",
            "x": 11,
            "y": 0,
            "width": 6,
            "height": 5,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.rds_id}" ]
                ],
                "region": "ap-southeast-2",
                "title": "RDS - Database Connections"
            }
        },
        {
            "type": "metric",
            "x": 5,
            "y": 10,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "CWAgent", "LogicalDisk % Free Space", "instance", "C:", "InstanceId", "${var.public_server_id}", "ImageId", "${var.ec2_ami}", "objectname", "LogicalDisk", "InstanceType", "${var.public_server_type}" ]
                ],
                "region": "ap-southeast-2",
                "title": "EC2 - Public Server - LogicalDisk % Free Space"
            }
        },
        {
            "type": "metric",
            "x": 11,
            "y": 10,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "title": "EC2 - Private Server - LogicalDisk % Free Space",
                "metrics": [
                    [ "CWAgent", "LogicalDisk % Free Space", "instance", "C:", "InstanceId", "${var.private_server_id}", "ImageId", "${var.ec2_ami}", "objectname", "LogicalDisk", "InstanceType", "${var.private_server_type}" ]
                ],
                "region": "ap-southeast-2"
            }
        },
        {
            "type": "metric",
            "x": 17,
            "y": 10,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "title": "EC2 - Public Server - Memory % Committed Bytes In Use",
                "metrics": [
                    [ "CWAgent", "Memory % Committed Bytes In Use", "InstanceId", "${var.public_server_id}", "ImageId", "${var.ec2_ami}", "objectname", "Memory", "InstanceType", "${var.public_server_type}" ]
                ],
                "region": "ap-southeast-2"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 10,
            "width": 5,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "title": "EC2 - Private Server - Memory % Committed Bytes In Use",
                "metrics": [
                    [ "CWAgent", "Memory % Committed Bytes In Use", "InstanceId", "${var.private_server_id}", "ImageId", "${var.ec2_ami}", "objectname", "Memory", "InstanceType", "${var.private_server_type}" ]
                ],
                "region": "ap-southeast-2"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 16,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [ "AWS/AppStream", "AvailableCapacity", "Fleet", "Each-Fleet", { "region": "ap-southeast-2", "visible": false } ],
                    [ ".", "InUseCapacity", ".", ".", { "region": "ap-southeast-2", "visible": false } ],
                    [ ".", "ActiveUserSessionCapacity", ".", ".", { "region": "ap-southeast-2" } ],
                    [ ".", "AvailableUserSessionCapacity", ".", ".", { "region": "ap-southeast-2" } ],
                    [ ".", "PendingUserSessionCapacity", ".", ".", { "region": "ap-southeast-2" } ],
                    [ ".", "DesiredUserSessionCapacity", ".", ".", { "region": "ap-southeast-2" } ],
                    [ ".", "DesiredCapacity", ".", ".", { "region": "ap-southeast-2", "visible": false } ],
                    [ ".", "ActualUserSessionCapacity", ".", ".", { "region": "ap-southeast-2" } ],
                    [ ".", "RunningUserSessionCapacity", ".", ".", { "region": "ap-southeast-2", "visible": false } ],
                    [ ".", "ActualCapacity", ".", ".", { "region": "ap-southeast-2", "visible": false } ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "title": "AppStream - Available, In Use and Desired Capacity, Actual Capacity",
                "region": "ap-southeast-2",
                "period": 300,
                "stat": "Average"
            }
        }
    ]
}
  )
}

resource "aws_cloudwatch_dashboard" "care_dashboard" {
  dashboard_name = "${replace(var.customer_name, " ", "-")}${"-Dashboard"}"
  dashboard_body = local.dashboard_body
}

