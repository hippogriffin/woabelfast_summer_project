# Key Pair for all hosts
resource "aws_key_pair" "key" {
  key_name   = "${var.environment}_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDnpuYQDSZs/wSv11ilADiWmma2veClnAjd90K/80vhJktwoCFj1cW6u777vhViy1q50cBf2M1si7Lr9k3OseHRzEcvaCFcmrq6FnVb6Hmn/anB/EllPq8Umj0SGBmofuVvqu7lxiKFzt5M5d5BsqDAgwH2MQ9KzjJLhPAHC6RCyKTuNamZ75pHxVoFYEUeK0ob+fZnwlnY/wpxhUQN7cEigEzVJGrMXicaIdz6q7KYE3jeOzHLCGJQ7Q4xi8ljJ8dutlU2/2QG6zu678H4F9oRXsQKCCyV2NqeDtQotEI1D0dHu+a2lTzQjWT28QB9aYEyN4pOYXGja/ZneAx/RJTT preproduction_key"
}
