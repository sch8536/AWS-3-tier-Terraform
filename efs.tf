resource "aws_efs_file_system" "EFS" {
  creation_token = "my-unique-creation-token"
  encrypted      = true
  performance_mode = "generalPurpose"
  
  lifecycle_policy {
    # Disable automatic backups
    transition_to_ia = "AFTER_30_DAYS"
  }

  provisioned_throughput_in_mibps = 0.0

  tags = {
    Name = "EFS-PROmet"
  }
}

# Attach the EFS instance to the security group
resource "aws_efs_mount_target" "EFS-mount-target-1" {
  security_groups = [aws_security_group.EFS-sg.id]
  file_system_id  = aws_efs_file_system.EFS.id
  subnet_id       = aws_subnet.application-subnet-1.id
  lifecycle {
    ignore_changes = [
      ip_address
    ]
  }
}

resource "aws_efs_mount_target" "EFS-mount-target-2" {
  security_groups = [aws_security_group.EFS-sg.id]
  file_system_id  = aws_efs_file_system.EFS.id
  subnet_id       = aws_subnet.application-subnet-2.id
  lifecycle {
    ignore_changes = [
      ip_address
    ]
  }
}
