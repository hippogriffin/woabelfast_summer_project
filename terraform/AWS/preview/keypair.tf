# Key Pair for all hosts on Preview environment
resource "aws_key_pair" "preview_key" {
  key_name   = "preview_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3Qztw/T/bVod+BPC4MOZQcaG3KgZBe6i7DnjrcP95/gUjd1guAvqrjmU6dWCPEd9aYFtplIefYWciv4ZJ+GHFlUv+aRgOaxvri7G+NQElkGcpHBn30YGJT8530ArIq1lx+e1CPK1c71c5UoBe6SDsJGv2vo0JYNmetMvzMi6CgJ6W5biZYy1zRKv67vkAskXxXRNNblMEUMxPgHW++0cuSUSdL3jbDDdKmINiUviDGfHqjdkJHQiA6kW25TKTedeIrrFyqraUbupKCmYyQULxCJg2x/AYA02AJ6MiKs6qmaSFEftwIjCJX/VLeAVEoI6S55D1FSsKKlfxJl2FvhUd Preview key"
}